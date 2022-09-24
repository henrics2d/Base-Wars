tdm.dbtypes = {}

tdm.dbtypes.combattag = {
	name = "Combat Tag Debuff",
	duration = 5,
	image = "gfx/henristdm/buffsdebuffs/combat.png",
	onCreate = function(db)
	end,
	onUpdate = function(db)
	end,
	onDespawn = function(db)
	end
}

tdm.dbtypes.fire = {
	name = "Fire Debuff",
	duration = 5,
	image = "gfx/henristdm/buffsdebuffs/fire.png",
	onCreate = function(db)
	end,
	onUpdate = function(db)
		tdm.onFireEffect(db.holder)
	end,
	onDespawn = function(db)
	end
}

tdm.dbtypes.poison = {
	name = "Poison Debuff",
	duration = 20,
	image = "gfx/henristdm/buffsdebuffs/poison.png",
	onCreate = function(db)
	end,
	onUpdate = function(db)
		tdm.onPoisonEffect(db.holder)
	end,
	onDespawn = function(db)
	end
}
