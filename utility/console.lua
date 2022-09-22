local console_metatable = {}

local function generate_argument(index, value)
	checks.requireNotNil("console parse argument "..index, value)
	local text = tostring(value)
	if (string.find(text, " ") or text == "") then
		text = "\""..text.."\""
	end
	return text
end

local function generate_arguments(...)
	local index = 0
	local arguments = ""
	for _, value in ipairs({...}) do
		index = index + 1
		arguments = arguments.." "..generate_argument(index, value)
	end
	return arguments
end

function console_metatable.__index(self, key, value)
	return function(...)
		local command = tostring(key)..""..generate_arguments(...)
		parse(command)
	end
end

console = {}
setmetatable(console, console_metatable)

dofile(tdm.directories.data.."/settings.lua")
