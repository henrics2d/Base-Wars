tdm.registerTalent({
	id = "armorregain",
	name = "Engage",
	rarity = tdm.rarity.legendary,
	chance = 10,
	description = "Regain armor when dealing damage, scales with your weapon's damage",
	description2 = "In a ratio of 1:3",
	healthbonus = 0.05,
	speedbonus = 0,
	damagebonus = 0.02,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			tdm.player[source].armor = tdm.player[source].armor + (hpdmg * 0.33)
			console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),1,1,0,128,255)
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "extrahealth",
	name = "Healthpack",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "It's just extra health",
	description2 = "What else do you need?",
	healthbonus = 0.15,
	speedbonus = 0,
	damagebonus = 0,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "speedonhit",
	name = "Hermes' Gun",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Gain a slight speed boost for shooting people",
	description2 = "Speed gain depends on the damage done",
	healthbonus = 0.025,
	speedbonus = 1,
	damagebonus = 0.04,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		tdm.player[source].speed = tdm.player[source].speed + (hpdmg * 0.015)
		console.speedmod(source,tdm.player[source].speed + (hpdmg * 0.015))
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "chanceforextradamage",
	name = "Critical Attack",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "Gain the ability to perform random critical attacks",
	description2 = "Critical attacks deal 1.6x damage",
	healthbonus = 0.015,
	speedbonus = 0,
	damagebonus = 0.05,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if math.random(1,100) <= 10 then
			tdm.handledamage(id, source, hpdmg*0.60)
			console.effect("\"flare\"",player(id,"x"),player(id,"y"),5,5,255,0,0)
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "chancetododge",
	name = "Tap Dancer",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "Gain a very slight chance to dodge attacks",
	description2 = "After a succesful dodge gain a brief period of immunity",
	healthbonus = 0.025,
	speedbonus = 1,
	damagebonus = 0,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if math.random(1,100) <= 10 then
			tdm.applydb(id,tdm.dbtypes.falseimmunity)
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "chancetododgeupgrade",
	name = "Swift Rebound",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Basically Tap Dancer but better",
	description2 = "Gain a speed boost after a succesful dodge",
	healthbonus = 0.03,
	speedbonus = 1,
	damagebonus = 0.01,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if math.random(1,100) <= 15 then
			console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),25,30,180,180,180)
			tdm.applydb(id,tdm.dbtypes.falseimmunity)
			tdm.applydb(id,tdm.dbtypes.swiftness)
		end
	end,
	prerequirment = 5,
	owned = false
})

tdm.registerTalent({
	id = "chanceforextradamageupgrade",
	name = "Heavens' Striker",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Call forth a strike from the heavens on your opponents",
	description2 = "Has a chance of occuring everytime you hit someone",
	healthbonus = 0.028,
	speedbonus = 0,
	damagebonus = 0.06,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			if math.random(1,150) <= (hpdmg / 0.8)  then
				tdm.handledamage(id, source, hpdmg*1.5)
				console.effect("\"flare\"",player(id,"x"),player(id,"y"),60,30,255,255,255)
			end
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "damageresistance",
	name = "Exo-Skeleton",
	rarity = tdm.rarity.legendary,
	chance = 10,
	description = "You naturally resist 15% of all damage",
	description2 = "Also comes with an extra 10% hp!",
	healthbonus = 0.1,
	speedbonus = 0,
	damagebonus = 0,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		tdm.applydb(id,tdm.dbtypes.endurance)
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "damageonhit",
	name = "Destructive Recovery",
	rarity = tdm.rarity.legendary,
	chance = 10,
	description = "Recover from damage dealt by dealing even more damage back",
	description2 = "Applies the strength buff on hit",
	healthbonus = 0.08
	speedbonus = 1,
	damagebonus = 0.03,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		tdm.applydb(id,tdm.dbtypes.strength)
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "explosionondeath",
	name = "Explosive Finish",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Create an explosion whenever you kill someone",
	description2 = "The explosion happens on their death location, deals mild damage",
	healthbonus = 0.01,
	speedbonus = 0,
	damagebonus = 0.04,
	callback = function(killer,victim,weapon,x,y,killerobject,assistant)
		console.explosion(player(victim,"x"),player(victim,"y"),125,60,killer)
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "immunityondeath",
	name = "In Twain",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Gain a brief period of immunity after killing someone",
	description2 = "Immunity lasts 2 seconds",
	healthbonus = 0.025,
	speedbonus = 0,
	damagebonus = 0.02,
	callback = function(killer,victim,weapon,x,y,killerobject,assistant)
		tdm.applydb(killer,tdm.dbtypes.immunity)
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "dodgeondeath",
	name = "Ghost",
	rarity = tdm.rarity.legendary,
	chance = 10,
	description = "Gain 6 seconds of dodge frames on kill",
	description2 = "Dodge frames give you a 50% chance of dodging an attack",
	healthbonus = 0,
	speedbonus = 3,
	damagebonus = 0.02,
	callback = function(killer,victim,weapon,x,y,killerobject,assistant)
		tdm.applydb(killer,tdm.dbtypes.dodge)
	end,
	prerequirment = 5,
	owned = false
})

