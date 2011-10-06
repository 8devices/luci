#!/bin/sh

# This collection of scripts will take settings from /etc/config/meshwizard, /etc/config/freifunk
# and /etc/config/profile_<community> and setup the router to participate in wireless mesh networks

# Copyright 2011 Manuel Munz <freifunk at somakoma dot de>

# Licensed under the Apache License, Version 2.0 (the "License")
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

. /etc/functions.sh

echo "
/* Meshwizard 0.0.4 */
"

# config
export dir="/usr/bin/meshwizard"
. $dir/functions.sh

# Check which packages we have installed
export has_luci=FALSE
opkg list_installed |grep luci-mod-admin > /dev/null && export has_luci=TRUE
export has_luci_splash=FALSE
opkg list_installed |grep luci-app-splash > /dev/null && export has_luci_splash=TRUE

# Check whether we want to cleanup/restore uci config before setting new options
cleanup=$(uci -q get meshwizard.general.cleanup)
[ "$cleanup" == 1 ] && $dir/helpers/restore_default_config.sh

# Rename wifi interfaces
$dir/helpers/rename-wifi.sh

# Get community
community=$(uci -q get meshwizard.community.name || uci -q get freifunk.community.name)
[ -z "$community" ] && echo "Error: Community is not set in /etc/config/freifunk, aborting now." && exit 1
export community="$community"

# Get a list of networks we need to setup
networks=$(uci show meshwizard.netconfig | grep -v "netconfig=" | sed -e 's/meshwizard.netconfig\.\(.*\)\_.*/\1/' |sort|uniq)
export networks
[ -z "$networks" ] && echo "Error: No networks to setup could be found in /etc/config/meshwizard, aborting now." && exit 1

# Read default values (first from /etc/config/freifunk, then from /etc/config/profile_$community
# then /etc/config/meshwizard
# last will overwrite first

$dir/helpers/read_defaults.sh $community > /tmp/meshwizard.tmp
while read line; do
	export "${line//\"/}"
done < /tmp/meshwizard.tmp

# Do config
$dir/helpers/initial_config.sh
$dir/helpers/setup_dnsmasq.sh
$dir/helpers/setup_system.sh

# Configure found networks
for net in $networks; do
	# radioX devices need to be renamed
	netrenamed="${net/radio/wireless}"
	export netrenamed
	$dir/helpers/setup_network.sh $net
	$dir/helpers/setup_wifi.sh $net
	$dir/helpers/setup_olsrd.sh $net

	net_dhcp=$(uci -q get meshwizard.netconfig.${net}_dhcp)
	if [ "$net_dhcp" == 1 ]; then
		$dir/helpers/setup_dhcp.sh $net
	fi

	$dir/helpers/setup_splash.sh $net
	$dir/helpers/setup_firewall.sh $net
done

##### Reboot the router (because simply restarting services gave errors)

reboot
