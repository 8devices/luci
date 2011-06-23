#!/bin/sh
# Sets up olsrd
# arg $1 = net

net=$1

. /etc/functions.sh

. $dir/functions.sh

# Clean or delete interface defaults
handle_interfacedefaults() {
	if [ "$cleanup" == 1 ]; then
		section_cleanup olsrd.$1
	else
		if [ -z "${1/cfg[0-9a-fA-F]*/}" ]; then
			section_rename olsrd $1 InterfaceDefaults
		 fi
	fi
}

config_load olsrd
config_foreach handle_interfacedefaults InterfaceDefaults

# Setup new InterfaceDefaults

echo "    + Setup InterfaceDefaults"
uci set olsrd.InterfaceDefaults=InterfaceDefaults
set_defaults "olsr_interfacedefaults_" olsrd.InterfaceDefaults

# Delete old interface for $netrenamed
handle_interface() {
	config_get interface "$1" Interface
	if [ "$interface" == "$netrenamed" ]; then
		if [ "$cleanup" == 1 ]; then
			section_cleanup olsrd.$1
		elif [ -z "${1/cfg[0-9a-fA-F]*/}" ]; then
			section_rename olsrd $1 $netrenamed
		fi
	fi
}

config_foreach handle_interface Interface

# Setup new interface for $netrenamed

echo "    + Setup Interface"

uci set olsrd.$netrenamed=Interface

set_defaults "olsr_interface_" olsrd.$net

uci set olsrd.$netrenamed.interface="$netrenamed"
echo "    interface: $netrenamed"

# If dhcp-network is inside the mesh_network then add HNA for it
dhcprange=$(uci get meshwizard.netconfig.$net\_dhcprange)
meshnet="$(uci get profile_$community.profile.mesh_network)"

uci -q delete olsrd.${netrenamed}clients

# check if the dhcprange is inside meshnet
dhcpinmesh="$($dir/helpers/check-range-in-range.sh $dhcprange $meshnet)"

if [ "$dhcpinmesh" == 1 ]; then
	echo "    + Setting up HNA"
	uci set olsrd.${netrenamed}clients="Hna4"
	eval $(sh $dir/helpers/ipcalc-cidr.sh $dhcprange)
	uci set olsrd.${netrenamed}clients.netaddr="$NETWORK"
	uci set olsrd.${netrenamed}clients.netmask="$NETMASK"
	echo "    netaddr: $NETWORK"
	echo "    natmask: $NETMASK"
fi


# Delete nameservice, dyngw and httpinfo plugins

echo "    + Configure Plugins"
handle_plugin() {
        config_get library "$1" library
	if [ "$cleanup" == 1 ]; then
		case library in
			olsrd_*)
				section_cleanup olsrd.$1
		esac
	elif [ -z "${1/cfg[0-9a-fA-F]*/}" ]; then
		new="$(echo $library | cut -d '.' -f 1)"
		section_rename olsrd $1 $new
	fi		
}
config_foreach handle_plugin LoadPlugin

# Setup nameservice plugin
if [ -n "$profile_suffix" ]; then
	suffix=".$profile_suffix"
else
	suffix=".olsr"
fi
uci batch << EOF
set olsrd.olsrd_nameservice=LoadPlugin
set olsrd.olsrd_nameservice.library="olsrd_nameservice.so.0.3"
set olsrd.olsrd_nameservice.latlon_file="/var/run/latlon.js"
set olsrd.olsrd_nameservice.hosts_file="/var/etc/hosts.olsr"
set olsrd.olsrd_nameservice.sighup_pid_file="/var/run/dnsmasq.pid"
set olsrd.olsrd_nameservice.suffix="$suffix"
EOF

echo "    Nameservice Plugin configured."

# Setup dyngw_plain

# If Sharing of Internet is enabled then enable dyngw_plain plugin
sharenet=$(uci -q get meshwizard.general.sharenet)

if [ -n "$(uci -q get olsrd.dyngw_plain.library)" ]; then
	section_cleanup olsrd.dyngw_plain
fi

if [ "$sharenet" == 1 ]; then
	echo "    + Setup dyngw_plain"
	uci set olsrd.dyngw_plain=LoadPlugin
	uci set olsrd.dyngw_plain.ignore=0
	uci set olsrd.dyngw_plain.library="olsrd_dyn_gw_plain.so.0.4"
fi

uci commit
