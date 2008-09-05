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

local io = require "io"
local util = require "luci.util"
local posix = require "posix"
local debug = require "debug"
local string = require "string"
local package = require "package"

local type, loadfile = type, loadfile


module "luci.ccache"

function cache_ondemand(...)
	if debug.getinfo(1, 'S').source ~= "=?" then
		cache_enable(...)
	end
end

function cache_enable(cachepath, mode)
	cachepath = cachepath or "/tmp/.luciccache"
	mode = mode or "r--r--r--"

	local loader = package.loaders[2]
	local uid    = posix.getpid("uid")

	if not posix.stat(cachepath) then
		posix.mkdir(cachepath)
	end

	local function _encode_filename(name)
		local encoded = ""
		for i=1, #name do
			encoded = encoded .. ("%2X" % string.byte(name, i))
		end
		return encoded
	end

	local function _load_sane(file)
		local stat = posix.stat(file)
		if stat and stat.uid == uid and stat.mode == mode then
			return loadfile(file)
		end
	end

	local function _write_sane(file, func)
		if posix.getpid("uid") == uid then
			local fp = io.open(file, "w")
			if fp then
				fp:write(util.get_bytecode(func))
				fp:close()
				posix.chmod(file, mode)
			end
		end
	end

	package.loaders[2] = function(mod)
		local encoded = cachepath .. "/" .. _encode_filename(mod)
		local modcons = _load_sane(encoded)
		
		if modcons then
			return modcons
		end

		-- No cachefile
		modcons = loader(mod)
		if type(modcons) == "function" then
			_write_sane(encoded, modcons)
		end
		return modcons
	end
end
