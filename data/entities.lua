tdm.entitytypes = {}

tdm.entitytypes.igrenade = {
	name = "Impact Grenade",
	image = "gfx/henristdm/inade.png",
	speed = 32,
	lifetime = 5,
	size = 12,
	onCreate = function(entity)
		entity.rotate = true
	end,
	onUpdate = function(entity)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") ~= player(id, "team")) then
			tdm.handledamage(id, entity.owner, 125)
			tdm.applydb(id,tdm.dbtypes.combattag)
			entity.alive = false
		end
	end,
	onWallCollision = function(entity)
		entity.alive = false
	end,
	onDespawn = function(entity)
		console.explosion(entity.position.x,entity.position.y,85,150,entity.owner)
	end
}

tdm.entitytypes.burningspear = {
	name = "Burning Spear",
	image = "gfx/henristdm/burningspear.png",
	speed = 50,
	lifetime = 5,
	size = 12,
	onCreate = function(entity)
	end,
	onUpdate = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,2,4,255,128,000)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") ~= player(id, "team")) then
			tdm.handledamage(id, entity.owner, 80)
			tdm.applydb(id,tdm.dbtypes.combattag)
			tdm.applydb(id,tdm.dbtypes.fire)
			entity.alive = false
		end
	end,
	onWallCollision = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,6,12,255,128,000)
	end,
	onDespawn = function(entity)
		console.explosion(entity.position.x,entity.position.y,50,0,entity.owner)
	end
}

tdm.entitytypes.solarspear = {
	name = "Solar Spear",
	image = "gfx/henristdm/solarspear.png",
	speed = 60,
	lifetime = 5,
	size = 18,
	onCreate = function(entity)
	end,
	onUpdate = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,5,5,255,255,128)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") ~= player(id, "team")) then
			tdm.handledamage(id, entity.owner, 100)
			tdm.applydb(id,tdm.dbtypes.combattag)
			tdm.applydb(id,tdm.dbtypes.fire)
			entity.alive = false
		end
	end,
	onWallCollision = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,10,15,255,255,128)
	end,
	onDespawn = function(entity)
		console.explosion(entity.position.x,entity.position.y,65,15,entity.owner)
	end
}

tdm.entitytypes.brimstoneblast = {
	name = "Brimstone Blast",
	image = "gfx/henristdm/brimstone.png",
	speed = 52,
	lifetime = 2,
	size = 21,
	onCreate = function(entity)
	end,
	onUpdate = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,3,3,255,000,000)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") ~= player(id, "team")) then
			tdm.handledamage(id, entity.owner, 125)
			tdm.applydb(id,tdm.dbtypes.combattag)
			tdm.applydb(id,tdm.dbtypes.brimstone)
			entity.alive = false
		end
	end,
	onWallCollision = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,10,15,000,000,000)
	end,
	onDespawn = function(entity)
		console.explosion(entity.position.x,entity.position.y,65,40,entity.owner)
	end
}

tdm.entitytypes.hbeacon = {
	name = "Healing Beacon",
	image = "gfx/henristdm/beacon.png",
	speed = 0,
	lifetime = 20,
	size = 60,
	onCreate = function(entity)
		entity.rotate = true
	end,
	onUpdate = function(entity)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") == player(id, "team")) then
			tdm.player[id].health = tdm.player[id].health + (tdm.player[id].maxhealth / 20)
			tdm.player[entity.owner].health = tdm.player[entity.owner].health + math.random(7,13)
			if tdm.player[id].health >= tdm.player[id].maxhealth then
				tdm.player[id].health = tdm.player[id].maxhealth
			end
			if tdm.player[entity.owner].health >= tdm.player[entity.owner].maxhealth then
				tdm.player[entity.owner].health = tdm.player[entity.owner].maxhealth
			end
		end
	end,
	onWallCollision = function(entity)
	end,
	onDespawn = function(entity)
	end
}

tdm.entitytypes.megashield = {
	name = "Mega Shield",
	image = "gfx/henristdm/megashield.png",
	speed = 0,
	lifetime = 15,
	size = 120,
	onCreate = function(entity)
		imagehitzone(entity.image,103,-60,-10,120,20)
	end,
	onUpdate = function(entity)
		console.effect("\"flare\"",entity.position.x,entity.position.y,2,8,100,100,255)
	end,
	onPlayerCollsion = function(entity,id)
		if (player(entity.owner, "team") ~= player(id, "team")) then
			tdm.handledamage(id,entity.owner,15)
			console.effect("\"flare\"",player(id,"x"),player(id,"y"),15,15,100,100,255)
		end
	end,
	onWallCollision = function(entity)
	end,
	onDespawn = function(entity)
	end
}
