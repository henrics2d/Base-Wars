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

--Made by EnderCrypt

--misc

misc = {}

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
