tdm.registerTalent({
  id = "armorregain",
  name = "Engage",
  rarity = tdm.rarity.legendary,
  chance = 10,
  description = "Regain armor when dealing damage, scales with your weapon's damage",
  description2 = "In a ratio of 1:8",
  healthbonus = 3,
  speedbonus = 0,
  damagebonus = 0.02,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    tdm.player[source].armor = tdm.player[source].armor + (hpdmg * 0.125)
    parse("effect \"colorsmoke\" "..player(source,"x").." "..player(source,"y").." 1 1 100 100 255")
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
  healthbonus = 25,
  speedbonus = 0,
  damagebonus = 0,
  callback = nil,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "speedonhit",
  name = "Hermes' Gun",
  rarity = tdm.rarity.common,
  chance = 100,
  description = "Gain a very slight speed boost for shooting people",
  description2 = "Speed gain depends on the damage done",
  healthbonus = 1,
  speedbonus = 1,
  damagebonus = 0.01,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    tdm.player[source].speed = tdm.player[source].speed + (hpdmg * 0.0015)
    parse("speedmod "..source.." "..tdm.player[source].speed)
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
  description2 = "Critical attacks deal 1.25x damage",
  healthbonus = 3,
  speedbonus = 0,
  damagebonus = 0.05,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 10 then
      tdm.handledamage(id, source, hpdmg*0.25)
      parse("effect \"flare\" "..player(id,"x").." "..player(id,"y").." 5 5 255 000 000")
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
  healthbonus = 5,
  speedbonus = 1,
  damagebonus = 0,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 10 then
      tdm.player[id].effects.immunityframes = 0.15
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
  healthbonus = 6,
  speedbonus = 1,
  damagebonus = 0.01,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 15 then
      parse("effect \"colorsmoke\" "..player(id,"x").." "..player(id,"y").." 25 30 128 128 128")
      tdm.player[id].effects.immunityframes = 0.15
      tdm.player[id].effects.dodgeboost = 8
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
  description2 = "15% chance of occuring everytime you hit someone",
  healthbonus = 5,
  speedbonus = 0,
  damagebonus = 0.06,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 15 then
      tdm.handledamage(id, source, hpdmg*1.25)
      parse("effect \"flare\" "..player(id,"x").." "..player(id,"y").." 60 30 255 255 000")
    end
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "chancetododgesecondupgrade",
  name = "Evasive Expert",
  rarity = tdm.rarity.legendary,
  chance = 10,
  description = "Increases your dodge chances",
  description2 = "Also increases your speed boost on dodge",
  healthbonus = 7,
  speedbonus = 2,
  damagebonus = 0.02,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 20 then
      parse("effect \"colorsmoke\" "..player(id,"x").." "..player(id,"y").." 25 30 128 128 128")
      tdm.player[id].effects.immunityframes = 0.15
      tdm.player[id].effects.dodgeboost = 13
    end
  end,
  prerequirment = 6,
  owned = false
})

tdm.registerTalent({
  id = "damageresistance",
  name = "Exo-Skeleton",
  rarity = tdm.rarity.legendary,
  chance = 10,
  description = "You naturally resist 15% of all damage",
  description2 = "Also comes with an extra 20 hp!",
  healthbonus = 20,
  speedbonus = 0,
  damagebonus = 0,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    tdm.player[id].effects.resistancebuff = 30
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "damageonhit",
  name = "Destructive Recovery",
  rarity = tdm.rarity.legendary,
  chance = 10,
  description = "Deal more damage the more you are hit",
  description2 = "5% extra damage per hit (stacks up to 60%)",
  healthbonus = 8,
  speedbonus = 1,
  damagebonus = 0,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    tdm.player[id].effects.damagebuff = tdm.player[id].effects.damagebuff + 5
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
  healthbonus = 1,
  speedbonus = 0,
  damagebonus = 0.04,
  callback = function(killer,victim,weapon,x,y,killerobject,assistant)
    parse("explosion "..player(victim,"x").." "..player(victim,"y").." 125 60 "..killer)
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
  description2 = "Immunity lasts 1.5 seconds",
  healthbonus = 5,
  speedbonus = 0,
  damagebonus = 0.02,
  callback = function(killer,victim,weapon,x,y,killerobject,assistant)
    tdm.player[killer].effects.immunityframes = 1.5
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "dodgeondeath",
  name = "Ghost",
  rarity = tdm.rarity.legendary,
  chance = 10,
  description = "Gain 6 seconds of dodge frames for 6 seconds",
  description2 = "Dodge frames give you a 50% chance of dodging an attack",
  healthbonus = 0,
  speedbonus = 3,
  damagebonus = 0.02,
  callback = function(killer,victim,weapon,x,y,killerobject,assistant)
    tdm.player[killer].effects.dodgeframes = 6
  end,
  prerequirment = 5,
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
  speedbonus = 5,
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
  healthbonus = 10,
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
  speedbonus = 10,
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
  healthbonus = 50,
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
  healthbonus = 20,
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
  description2 = "Extinguishes enemy fire on succesful fiery hits",
  healthbonus = 4,
  speedbonus = 1,
  damagebonus = 0.03,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if tdm.player[id].effects.fire > 0 then
      tdm.spawnprojectile(source,tdm.entitytypes.burningspear)
      tdm.player[id].effects.fire = 0
    end
    if hpdmg >= 40 then
      tdm.spawnprojectile(source,tdm.entitytypes.burningspear)
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
  description2 = "Deals 4 damage per second to targets",
  healthbonus = 6,
  speedbonus = 0,
  damagebonus = 0.03,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    tdm.player[id].effects.fire = 3
  end,
  prerequirment = nil,
  owned = false
})

tdm.registerTalent({
  id = "spearonhit",
  name = "Solar Eruption",
  rarity = tdm.rarity.blessing,
  chance = 4,
  description = "Hitting an enemy has a 20% chance of throwing a follow up solar javelin",
  description2 = "Also comes with a cool solar halo cosmetic!",
  healthbonus = 15,
  speedbonus = 2,
  damagebonus = 0.1,
  callback = function(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
    if math.random(1,100) <= 20 then
      tdm.spawnprojectile(source,tdm.entitytypes.solarspear)
    end
  end,
  prerequirment = nil,
  owned = false
})