tdm.registerTalent({
	id = "poisononhit",
	name = "Poison Shot",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "All your attacks apply the Poison debuff",
	description2 = "Slowly degrades health, ignoring armor",
	healthbonus = 0.03,
	speedbonus = 0,
	damagebonus = 0.03,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			tdm.applydb(id,tdm.dbtypes.poison)
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "increaseddamage",
	name = "Scoped Gun",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "Just an extra 8% damage to all your weapons",
	description2 = "What else do you need?",
	healthbonus = 0,
	speedbonus = 0,
	damagebonus = 0.08,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "increasedspeed",
	name = "Scout's Will",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "Just a basic speed boost increase",
	description2 = "What else do you need?",
	healthbonus = 0,
	speedbonus = 3,
	damagebonus = 0,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "increasedstats",
	name = "The Jack of All Trades",
	rarity = tdm.rarity.common,
	chance = 100,
	description = "A basic boost to all stats",
	description2 = "What else do you need?",
	healthbonus = 0.05,
	speedbonus = 2,
	damagebonus = 0.05,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "speedbonusupgrade",
	name = "The Runner",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "A good increase to your speed",
	description2 = "What else do you need?",
	healthbonus = 0,
	speedbonus = 7,
	damagebonus = 0,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "healthbonusupgrade",
	name = "The Tank",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "A good increase to your health",
	description2 = "What else do you need?",
	healthbonus = 0.2,
	speedbonus = 0,
	damagebonus = 0,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "damagebonusupgrade",
	name = "The Bullseye",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "A good increase to your damage",
	description2 = "What else do you need?",
	healthbonus = 0,
	speedbonus = 0,
	damagebonus = 0.12,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "statsincreaseupgrade",
	name = "All in One",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "A good increase to all your stats",
	description2 = "What else do you need?",
	healthbonus = 0.13,
	speedbonus = 4,
	damagebonus = 0.07,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "globaltalent",
	name = "Pathfinder",
	rarity = tdm.rarity.global,
	chance = 0,
	description = "The talent everyone starts out with",
	description2 = "Does nothing",
	healthbonus = 0,
	speedbonus = 0,
	damagebonus = 0,
	callback = nil,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "spearondeath",
	name = "Hell's Partisan",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "Hitting an enemy whos on fire or with 40+ damage causes you to throw a followup burning spear",
	description2 = "Burning spears move even through walls",
	healthbonus = 0.02,
	speedbonus = 1,
	damagebonus = 0.03,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			if tdm.finddb(id,tdm.dbtypes.fire) ~= nil then
				tdm.spawnprojectile(source,tdm.entitytypes.burningspear)
			end
			if hpdmg >= 40 then
				tdm.spawnprojectile(source,tdm.entitytypes.burningspear)
			end
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
	id = "fireonhit",
	name = "Meteor Shot",
	rarity = tdm.rarity.rare,
	chance = 30,
	description = "All your attacks apply the On Fire! debuff",
	description2 = "Eats through armor and health alike!",
	healthbonus = 0.03,
	speedbonus = 0,
	damagebonus = 0.03,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			tdm.applydb(id,tdm.dbtypes.fire)
		end
	end,
	prerequirment = nil,
	owned = false
})

tdm.registerTalent({
  id = "spearonhit",
  name = "Blessing of the Solar Angel",
  rarity = tdm.rarity.blessing,
  chance = 4,
  description = "Hitting an enemy has a chance of throwing a follow up solar javelin",
  description2 = "Also comes with a cool solar halo cosmetic!",
  healthbonus = 0.1,
  speedbonus = 2,
  damagebonus = 0.1,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
	    if math.random(1,150) <= hpdmg then
	      tdm.spawnprojectile(source,tdm.entitytypes.solarspear)
	    end
		end
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "curseonhit",
  name = "Curse of the Brimstone Witch",
  rarity = tdm.rarity.curse,
  chance = 4,
  description = "Hitting an enemy has a chance of throwing a brimstone blast or applying the Brimstone Flames debuff",
  description2 = "However, this debuff also has a low chance of being applied to yourself, comes with a cosmetic",
  healthbonus = 0,
  speedbonus = 2,
  damagebonus = 0.15,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
	    if math.random(1,100) <= hpdmg then
	      tdm.spawnprojectile(source,tdm.entitytypes.brimstoneblast)
	    end
			if math.random(1,150) <= hpdmg then
	      tdm.applydb(id,tdm.dbtypes.brimstone)
	    end
			if math.random(1,2500) <= hpdmg then
				tdm.applydb(source,tdm.dbtypes.brimstone)
	    end
		end
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "curseonkill",
  name = "Curse of the Dead-King",
  rarity = tdm.rarity.curse,
  chance = 4,
  description = "Killing an enemy steals their life energy and refills you to max health and increases your max health by a bit",
  description2 = "However, you cannot regenerate life normally",
  healthbonus = 0.12,
  speedbonus = 2,
  damagebonus = 0.05,
  callback = function(killer,victim,weapon,x,y,killerobject,assistant)
		tdm.player[killer].maxhealth = tdm.player[killer].maxhealth + (tdm.player[killer].maxhealth * 0.05)
    tdm.player[killer].health = tdm.player[killer].maxhealth
		if tdm.player[killer].maxhealth >= 1000 then
			tdm.player[killer].maxhealth = 1000
			tdm.player[killer].health = 1000
		end
		console.effect("\"colorsmoke\"",player(killer,"x"),player(killer,"y"),25,30,255,000,000)
		console.effect("\"flare\"",player(killer,"x"),player(killer,"y"),25,30,255,000,000)
		console.effect("\"colorsmoke\"",player(victim,"x"),player(victim,"y"),25,30,255,000,000)
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
	id = "poisononhitupgrade",
	name = "Cobra",
	rarity = tdm.rarity.legendary,
	chance = 10,
	description = "All your attacks apply the Acid Venom debuff",
	description2 = "Acid Venom eats through armor quickly and makes short work of health",
	healthbonus = 0.05,
	speedbonus = 0,
	damagebonus = 0.07,
	callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
		if weapon >= 1 and weapon <= 100 then
			tdm.applydb(id,tdm.dbtypes.acid)
		end
	end,
	prerequirment = nil,
	owned = false
})
