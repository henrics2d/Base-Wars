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
	local players = player(0,"tableliving")
	for _,id in ipairs(players) do
		tdm.regeneratePlayer(id)
	end
end

function tdm.regeneratePlayer(id)
	if tdm.player[id].class == nil then
		return
	end
	if tdm.player[id].effects.combattimer > 0 then
		return
	end
	tdm.player[id].health = tdm.player[id].health + tdm.player[id].maxhealth / math.random(16,24)
	if tdm.player[id].health >= tdm.player[id].maxhealth then
		tdm.player[id].health = tdm.player[id].maxhealth
	end
	tdm.handledamage(id, 0, 0)
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

function tdm.dodgeBoostEffect()
	for _,id in ipairs(player(0,"tableliving")) do
		if tdm.player[id].class ~= nil then
			if tdm.player[id].effects.dodgeboost > 0 then
				parse("speedmod "..id.." "..tdm.player[id].speed+tdm.player[id].effects.dodgeboost)
			end
		end
	end
end

function tdm.damageBuffEffect()
	for _,id in ipairs(player(0,"tableliving")) do
		if tdm.player[id].class ~= nil then
			tdm.player[id].damagemultiplier = (tdm.player[id].effects.damagebuff / 100)	+ 1
		end 
	end
end

function tdm.onFireEffect()
	for _,id in ipairs(player(0,"tableliving")) do
		if tdm.player[id].class ~= nil then
			if tdm.player[id].effects.fire > 0 then
				if tdm.player[id].armor > 0 then
					tdm.player[id].armor = tdm.player[id].armor - 1
				else
					tdm.player[id].health = tdm.player[id].health - 1.5
					if tdm.player[id].health <= 0 then
						console.customkill(0,"Burnt to Death",id)
					end
				end
				parse("effect \"fire\" "..player(id,"x").." "..player(id,"y").." 3 3 255 165 000")
			end
		end
	end
end

function tdm.effectsCounterUpdate()
	for id,playerdata in pairs(tdm.player) do
		if playerdata.class ~= nil then
			for effect,value in pairs(playerdata.effects) do
				value = value - 0.1
				if value < 0 then
					value = 0
				end
				playerdata.effects[effect] = value
			end
		end
	end
end
