--[[
LuCI - Network model - 6to4 & 6in4 protocol extension

Copyright 2011 Jo-Philipp Wich <xm@subsignal.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

]]--

local netmod = luci.model.network
local proto  = luci.util.class(netmod.proto.generic)

netmod.IFACE_PATTERNS_VIRTUAL[#netmod.IFACE_PATTERNS_VIRTUAL+1] = "^6to4-%w"
netmod.IFACE_PATTERNS_VIRTUAL[#netmod.IFACE_PATTERNS_VIRTUAL+1] = "^6in4-%w"

function proto.__init__(self, name)
	self.sid = name
end

function proto.ifname(self)
	return self:proto() .. "-" .. self.sid
end

function proto.is_floating(self)
	return true
end

function proto.is_virtual(self)
	return true
end

function proto.get_interfaces(self)
	return nil
end

function proto.contains_interface(self, ifname)
	return (netmod:ifnameof(ifc) == self:ifname())
end


netmod.proto["6to4"] = proto
netmod.proto["6in4"] = proto
