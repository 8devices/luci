--[[

UCI Validation Layer - Dependency helper
(c) 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>
(c) 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id$

]]--

module( "luci.uvl.dependencies", package.seeall )

local ERR = luci.uvl.errors

function _parse_reference( r, c, s, o )
	local ref  = { }
	local vars = {
		config  = ( c or '$config'  ),
		section = ( s or '$section' ),
		option  = ( o or '$option'  )
	}

	for i, v in ipairs(luci.util.split(r,".")) do
		table.insert(ref, (v:gsub( "%$(.+)", function(n) return vars[n] end )))
	end

	if c or s then
		if #ref == 1 and c and s then
			ref = { c, s, ref[1] }
		elseif #ref == 2 and c then
			ref = { c, unpack(ref) }
		elseif #ref ~= 3 then
			ref = nil
		end
	else
		if #ref == 1 then
			ref = { '$config', '$section', ref[1] }
		elseif #ref == 2 then
			ref = { '$config', unpack(ref) }
		elseif #ref ~= 3 then
			ref = nil
		end
	end

	return ref
end

function _serialize_dependency( dep, v )
	local str

	for k, v in luci.util.spairs( dep,
		function(a,b)
			a = ( type(dep[a]) ~= "boolean" and "_" or "" ) .. a
			b = ( type(dep[b]) ~= "boolean" and "_" or "" ) .. b
			return a < b
		end
	) do
		str = ( str and str .. " and " or "" ) .. k ..
			( type(v) ~= "boolean" and "=" .. v or "" )
	end

	return str
end

function check( self, object, nodeps )

	local derr = ERR.DEPENDENCY(object)

	if not self.beenthere[object:cid()] then
		self.beenthere[object:cid()] = true
	else
		return false, derr:child(ERR.DEP_RECURSIVE(object))
	end

	if object:scheme('depends') then
		local ok    = true
		local valid = false

		for _, dep in ipairs(object:scheme('depends')) do
			local subcondition = true
			for k, v in pairs(dep) do
				-- XXX: better error
				local ref = _parse_reference( k, unpack(object.cref) )

				if not ref then
					return false, derr:child(ERR.SME_BADDEP(object,k))
				end

				local option = luci.uvl.option( self, object.c, unpack(ref) )

				valid, err = self:_validate_option( option, true )
				if valid then
					if not (
						( type(v) == "boolean" and option:value() ) or
						( ref[3] and option:value() ) == v
					) then
						subcondition = false

						local depstr = _serialize_dependency( dep, v )
						derr:child(
							type(v) == "boolean"
								and ERR.DEP_NOVALUE(option, depstr)
								or  ERR.DEP_NOTEQUAL(option, {depstr, v})
						)

						break
					end
				else
					subcondition = false

					local depstr = _serialize_dependency( dep, v )
					derr:child(ERR.DEP_NOTVALID(option, depstr):child(err))

					break
				end
			end

			if subcondition then
				ok = true
				break
			else
				ok = false
			end
		end

		if not ok then
			return false, derr
		end
	else
		return true
	end

	if object:scheme("type") == "enum" and
	   object:scheme("enum_depends")[object:value()]
	then
		local ok    = true
		local valid = false
		local enum  = object:enum()
		local eerr  = ERR.DEP_BADENUM(enum)

		for _, dep in ipairs(enum:scheme('enum_depends')[object:value()]) do
			local subcondition = true
			for k, v in pairs(dep) do
				-- XXX: better error
				local ref = _parse_reference( k, unpack(object.cref) )

				if not ref then
					return false, derr:child(eerr:child(ERR.SME_BADDEP(enum,k)))
				end

				local option = luci.uvl.option( self, object.c, unpack(ref) )

				valid, err = self:_validate_option( option, true )
				if valid then
					if not (
						( type(v) == "boolean" and object.config[ref[2]][ref[3]] ) or
						( ref[3] and object:config() ) == v
					) then
						subcondition = false

						local depstr = _serialize_dependency( dep, v )
						eerr:child(
							type(v) == "boolean"
								and ERR.DEP_NOVALUE(option, depstr)
								or  ERR.DEP_NOTEQUAL(option, {depstr, v})
						)

						break
					end
				else
					subcondition = false

					local depstr = _serialize_dependency( dep, v )
					eerr:child(ERR.DEP_NOTVALID(option, depstr):child(err))

					break
				end
			end

			if subcondition then
				return true
			else
				ok = false
			end
		end

		if not ok then
			return false, derr:child(eerr)
		end
	end

	return true
end
