tdm.talents = {}

addhook("hit","tdm.hitTalents")
function tdm.hitTalents(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
  local pid = tdm.player[id].chosentalent
  local sourceid = tdm.player[source].chosentalent
  if sourceid ~= nil then
    if sourceid.name == "Engage" or sourceid.name == "Hermes' Gun" or sourceid.name == "Critical Attack" or sourceid.name == "Heavens' Striker" or sourceid.name == "Hell's Partisan" or sourceid.name == "Meteor Shot" then
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
  local id = #tdm.talents+1
  talentData.id = idtalentData
  tdm.talents[id] =
end


dofile(tdm.directories.data.."/talents.lua")

tdm.playerTalents = {}

function tdm.isPlayerHasTalent(id, talent)
	return (tdm.playerTalents[id][talent] == nil)
end

function tdm.listPlayersMissingTalents(id)
	local talents = {}
	for _,talent in ipairs(tdm.talents) do
		if (tdm.isPlayerHasTalent(id, talent) == false) then
			talents[#talents+1] = talent
		end
	end
	return talents
end

function tdm.givePlayerRandomNewTalent(id)
	local newTalent = tdm.generateRandomNewTalent(id)
	tdm.givePlayerTalent(id, newTalent)
	return newTalent
end

function tdm.givePlayerTalent(id, talent)
	if (tdm.isPlayerHasTalent(id, talent)) then
		error(player(id,"name").." ("..id..") already has talent: "..talent.name)
	end
  tdm.playerTalents[id][talent] = true
  tdm.playerTalents[id][#tdm.playerTalents[id]+1] = talent
  print("  accepted, player aquired talent!")
  msg2(id,rgb(255,255,255).."Recieved Talent: "..rgb(255,255,128)..talent.name..rgb(0,200,0).." ("..talent.rarity..")@C")
  return true
end


function tdm.generateRandomNewTalent(id)
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
