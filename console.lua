local console_metatable = {}

local function generate_argument(value)
	local text = tostring(value)
	if (string.find(text, " ")) then
		text = "\""..text.."\""
	end
	return text
end

local function generate_arguments(...)
	local arguments = ""
	for _, value in ipairs({...}) do
		arguments = arguments.." "..generate_argument(value)
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
