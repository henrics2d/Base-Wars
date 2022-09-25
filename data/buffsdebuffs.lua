tdm.dbtypes = {}

tdm.dbtypes.fire = {
	name = "Fire",
	duration = 10,
	image = "gfx/henristdm/buffsdebuffs/fire.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),15,50,255,000,000)
	end,
	onDespawn = function (id) end
}

tdm.dbtypes.poison = {
	name = "Poison",
	duration = 10,
	image = "gfx/henristdm/buffsdebuffs/fire.png",
	onCreate = function (id) end,
	onUpdate = function (db,id)
		console.effect("\"flare\"",player(id,"x"),player(id,"y"),15,50,000,255,000)
	end,
	onDespawn = function (id) end
}
