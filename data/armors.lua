tdm.armorstable = {}

--[[
armors.lua

id = id of the armor
name = name of the armor
description = description of the armor (unused for now)
resistance = how much damage is needed to pierce through this armor (equal or higher value will deal full damage on hit)
damageondink = how much damage the armor takes when it succesfully resists a shot (100 FOR FULL DAMAGE)
damageonresist = how much health damage the player takes when their armor succesfully resists a shot (100 FOR FULL DAMAGE)

]]

tdm.armorstable[#tdm.armorstable+1] = {
	id = 1,
	name = "Basic Vest",
	description = "Can't fully stop even small arms fire",
	resistance = 15,
	damageondink = 30,
	damageonresist = 20
}

tdm.armorstable[#tdm.armorstable+1] = {
	id = 2,
	name = "Kevlar Vest",
	description = "Can stop most small arms fire",
	resistance = 20,
	damageondink = 18,
	damageonresist = 15
}

tdm.armorstable[#tdm.armorstable+1] = {
	id = 3,
	name = "Full Body Armor",
	description = "Small arms fire do almost nothing, besides sniper rifles",
	resistance = 35,
	damageondink = 12,
	damageonresist = 5
}

tdm.armorstable[#tdm.armorstable+1] = {
	id = 4,
	name = "Juggernaut Armor",
	description = "Only explosives will go through this one",
	resistance = 100,
	damageondink = 9,
	damageonresist = 5
}

tdm.armorstable[#tdm.armorstable+1] = {
	id = 5,
	name = "Automaton Construct Armor",
	description = "Piercing should be effective",
	resistance = 35,
	damageondink = 40,
	damageonresist = 5
}

tdm.armorstable[#tdm.armorstable+1] = {
	id = 6,
	name = "Heavy Armor Suit",
	description = "Lots of it but not that effective",
	resistance = 25,
	damageondink = 14,
	damageonresist = 15
}

tdm.armorstable[#tdm.armorstable+1] = {
  id = 7,
  name = "Solar Armor",
  description = "Extremely hot!",
  resistance = 35,
  damageondink = 2,
  damageonresist = 20
}
