addhook("hit","tdm.healthHitSystem")
function tdm.healthHitSystem(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
	if player(id,"team") == player(source,"team") then
		return 1
	end
	local damage = hpdmg
	if itemtype(weapon,"dmg") ~= "" and weapon >= 1 and weapon <= 100 then
		damage = itemtype(weapon,"dmg")
	end
	if source > 0 then
		damage = damage * tdm.player[source].damagemultiplier
	end
	if weapon == 73 then
		tdm.applydb(id,tdm.dbtypes.fire)
	end
	tdm.handledamage(id,source,damage)
	tdm.applydb(id,tdm.dbtypes.combattag)
	return 1
end

function tdm.handledamage(id, source, damage)
	if damage > 0 then
		if tdm.finddb(id,tdm.dbtypes.endurance) ~= nil then
			damage = damage * 0.85
		end
		if tdm.finddb(id,tdm.dbtypes.immunity) ~= nil or tdm.finddb(id,tdm.dbtypes.falseimmunity) ~= nil then
			console.effect("\"smoke\"",player(id,"x"),player(id,"y"),10,10,0,128,255)
			damage = 0
		end
		if tdm.finddb(id,tdm.dbtypes.dodge) ~= nil then
			if math.random(1,100) <= 50 then
				console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),15,15,255,255,255)
				damage = 0
			end
		end
		if tdm.player[id].armor > 0 then
			tdm.onarmorhit(id, source, damage)
		else
			tdm.onbrokenarmor(id, source, damage)
		end
		if tdm.player[id].armor <= 0 then
			tdm.player[id].armor = 0
		end
		if tdm.player[id].health <= 0 then
			console.customkill(source,tdm.generateRandomDeath(),id)
		end
	end
	if source > 0 then
		tdm.player[source].target = id
	end
	tdm.getPercentHealth(id)
end

function tdm.getPercentHealth(id)
	local percent = (tdm.player[id].health / tdm.player[id].maxhealth) * 100
	if percent > 1 then
		console.sethealth(id,math.ceil(percent))
	end
	return percent
end

function tdm.onbrokenarmor(id, source, damage)
	if damage > 0 then
		tdm.player[id].health = tdm.player[id].health - damage
		tdm.player[id].armor = tdm.player[id].armor - damage
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),1,1,255,100,100)
		console.sv_sound2(id,"henristdm/hphit.wav")
	end
end

function tdm.onarmorhit(id, source, damage)
	if damage < tdm.player[id].armortype.resistance then
		tdm.player[id].armor = tdm.player[id].armor - tdm.player[id].armortype.damageondink * (damage * 0.01)
		tdm.player[id].health = tdm.player[id].health - tdm.player[id].armortype.damageonresist * (damage * 0.01)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),1,1,0,0,255)
		console.sv_sound2(id,"henristdm/armordink.wav")
		console.sv_sound2(source,"henristdm/armordink.wav")
	else
		tdm.onbrokenarmor(id, source, damage)
	end
end
