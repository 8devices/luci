--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
arg[1] = arg[1] or ""
m = Map("firewall", translate("firewall_rule"), translate("firewall_rule_desc"))

s = m:section(NamedSection, arg[1], "rule", "")
s.anonymous = true

name = s:option(Value, "_name", translate("name")..translate("cbi_optional"))
name.rmempty = true

iface = s:option(ListValue, "src", translate("firewall_rule_src"))
iface.rmempty = true

oface = s:option(ListValue, "dest", translate("firewall_rule_dest"))
oface:value("")
oface.optional = true

luci.model.uci.cursor():foreach("firewall", "zone",
	function (section)
		iface:value(section.name)
		oface:value(section.name)
	end)

proto = s:option(ListValue, "proto", translate("protocol"))
proto.optional = true
proto:value("")
proto:value("tcpudp", "TCP+UDP")
proto:value("tcp", "TCP")
proto:value("udp", "UDP")
proto:value("icmp", "ICMP")

s:option(Value, "src_ip", translate("firewall_rule_srcip")).optional = true
s:option(Value, "dest_ip", translate("firewall_rule_destip")).optional = true
s:option(Value, "src_mac", translate("firewall_rule_srcmac")).optional = true

sport = s:option(Value, "src_port", translate("firewall_rule_srcport"))
sport.optional = true
sport:depends("proto", "tcp")
sport:depends("proto", "udp")
sport:depends("proto", "tcpudp")

dport = s:option(Value, "dest_port", translate("firewall_rule_destport"))
dport.optional = true
dport:depends("proto", "tcp")
dport:depends("proto", "udp")
dport:depends("proto", "tcpudp")

jump = s:option(ListValue, "target", translate("firewall_rule_target"))
jump.rmempty = true
jump.default = "ACCEPT"
jump:value("DROP", translate("fw_drop"))
jump:value("ACCEPT", translate("fw_accept"))
jump:value("REJECT", translate("fw_reject"))


return m
