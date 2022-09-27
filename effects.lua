addhook("second","tdm.solarAngelParticles")
function tdm.solarAngelParticles()
	for _,id in ipairs(player(0,"tableliving")) do
		if tdm.player[id].class == nil then
			return
		end
		if tdm.player[id].class.name == "Solar Angel" or tdm.player[id].chosentalent.name == "Blessing of the Solar Angel" then
			console.effect("\"flare\"",player(id,"x"),player(id,"y"),2,2,255,255,128)
		end
		if tdm.player[id].chosentalent.name == "Curse of the Brimstone Witch" then
			console.effect("\"flare\"",player(id,"x"),player(id,"y"),3,3,255,000,000)
			console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),1,1,255,000,000)
		end
	end
end

addhook("select","tdm.solarAngelCosmetics")
function tdm.solarAngelCosmetics(id,type,mode)
  if tdm.player[id].class == nil then
    return
  end
  if tdm.player[id].class.name == "Solar Angel" then
    if type == 50 then
      freeimage(tdm.player[id].knifeimage)
      tdm.player[id].knifeimage = image(images.."solarsword.png", 3, 0, 200 + id)
    else
      freeimage(tdm.player[id].knifeimage)
      tdm.player[id].knifeimage = image(images.."solarswordholstered.png", 3, 0, 200 + id)
    end
  end
end

function tdm.regeneration()
	for _,id in ipairs(player(0,"tableliving")) do
		tdm.regeneratePlayer(id)
	end
end

function tdm.regeneratePlayer(id)
	if tdm.player[id].class == nil then
		return
	end
	if tdm.finddb(id,tdm.dbtypes.combattag) ~= nil then
		return
	end
	if tdm.player[id].chosentalent.name == "Curse of the Dead-King" then
		return
	end
	tdm.player[id].health = tdm.player[id].health + (tdm.player[id].maxhealth / math.random(24,30))
	if tdm.player[id].health >= tdm.player[id].maxhealth then
		tdm.player[id].health = tdm.player[id].maxhealth
	end
end

addbind("space")
addhook("key","tdm.key")
function tdm.key(id,key,state)
	if tdm.player[id].class == nil then
		return
	end
	if tdm.player[id].class.gadget == nil then
		return
	end
	if (key == "space") then
		tdm.gadgets(id,tdm.player[id].class.gadget,tdm.player[id].class.gadget.cooldown)
	end
end

function tdm.gadgets(id,type,cooldown)
	if type == nil then
		return
	end
	if tdm.player[id].abilitycooldown > 0 then
		return
	end
	type.callback(id)
	tdm.player[id].abilitycooldown = tdm.player[id].abilitycooldown + cooldown
end

function tdm.abilityCountdown()
	for _,id in ipairs(player(0,"tableliving")) do
		if tdm.player[id].class ~= nil then
			tdm.player[id].abilitycooldown = tdm.player[id].abilitycooldown - 0.1
			if tdm.player[id].abilitycooldown < 0 then
				tdm.player[id].abilitycooldown = 0
			end
		end
	end
end
