--[[

HTTP server implementation for LuCI - luci handler
(c) 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id$

]]--

module("luci.httpd.handler.luci", package.seeall)

require("luci.dispatcher")
require("luci.http")
require("luci.http.protocol.date")
require("ltn12")

Luci = luci.util.class(luci.httpd.module.Handler)
Response = luci.httpd.module.Response

function Luci.__init__(self)
	luci.httpd.module.Handler.__init__(self)
end

function Luci.handle_head(self, ...)
	local response, sourceout = self:handle_get(...)
	return response
end

function Luci.handle_post(self, ...)
	return self:handle_get(...)
end

function Luci.handle_get(self, request, sourcein, sinkerr)
	local r = luci.http.Request(
		request.env,
		sourcein,
		sinkerr
	)

	local res, id, data1, data2 = true, 0, nil, nil
	local headers = {}
	local status = 200

	local x = coroutine.create(luci.dispatcher.httpdispatch)
	while not id or id < 3 do
		coroutine.yield()

		res, id, data1, data2 = coroutine.resume(x, r)

		if not res then
			status = 500
			headers["Content-Type"] = "text/plain"
			local err = {id}
			return Response( status, headers ), function() return table.remove(err) end
		end

		if id == 1 then
			status = data1
		elseif id == 2 then
			headers[data1] = data2
		end
	end

	local function iter()
		local res, id, data = coroutine.resume(x)
		if not res then
			return nil, id
		elseif not id then
			return true
		elseif id == 5 then
			return nil
		else
			return data
		end
	end

	headers["Expires"] = luci.http.protocol.date.to_http( os.time() )
	headers["Date"]    = headers["Expires"]

	return Response(status, headers), iter
end
