tdm.entities = {}

function tdm.spawnprojectile(id,type)
	local entity = {}
	entity.type = type
	entity.owner = id
	entity.alive = true
	entity.rotate = false
	entity.lifetime = entity.type.lifetime
	entity.dir = math.rad(player(id,"rot") - 90)
	entity.speed = entity.type.speed
	entity.position = {x = player(id,"x"), y = player(id,"y")}
	entity.image = image(entity.type.image, 0, 0, 0)
	imagepos(entity.image, entity.position.x, entity.position.y, math.deg(entity.dir) + 90)
	entity.type.onCreate(entity)
	tdm.entities[#tdm.entities + 1] = entity
end

addhook("ms100","tdm.updateprojectiles")
function tdm.updateprojectiles()
	local index = 0
	while index < #tdm.entities do
		index = index + 1
		local entity = tdm.entities[index]
		-- move
		local mx = math.cos(entity.dir) * entity.speed
		local my = math.sin(entity.dir) * entity.speed
		entity.position.x = entity.position.x + mx
		entity.position.y = entity.position.y + my
		if entity.rotate == true then
			tween_move(entity.image, 100, entity.position.x, entity.position.y, tween_rotateconstantly(entity.image, 35))
		else
			tween_move(entity.image, 100, entity.position.x, entity.position.y, math.deg(entity.dir) + 90)
		end
		-- update
		entity.type.onUpdate(entity)
		-- wall collsion
		local tx = misc.pixel_to_tile(entity.position.x)
		local ty = misc.pixel_to_tile(entity.position.y)
		if tile(tx, ty, "property") == 1 or objectat(tx,ty) > 0 then
			entity.type.onWallCollision(entity)
		end
		-- player collision
		for _,id in ipairs(player(0,"tableliving")) do
			if id ~= entity.owner then
				local px = player(id,"x")
				local py = player(id,"y")
				local dx = math.abs(entity.position.x-px)
				local dy = math.abs(entity.position.y-py)
				local dist = dx + dy
				if dist <= 16 + entity.type.size then
					 entity.type.onPlayerCollsion(entity,id)
				end
			end
		end
		-- lifetime
		entity.lifetime = entity.lifetime - 0.1
		if entity.lifetime <= 0 then
			entity.alive = false
		end
		-- despawn
		if entity.alive == false then
			entity.type.onDespawn(entity)
			freeimage(entity.image)
			tdm.entities[index] = tdm.entities[#tdm.entities]
			tdm.entities[#tdm.entities] = nil
			index = index - 1
		end
	end
end
