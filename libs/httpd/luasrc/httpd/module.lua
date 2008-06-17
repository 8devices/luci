--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
module("luci.httpd.module", package.seeall)
require("luci.util")
require("ltn12")



-- Server handler implementation
Handler = luci.util.class()

-- Constructor
function Handler.__init__(self)
	self.filters = {}
end


-- Adds a filter to the filter chain
function Handler.addfilter(self, filter)
	table.insert(self.filters, filter)
end


-- Creates a failure reply
function Handler.failure(self, message)
	response = {
		status = 500,
		headers = {
			["Content-Type"] = "text/plain"
		}
	}
	
	sourceout = ltn12.source.string(message)
	
	return response, sourceout 
end


-- Processes a request
function Handler.process(self, request, sourcein, sinkout, sinkerr)
	-- Process incoming filters
	for i, f in ipairs(self.filters) do
		local i = f:get("input")
		
		if i then
			sourcein = ltn12.source.chain(sourcein, i) 
		end
		
		if f.request then
			f:request(request)
		end
	end
	
	-- Run the handler
	local stat, response, sourceout = luci.util.copcall(
		self.handle, self, request, sourcein, sinkerr
	)
	
	-- Check for any errors
	if not stat then
		response, sourceout = self:failure(response)
	end
	
	-- Check data
	if not luci.util.instanceof(response, Response) then
		response, sourceout = self:failure("Core error: Invalid module response!")
	end
	
	-- Process outgoing filters
	for i, f in ipairs(self.filters) do
		local o = f:get("output")
		
		if o then
			sourceout = ltn12.source.chain(sourceout, o) 
		end
		
		if f.response then
			f:response(response)
		end
	end
	
	
	-- Print status and headers
	sinkout("HTTP/1.1 " .. response.status .. " " .. statusmsg[response.status] .. "\n")
	for k, v in pairs(response.headers) do
		sinkout(k .. ": " .. v .. "\n")
	end
	
	-- End of Headers
	sinkout("\n")
	
	-- Pump content
	if sourceout then
		ltn12.pump.all(sourceout, sinkout)
	end
end



-- Server Filter implementation
Filter = luci.util.class()

function Filter.get(self, name)
	return self[name] and function(...) return self[name](self, ...) end
end

-- Filters the incoming body stream
-- abstract function Filter.input(chunk)

-- Filters the outgoing body stream
-- abstract function Filter.output(chunk)

-- Filters the request object
-- abstract function Filter.request(request)

-- Filters the response object
-- abstract function Filter.response(response)



-- Handler Response 
Response = luci.util.class()

function Response.__init__(self, status, headers)
	self.status = tonumber(status) or 200
	self.headers = (type(headers) == "table") and headers or {}
end

function Response.addheader(self, key, value)
	self.headers[key] = value
end

function Response.setstatus(self, status)
	self.status = status
end


-- Status codes
statusmsg = {
	[200] = "OK",
	[404] = "Not Found",
	[500] = "Internal Server Error",
}