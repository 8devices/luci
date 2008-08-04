--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
m = Map("firewall", translate("fw_fw"), translate("fw_fw1"))

s = m:section(TypedSection, "defaults")
s.anonymous = true

s:option(Flag, "syn_flood")

p = {}
p[1] = s:option(ListValue, "input")
p[2] = s:option(ListValue, "output")
p[3] = s:option(ListValue, "forward")

for i, v in ipairs(p) do
	v:value("DROP", translate("fw_drop"))
	v:value("ACCEPT", translate("fw_accept"))
end


s = m:section(TypedSection, "zone", translate("fw_zones"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

name = s:option(Value, "name", translate("name"))
name.size = 8

p = {}
p[1] = s:option(ListValue, "input")
p[2] = s:option(ListValue, "output")
p[3] = s:option(ListValue, "forward")

for i, v in ipairs(p) do
	v:value("DROP", translate("fw_drop"))
	v:value("ACCEPT", translate("fw_accept"))
end

s:option(Flag, "masq")

net = s:option(MultiValue, "network")
net.widget = "select"
net.rmempty = true
luci.model.uci.foreach("network", "interface",
	function (section)
		if section[".name"] ~= "loopback" then
			net:value(section[".name"])
		end
	end)
	
function net.cfgvalue(self, section)
	local value = MultiValue.cfgvalue(self, section)
	return value or name:cfgvalue(section)
end

return m