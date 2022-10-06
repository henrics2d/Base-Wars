function initArray(m)
	local array = {}
	for i = 1, m do
		array[i] = 0
	end
	return array
end

function rightpadding(text)
	while string.len(text) < 3 do
		text = "0"..text
	end
	return text
end

function rgb(red,green,blue)
	red = rightpadding(red)
	green = rightpadding(green)
	blue = rightpadding(blue)
	return "\169"..red..green..blue
end

dofile(tdm.directories.utility.."/timer2.lua")
dofile(tdm.directories.utility.."/checks.lua")
dofile(tdm.directories.utility.."/EnderCryptSaveEngine.lua")
dofile(tdm.directories.utility.."/custommenus.lua")
dofile(tdm.directories.utility.."/console.lua")

--Made by EnderCrypt

--misc

misc = {}

function misc.stringsplit(text, separator)
	if (text == nil) then
		return {}
	end
	local results = {}
	for sequence in string.gmatch(text, "([^"..separator.."]+)") do
		results[#results + 1] = sequence
	end
	return results
end

function misc.round(num,base)
	if base == nil then
		return math.floor(num+0.5)
	else
		if base > 0 then
			base = math.pow(10,base)
		end
		return math.floor((num*base)+0.5)/base
	end
end

function misc.pixel_to_tile(pixel)
	return misc.round((pixel-16)/32)
end


function misc.tile_to_pixel(tile)
	return (tile*32)+16
end


function misc.lengthdir_x(dir,length)
	return math.cos(math.rad(dir - 90))*length
end


function misc.lengthdir_y(dir,length)
	return math.sin(math.rad(dir - 90))*length
end

-- originally created by: http://gmc.yoyogames.com/index.php?showtopic=433253
-- modified and converted to lua by Endercrypt
function misc.turnTowards(direction, targetDir, turnspeed)
    angdiff = misc.angleDiffrence(direction, targetDir)--((((direction - wdir) % 360) + 540) % 360) - 180;
    return (direction - math.min(math.max(angdiff,-turnspeed),turnspeed)) % 360
end

function misc.angleDiffrence(dir, dir2)
    return ((((dir - dir2) % 360) + 540) % 360) - 180;
end

-- calculate the direction beetween 2 points
function misc.point_direction(x1,y1,x2,y2)
	return -math.deg(math.atan2(x1-x2,y1-y2))
end

-- calculate the distance beetween 2 points
function misc.point_distance(x1,y1,x2,y2)
	return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end

function tdm.find_entity(name)
	local list=entitylist()
	for _,e in pairs(list) do
		 if entity(e.x,e.y,"name") == name then
			 return e
		 end
	end
	return nil
end


function tdm.find_entity_types(typename)
	local result = {}
	local list=entitylist()
	for _,e in pairs(list) do
		 if entity(e.x,e.y,"typename") == typename then
			 result[#result + 1] = e
		 end
	end
	return result
end

function tdm.random_array_value(t)
	local index = math.ceil(#t * math.random())
	return t[index]
end
