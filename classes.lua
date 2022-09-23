tdm.classestable = {}

--[[
classes.lua

rankreq = the rank required to unlock this class 
unique = is this class chooseable from the spawn menu?
name = name of the class
description = first line of the class' description
description2 = second line of the class' description
health = the class' health value (can be regenerated, damaged, dinked)
maxhealth = the class' max health value (static)
armorpoints = the class' armor value (can be damaged, dinked, buffed via a defender by default)
armorid = id of the armor that is used (eg.: 1 for Basic Vest, 3 for Full Body Armor)
damagemultiplier = damage multiplication that this class will apply to all its weapons (eg.: 1.33 will buff damage by 33%)
basespeed = the class' speedmod
img = image used by the class for identification, nil for none (relate to gfx/henristdm/)
gadget = the class' ability, space to use, nil for none
onSpawn = run these commands for the id that spawned with said class
]]

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 1,
	unique = false,
	name = "Soldier",
	description = "A powerful soldier with no special abilities and moderate health",
	description2 = "Spawns with both an AK47 and M4A1",
	health = 125,
	maxhealth = 125,
	armorpoints = 100,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = 0,
	img = nil,
	gadget = nil,
	onSpawn = function(id)
		if player(id, "team") == 1 then
			parse("strip "..id.." 2")
		else
			parse("strip "..id.." 1")
		end
		parse("equip "..id.." 30")
		parse("equip "..id.." 32")
		parse("equip "..id.." 51")
		parse("equip "..id.." 3")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 3,
	unique = false,
	name = "Scout",
	description = "A very fast soldier with a shotgun and low health",
	description2 = "Can increase his speed and damage momentarily",
	health = 100,
	maxhealth = 100,
	armorpoints = 80,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = 8,
	img = "cap.png",
	gadget = {
		name = "Scout's Boost",
		cooldown = 15,
		callback = function(id)
			msg2(id,rgb(255,0,0).."I feel hyper!@C")
			parse("effect \"flare\" "..player(id,"x").." "..player(id,"y").." 5 25 255 000 000")
			tdm.player[id].damagemultiplier = 1.40
			parse("speedmod "..id.." 32")
			timer2(5000,{id},function(id)
				msg2(id,rgb(255,0,0).."Boost over.@C")
				parse("speedmod "..id.." 8")
				tdm.player[id].damagemultiplier = 1
			end)
		end
	},
	onSpawn = function(id)
		parse("strip "..id.." ".."2")
		parse("strip "..id.." ".."1")
		parse("equip "..id.." ".."3")
		parse("equip "..id.." ".."10")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 3,
	unique = false,
	name = "Heavy",
	description = "A heavily armored soldier with lots of armor",
	description2 = "Comes with a M249 but alike the soldier, no special abilities",
	health = 125,
	maxhealth = 125,
	armorpoints = 300,
	armorid = 6,
	damagemultiplier = 1,
	basespeed = -4,
	img = "heavy.png",
	gadget = nil,
	onSpawn = function(id)
		if player(id, "team") == 1 then
			parse("strip "..id.." ".."2")
			parse("equip "..id.." ".."3")
		else
			parse("strip "..id.." ".."1")
			parse("equip "..id.." ".."4")
		end
		parse("equip "..id.." ".."40")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 4,
	unique = false,
	name = "Defender",
	description = "An extremely tanky half cyborg thats capable of providing buffs to his comrades",
	description2 = "Comes only with a Five-Seven",
	health = 200,
	maxhealth = 200,
	armorpoints = 200,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = -6,
	img = "cyborg.png",
	gadget = {
		name = "Mega-Shield MK2",
		cooldown = 30,
		callback = function(id)
			tdm.spawnprojectile(id,tdm.entitytypes.megashield)
		end
	},
	onSpawn = function(id)
		if player(id, "team") == 1 then
			parse("strip "..id.." ".."2")
		else
			parse("strip "..id.." ".."1")
		end
		parse("equip "..id.." 6")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 5,
	unique = false,
	name = "Commando",
	description = "A veteran of war with a AUG Bullpup and a singular airstrike",
	description2 = "Can increase the damage of his allies momentarily, aswell as his own",
	health = 100,
	maxhealth = 100,
	armorpoints = 100,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = 2,
	img = "badge.png",
	gadget = {
		name = "Call to Arms",
		cooldown = 60,
		callback = function(id)
			msg(rgb(255,0,0).."Commando "..player(id,"name").." has called to arms!")
			parse("effect \"flare\" "..player(id,"x").." "..player(id,"y").." 15 25 255 000 000")
			for _,victim in ipairs(player(0,"tableliving")) do
				local px = player(id,"x")
				local py = player(id,"y")
				local dx = math.abs(player(victim,"x")-px)
				local dy = math.abs(player(victim,"y")-py)
				local dist = dx + dy
				if dist <= 128 then
					if player(id,"team") == player(victim,"team") then
						tdm.player[victim].damagemultiplier = 1.25
						timer2(7500,{id},function(id)
							tdm.player[victim].damagemultiplier = 1
						end)
					end
				end
			end
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."76")
		parse("equip "..id.." ".."33")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 5,
	unique = false,
	name = "Sniper",
	description = "A trained professional with an anti-material sniper rifle",
	description2 = "Can penetrate the armor of vehicles with his rifle, aswell as momentarily increase his speed to escape dire situations",
	health = 100,
	maxhealth = 100,
	armorpoints = 40,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = 3,
	img = "sniper.png",
	gadget = {
		name = "Escape Plan",
		cooldown = 30,
		callback = function(id)
			parse("effect \"smoke\" "..player(id,"x").." "..player(id,"y").." 50 30 255 000 000")
			tdm.player[id].immunityframes = 0.5
			parse("speedmod "..id.." 25")
			timer2(4000,{id},function(id)
				parse("speedmod "..id.." 0")
			end)
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."35")
		parse("equip "..id.." ".."52")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 7,
	unique = false,
	name = "Assassin",
	description = "A flanker with a deadly machete and scout sniper rifle",
	description2 = "Can one-shot anyone in a small timeframe using his ability",
	health = 85,
	maxhealth = 85,
	armorpoints = 35,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = 11,
	img = "assassin.png",
	gadget = {
		name = "Nail-Biting Accuracy",
		cooldown = 35,
		callback = function(id)
			parse("effect \"flare\" "..player(id,"x").." "..player(id,"y").." 5 25 255 000 000")
			tdm.player[id].damagemultiplier = 100
			msg2(id,rgb(255,0,0).."Focus, Concentrate!@C")
			timer2(1000,{id},function(id)
				tdm.player[id].damagemultiplier = tdm.player[id].class.damagemultiplier
				msg2(id,rgb(255,0,0).."Kill period over.@C")
			end)
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."69")
		parse("equip "..id.." ".."34")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 9,
	unique = false,
	name = "Automaton",
	description = "A rogue automaton robot with many gadgets at his disposal",
	description2 = "Can generate molotovs and gas grenades for area denial",
	health = 50,
	maxhealth = 50,
	armorpoints = 500,
	armorid = 5,
	damagemultiplier = 1,
	basespeed = 1,
	img = "automaton.png",
	gadget = {
		name = "Refill Supply",
		cooldown = 10,
		callback = function(id)
			parse("equip "..id.." 51")
			parse("equip "..id.." 73")
			parse("equip "..id.." 72")
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."20")
		parse("equip "..id.." ".."73")
		parse("equip "..id.." ".."72")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 10,
	unique = false,
	name = "Medic",
	description = "A medic that can heal both in an area and single targets",
	description2 = "Not completely defenseless however...",
	health = 150,
	maxhealth = 150,
	armorpoints = 0,
	armorid = 1,
	damagemultiplier = 1,
	basespeed = 4,
	img = "medic.png",
	gadget = {
		name = "Healing Beacon",
		cooldown = 30,
		callback = function(id)
			tdm.spawnprojectile(id,tdm.entitytypes.hbeacon)
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."22")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 10,
	unique = false,
	name = "Demolitionist",
	description = "A mercenary that can use both rockets and grenades",
	description2 = "His ability fires a powerful impact grenade thats capable of causing heavy damage to vehicles",
	health = 140,
	maxhealth = 140,
	armorpoints = 40,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = -3,
	img = "demo.png",
	gadget = {
		name = "Impact Grenade",
		cooldown = 10,
		callback = function(id)
			tdm.spawnprojectile(id,tdm.entitytypes.igrenade)
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." ".."48")
		parse("equip "..id.." ".."49")
		parse("equip "..id.." ".."51")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 12,
	unique = true,
	name = "Necromancer",
	description = "(VERY UNFINISHED) An experienced magician in the art of reviving the dead",
	description2 = "His ability allows him to spawn hordes of weak minions",
	health = 75,
	maxhealth = 75,
	armorpoints = 0,
	armorid = 1,
	damagemultiplier = 1,
	basespeed = 5,
	img = "necro.png",
	gadget = {
		name = "Summon Minions",
		cooldown = 15,
		callback = function(id)
		end
	},
	onSpawn = function(id)
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 12,
	unique = true,
	name = "Godfather",
	description = "(VERY UNFINISHED) A top rank mafia member",
	description2 = "His ability allows him to call forth a mafioso to aid you in battle",
	health = 110,
	maxhealth = 110,
	armorpoints = 60,
	armorid = 2,
	damagemultiplier = 1,
	basespeed = -2,
	img = "mafia.png",
	gadget = {
		name = "Summon Mafioso",
		cooldown = 15,
		callback = function(id)
		end
	},
	onSpawn = function(id)
		parse("equip "..id.." 38")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 1,
	unique = true,
	name = "Dreadnaut",
	description = "Basically a walking tank...",
	description2 = "Very tanky albeit slow, uses a M134 along with his abilities",
	health = 350,
	maxhealth = 350,
	armorpoints = 450,
	armorid = 4,
	damagemultiplier = 1,
	basespeed = -9,
	img = "juggernaut.png",
	gadget = nil,
	onSpawn = function(id)
		parse("equip "..id.." 90")
		parse("equip "..id.." 47")
		parse("strip "..id.." 1")
		parse("strip "..id.." 2")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 1,
	unique = true,
	name = "Juggernaut",
	description = "Boasts level 4 armor for cheap",
	description2 = "Very tanky albeit slow, uses a M249 along with his abilities",
	health = 200,
	maxhealth = 200,
	armorpoints = 250,
	armorid = 4,
	damagemultiplier = 1,
	basespeed = -9,
	img = "minijug.png",
	gadget = nil,
	onSpawn = function(id)
		parse("equip "..id.." 40")
		parse("strip "..id.." 1")
		parse("strip "..id.." 2")
	end,
}

tdm.classestable[#tdm.classestable+1] = {
	rankreq = 1,
  unique = true,
  name = "Solar Angel",
  description = "Throw your solar javelins to tear your foes asunder!",
  description2 = "Limited to use his sword and ability only",
	health = 600,
	maxhealth = 600,
  armorpoints = 400,
  armorid = 7,
  damagemultiplier = 1.5,
	basespeed = 3,
  img = "solarangel.png",
  gadget = {
    name = "Solar Javelin",
    cooldown = 4,
    callback = function(id)
      tdm.spawnprojectile(id,tdm.entitytypes.solarspear)
    end
  },
  onSpawn = function(id)
    parse("strip "..id.." 1")
    parse("strip "..id.." 2")
  end,
}

function tdm.getRandomClass()
	local index = math.ceil(math.random() * #tdm.classestable)
	return tdm.classestable[index]
end
