addhook("spawn","tdm.bots")
function tdm.bots(id)
	if player(id,"bot") then
		tdm.deletePlayerClass(id)
		tdm.setPlayerClass(id,tdm.getRandomClass())
		tdm.player[id].chosentalent = tdm.generateRandomNewTalent(id)
		if tdm.player[id].class.unique then
			tdm.bots(id)
			console.strip(id, 47)
			console.strip(id, 90)
			console.strip(id, 11)
			console.strip(id, 40)
		end
		local spawn = tdm.getBotSpawnEntity(id)
		console.setpos(id, misc.tile_to_pixel(spawn.x), misc.tile_to_pixel(spawn.y))
	end
end

function tdm.getBotSpawnEntity(id)
	checks.requireType("id", id, "number")
	local team = player(id,"team")
	if team == 1 then
		return tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
	end
	if team == 2 then
		return tdm.random_array_value(tdm.find_entity_types("Env_Item"))
	end
	error("player "..id.." is in unknown team: "..team)
end
