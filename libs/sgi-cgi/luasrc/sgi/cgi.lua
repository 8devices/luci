--[[
LuCI - SGI-Module for CGI

Description:
Server Gateway Interface for CGI

FileId:
$Id$

License:
Copyright 2008 Steven Barth <steven@midlink.org>

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
module("luci.sgi.cgi", package.seeall)
require("ltn12")
require("luci.http")
require("luci.sys")
require("luci.dispatcher")

function run()
	local r = luci.http.Request(
		luci.sys.getenv(),
		ltn12.source.file(io.stdin),
		ltn12.sink.file(io.stderr)
	)
	
	local x = coroutine.create(luci.dispatcher.httpdispatch)
	
	while coroutine.status(x) ~= "dead" do
		local res, id, data1, data2 = coroutine.resume(x, r)

		if not res then
			print("Status: 500 Internal Server Error")
			print("Content-Type: text/plain\n")
			print(id)
			break;
		end
		
		if id == 1 then
			io.write("Status: " .. tostring(data1) .. " " .. data2 .. "\n")
		elseif id == 2 then
			io.write(data1 .. ": " .. data2 .. "\n")
		elseif id == 3 then
			io.write("\n")
		elseif id == 4 then
			io.write(data1)
		end
		
	end
end
