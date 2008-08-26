--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

-- Data init --

local wireless = luci.model.uci.cursor_state():get_all("wireless")
local wifidata = luci.sys.wifi.getiwconfig()
local ifaces = {}

for k, v in pairs(wireless) do
	if v[".type"] == "wifi-iface" then
		table.insert(ifaces, v)
	end
end


-- Main Map --

m = Map("wireless", translate("wifi"), translate("a_w_devices1"))
m:chain("network")


-- Status Table --
s = m:section(Table, ifaces, translate("networks"))

link = s:option(DummyValue, "_link", translate("link"))
function link.cfgvalue(self, section)
	local ifname = self.map:get(section, "ifname")
	return wifidata[ifname] and wifidata[ifname]["Link Quality"] or "-"
end

essid = s:option(DummyValue, "ssid", "ESSID")

bssid = s:option(DummyValue, "_bsiid", "BSSID")
function bssid.cfgvalue(self, section)
	local ifname = self.map:get(section, "ifname")
	return (wifidata[ifname] and (wifidata[ifname].Cell 
	 or wifidata[ifname]["Access Point"])) or "-"
end

channel = s:option(DummyValue, "channel", translate("channel"))
function channel.cfgvalue(self, section)
	return wireless[self.map:get(section, "device")].channel
end

protocol = s:option(DummyValue, "_mode", translate("protocol"))
function protocol.cfgvalue(self, section)
	local mode = wireless[self.map:get(section, "device")].mode
	return mode and "802." .. mode
end

mode = s:option(DummyValue, "mode", translate("mode"))
encryption = s:option(DummyValue, "encryption", translate("iwscan_encr"))

power = s:option(DummyValue, "_power", translate("power"))
function power.cfgvalue(self, section)
	local ifname = self.map:get(section, "ifname")
	return wifidata[ifname] and wifidata[ifname]["Tx-Power"] or "-"
end

scan = s:option(Button, "_scan", translate("scan"))
scan.inputstyle = "find"

function scan.cfgvalue(self, section)
	return self.map:get(section, "ifname") or false
end

-- WLAN-Scan-Table --

t2 = m:section(Table, {}, translate("iwscan"), translate("iwscan1"))

function scan.write(self, section)
	t2.render = t2._render
	local ifname = self.map:get(section, "ifname")
	luci.util.update(t2.data, luci.sys.wifi.iwscan(ifname))
end

t2._render = t2.render
t2.render = function() end

t2:option(DummyValue, "Quality", translate("iwscan_link"))
essid = t2:option(DummyValue, "ESSID", "ESSID")
function essid.cfgvalue(self, section)
	return luci.util.pcdata(self.map:get(section, "ESSID"))
end

t2:option(DummyValue, "Address", "BSSID")
t2:option(DummyValue, "Mode", translate("mode"))
chan = t2:option(DummyValue, "channel", translate("channel"))
function chan.cfgvalue(self, section)
	return self.map:get(section, "Channel")
	    or self.map:get(section, "Frequency")
	    or "-"
end 

t2:option(DummyValue, "Encryption key", translate("iwscan_encr"))

t2:option(DummyValue, "Signal level", translate("iwscan_signal"))

t2:option(DummyValue, "Noise level", translate("iwscan_noise"))


-- Config Section --

s = m:section(TypedSection, "wifi-device", translate("devices"))

en = s:option(Flag, "disabled", translate("enable"))
en.enabled = "0"
en.disabled = "1"

function en.cfgvalue(self, section)
	return Flag.cfgvalue(self, section) or "0"
end


mode = s:option(ListValue, "mode", translate("mode"))
mode:value("", "standard")
mode:value("11b", "802.11b")
mode:value("11g", "802.11g")
mode:value("11a", "802.11a")
mode:value("11bg", "802.11b+g")
mode.rmempty = true

ch = s:option(Value, "channel", translate("a_w_channel"))
for i=1, 14 do
	ch:value(i, i .. " (2.4 GHz)")
end


s = m:section(TypedSection, "wifi-iface", translate("m_n_local"))
s.anonymous = true

s:option(Value, "ssid", translate("a_w_netid")).maxlength = 32

local devs = {}
luci.model.uci.cursor():foreach("wireless", "wifi-device",
	function (section)
		table.insert(devs, section[".name"])
	end)
	
if #devs > 1 then
	device = s:option(DummyValue, "device", translate("device"))
else
	s.defaults.device = devs[1]
end

mode = s:option(ListValue, "mode", translate("mode"))
mode:value("ap", translate("m_w_ap"))
mode:value("adhoc", translate("m_w_adhoc"))
mode:value("sta", translate("m_w_client"))

function mode.write(self, section, value)
	if value == "sta" then
		-- ToDo: Move this away
		if not m.uci:get("network", "wan") then
			m.uci:set("network", "wan", "proto", "none")
			m.uci:set("network", "wan", "ifname", " ")
		end

		local oldif = m.uci:get("network", "wan", "ifname")
		if oldif and oldif ~= " " then
			m.uci:set("network", "wan", "_ifname", oldif)
		end
		m.uci:set("network", "wan", "ifname", " ")

		self.map:set(section, "network", "wan")
	else
		if m.uci:get("network", "wan", "_ifname") then
			m.uci:set("network", "wan", "ifname", m.uci:get("network", "wan", "_ifname"))
		end
		self.map:set(section, "network", "lan")
	end

	return ListValue.write(self, section, value)
end

encr = s:option(ListValue, "encryption", translate("encryption"))
encr:value("none", "keine")
encr:value("wep", "WEP")
encr:value("psk", "WPA-PSK")
encr:value("wpa", "WPA-Radius")
encr:value("psk2", "WPA2-PSK")
encr:value("wpa2", "WPA2-Radius")

key = s:option(Value, "key", translate("key"))
key:depends("encryption", "wep")
key:depends("encryption", "psk")
key:depends("encryption", "wpa")
key:depends("encryption", "psk2")
key:depends("encryption", "wpa2")
key.rmempty = true

server = s:option(Value, "server", translate("a_w_radiussrv"))
server:depends("encryption", "wpa")
server:depends("encryption", "wpa2")
server.rmempty = true

port = s:option(Value, "port", translate("a_w_radiusport"))
port:depends("encryption", "wpa")
port:depends("encryption", "wpa2")
port.rmempty = true

iso = s:option(Flag, "isolate", translate("a_w_apisolation"), translate("a_w_apisolation1"))
iso.rmempty = true
iso:depends("mode", "ap")

hide = s:option(Flag, "hidden", translate("a_w_hideessid"))
hide.rmempty = true
hide:depends("mode", "ap")

return m