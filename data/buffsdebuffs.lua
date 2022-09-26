tdm.dbtypes = {}

tdm.dbtypes.fire = {
	name = "Fire",
	duration = 5,
	image = "gfx/henristdm/buffsdebuffs/fire.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		tdm.applydb(id,tdm.dbtypes.combattag)
		console.effect("\"fire\"",player(id,"x"),player(id,"y"),4,4,255,000,000)
		if tdm.player[id].armor > 0 then
			tdm.player[id].armor = tdm.player[id].armor - 1
		else
			tdm.player[id].health = tdm.player[id].health - 1.5
			if tdm.player[id].health <= 0 then
				console.customkill(0,"Burnt to ashes",id)
			end
		end
	end,
	onDespawn = function (id) end
}

tdm.dbtypes.poison = {
	name = "Poison",
	duration = 15,
	image = "gfx/henristdm/buffsdebuffs/poison.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		tdm.applydb(id,tdm.dbtypes.combattag)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),1,1,000,255,000)
		console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),1,1,000,255,000)
		tdm.player[id].health = tdm.player[id].health - 0.3
		if tdm.player[id].health <= 0 then
			console.customkill(0,"Felt sick",id)
		end
	end,
	onDespawn = function (id) end
}

tdm.dbtypes.acid = {
	name = "Acid Venom",
	duration = 10,
	image = "gfx/henristdm/buffsdebuffs/acid.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		tdm.applydb(id,tdm.dbtypes.combattag)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),1,1,170,000,225)
		console.effect("\"smoke\"",player(id,"x"),player(id,"y"),1,1,000,255,000)
		tdm.player[id].health = tdm.player[id].health - 1.2
		if tdm.player[id].armor > 0 then
			tdm.player[id].armor = tdm.player[id].armor - 3
		end
		if tdm.player[id].health <= 0 then
			console.customkill(0,"Melted into a mushy pile of flesh",id)
		end
	end,
	onDespawn = function (id) end
}

tdm.dbtypes.combattag = {
	name = "Combat Tag",
	duration = 5,
	image = "gfx/henristdm/buffsdebuffs/combat.png",
	onCreate = function (id) end,
	onUpdate = function (db,id) end,
	onDespawn = function (id) end
}

tdm.dbtypes.brimstone = {
	name = "Brimstone Fire",
	duration = 8,
	image = "gfx/henristdm/buffsdebuffs/brimstone.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		tdm.applydb(id,tdm.dbtypes.combattag)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),1,1,255,000,000)
		console.effect("\"colorsmoke\"",player(id,"x"),player(id,"y"),1,3,255,000,000)
		tdm.player[id].health = tdm.player[id].health - 4
		if tdm.player[id].health <= 0 then
			console.customkill(0,"Burnt to holy ashes",id)
		end
	end,
	onDespawn = function (id) end
}

tdm.dbtypes.endurance = {
	name = "Endurance",
	duration = 8,
	image = "gfx/henristdm/buffsdebuffs/endurance.png",
	onCreate = function (id) end,
	onUpdate = function (db,id) end,
	onDespawn = function (id) end
}

tdm.dbtypes.dodge = {
	name = "Dodge-Frames",
	duration = 6,
	image = "gfx/henristdm/buffsdebuffs/dodge.png",
	onCreate = function (id)
		console.equip(id,84)
	end,
	onUpdate = function (db,id) end,
	onDespawn = function (id)
		console.strip(id,84)
	end
}

tdm.dbtypes.immunity = {
	name = "Immunity-Frames",
	duration = 1,
	image = "gfx/henristdm/buffsdebuffs/immunity.png",
	onCreate = function (id) end,
	onUpdate = function (db,id) end,
	onDespawn = function (id) end
}

tdm.dbtypes.swiftness = {
	name = "Swiftness",
	duration = 8,
	image = "gfx/henristdm/buffsdebuffs/swiftness.png",
	onCreate = function (id) end,
	onUpdate = function (db,id) end,
	onDespawn = function (id) end
}

tdm.dbtypes.strength = {
	name = "Strength",
	duration = 3,
	image = "gfx/henristdm/buffsdebuffs/strength.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		tdm.player[id].damagemultiplier = tdm.player[id].damagemultiplier + 0.25
	end,
	onDespawn = function (id)
		tdm.player[id].damagemultiplier = tdm.player[id].damagemultiplier - 0.25
	end
}
