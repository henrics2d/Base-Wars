tdm.npcs = {}

function tdm.createNpc(id,team,npc)
	local npcs = {}
	npcs.type = npc
	npcs.team = team
	npcs.alive = true
	npcs.health = npcs.type.health
	npcs.speed = npcs.type.speed
	npcs.damage = npcs.type.damage
	npcs.range = npcs.type.range
	npcs.firerate = npcs.type.firerate
	npcs.position = {x = player(id,"x"), y = player(id,"y")}
	npcs.image = image(npcs.type.image, npcs.position.x, npcs.position.y, 1)
	npcs.type.onCreate(npc)
	-- optional owner id for summoners
	if id ~= nil or id ~= 0 then
		npc.owner = id
	end
	tdm.npcs[#tdm.npcs + 1] = npcs
end

addhook("ms100","tdm.updateNpc")
function tdm.updateNpc()
	local index = 0
	while index < #tdm.npcs do
		index = index + 1
		local npc = tdm.npcs[index]
		-- move
		-- update
		npc.type.onUpdate(npc)
		-- target
		-- target within range
		-- health
		-- wall collision
		local tx = misc.pixel_to_tile(npc.position.x)
		local ty = misc.pixel_to_tile(npc.position.y)
		if tile(tx, ty, "property") == 1 or objectat(tx,ty) > 0 then
			npc.type.onWallCollision(npc)
		end
		-- despawn
		if npc.alive == false then
			npc.type.onDespawn(npc)
			freeimage(npc.image)
			tdm.npcs[index] = tdm.npcs[#tdm.npcs]
			tdm.npcs[#tdm.npcs] = nil
			index = index - 1
		end
	end
end
