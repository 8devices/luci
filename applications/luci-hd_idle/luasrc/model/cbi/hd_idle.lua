--[[

LuCI hd-idle
(c) 2008 Yanira <forum-2008@email.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id$

]]--

m = Map("hd-idle", translate("hd_idle"), translate("hd_idle_desc"))

s = m:section(TypedSection, "hd-idle", translate("settings"))
s.addremove = true
s.anonymous = true

s:option(Flag, "enabled", translate("enabled", "Enable"))

s:option(Value, "disk", translate("disk")).rmempty = true

s:option(Value, "idle_time_interval", translate("idle_time_interval")).default = 10
s.rmempty = true
unit = s:option(ListValue, "idle_time_unit", translate("idle_time_unit"))
unit.default = "minutes"
unit:value("minutes", "min")
unit:value("hours", "h")
unit.rmempty = true

s:option(Flag, "enable_debug", translate("enable_debug"))

return m
