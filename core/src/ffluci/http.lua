--[[
FFLuCI - HTTP-Interaction

Description:
HTTP-Header manipulator and form variable preprocessor

FileId:
$Id$

ToDo:
- Cookie handling

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

module("ffluci.http", package.seeall)

if ENV and ENV.HASERLVER then
	require("ffluci.sgi.haserl")
end