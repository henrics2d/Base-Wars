tdm.talents = {}

addhook("hit","tdm.hitTalents")
function tdm.hitTalents(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
	local pid = tdm.player[id].chosentalent
	local sourceid = tdm.player[source].chosentalent
	if sourceid ~= nil then
		if sourceid.name == "Engage" or sourceid.name == "Hermes' Gun" or sourceid.name == "Critical Attack" or sourceid.name == "Heavens' Striker" or sourceid.name == "Hell's Partisan" or sourceid.name == "Meteor Shot" or sourceid.name == "Solar Eruption" then
			sourceid.callback(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		end
		if pid.name == "Tap Dancer" or pid.name == "Swift Rebound" or pid.name == "Evasive Expert" or pid.name == "Exo-Skeleton" or pid.name == "Destructive Recovery" then
			pid.callback(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		end
	end
	return 1
end

addhook("kill","tdm.killTalents")
function tdm.killTalents(killer,victim,weapon,x,y,killerobject,assistant)
	local pid = tdm.player[victim].chosentalent
	local sourceid = tdm.player[killer].chosentalent
	if sourceid ~= nil then
		if sourceid.name == "Explosive Finish" or sourceid.name == "In Twain" or sourceid.name == "Ghost" then
			sourceid.callback(killer,victim,weapon,x,y,killerobject,assistant)
		end
	end
	return 1
end

function tdm.registerTalent(talentData)
	checks.requireType("talentData", talentData, "table")
	tdm.talents[#tdm.talents+1] = talentData
	tdm.talents[talentData.id] = talentData
end

function tdm.getTalentById(talentId)
	checks.requireType("talentId", talentId, "string")
	return tdm.talents[talentId]
end

dofile(tdm.directories.data.."/talents.lua")


function tdm.isPlayerHasTalent(id, talent)
	checks.requireType("id", id, "number")
	checks.requireType("talent", talent, "table")
	local playerdata = tdm.player[id]
	return (playerdata.talents[talent] ~= nil)
end

function tdm.listPlayersMissingTalents(id)
	checks.requireType("id", id, "number")
	local talents = {}
	for _,talent in ipairs(tdm.talents) do
		if (tdm.isPlayerHasTalent(id, talent) == false) then
			talents[#talents+1] = talent
		end
	end
	return talents
end

function tdm.listPlayersTalents(id)
	checks.requireType("id", id, "number")
	local talents = {}
	for talent,_ in pairs(tdm.player[id].talents) do
		talents[#talents + 1] = talent
	end
	return talents
end

function tdm.givePlayerRandomNewTalent(id)
	checks.requireType("id", id, "number")
	local newTalent = tdm.generateRandomNewTalent(id)
	if (newTalent == nil) then
		return nil
	end
	tdm.givePlayerTalent(id, newTalent)
	return newTalent
end

function tdm.givePlayerTalent(id, talent)
	checks.requireType("id", id, "number")
	checks.requireType("talent", talent, "table")
	if (tdm.isPlayerHasTalent(id, talent)) then
		error(player(id,"name").." ("..id..") already has talent: "..talent.name)
	end
	local playerdata = tdm.player[id]
	playerdata.talents[talent] = true
	print("	accepted, player aquired talent!")
	local rarity = talent.rarity
	msg2(id,rgb(255,255,255).."Recieved Talent: "..rgb(255,255,128)..talent.name..rgb(255,255,255).." ("..rarity.color..rarity.name..rgb(255,255,255)..")@C")
	return true
end


function tdm.generateRandomNewTalent(id)
	checks.requireType("id", id, "number")
	local missingTalents = tdm.listPlayersMissingTalents(id)
	if (#missingTalents == 0) then
		return nil
	end
	local chances = 0
	for _,talent in ipairs(missingTalents) do
		chances = chances + talent.chance
	end
	local target = chances * math.random()
	for _,talent in ipairs(missingTalents) do
		target = target - talent.chance
		if target <= 0 then
			return talent
		end
	end
end
