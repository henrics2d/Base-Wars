tdm.vehicles = {}
tdm.vehicles.friction = 0.1
tdm.vehicles.list = {}

dofile(tdm.directories.vehicles.."/brands.lua")

tdm.vehicles.keys = {
	accelerate = "leftshift",
	decelerate = "leftctrl"
}


addbind(tdm.vehicles.keys.accelerate)
addbind(tdm.vehicles.keys.decelerate)


addhook("key", "tdm.vehicles.key")
function tdm.vehicles.key(id, key, state)
	local vehicle = tdm.vehicles.getPlayerVehicle(id)
	if (vehicle == nil) then
		return
	end

	if (state == 0) then
		-- press key

		if (key == tdm.vehicles.keys.accelerate) then
			vehicle.gear = 2
		end
		if (key == tdm.vehicles.keys.accelerate) then
			vehicle.gear = -1
		end

	else
		-- release key

		if (key == tdm.vehicles.keys.accelerate or key == tdm.vehicles.keys.decelerate) then
			vehicle.gear = 0
		end
	end
end


addhook("use", "tdm.vehicles.use")
function tdm.vehicles.use(id, event, data, x, y)
	if (event ~= 0) end
		return
	end

	if (tdm.vehicles.isPlayerInVehicle(id)) then
		tdm.vehicles.exitVehicle(id)
		return
	end

	local vehicle = tdm.vehicles.getClosest(misc.tile_to_pixel(x), misc.tile_to_pixel(y))
	if (vehicle ~= nil) then
		tdm.vehicles.enterVehicle(id, vehicle)
		return
	end
end


addhook("ms100","tdm.vehicles.ms100")
function tdm.vehicles.ms100()
	local i = 1
	while (i < #tdm.vehicles.list) do
		local vehicle = tdm.vehicles.list[i]
		tdm.vehicles.updateVehicle(vehicle, 100)
		if (vehicle.alive) then
			i = i + 1
		else
			tdm.vehicles.destroyVehicle(vehicle)
		end
	end
end


function tdm.vehicles.spawnVehicle(x, y, rotation, brand)
	local vehicle = {}
	vehicle.position = {x = checks.requireNotNil("x", x), y = checks.requireNotNil("y", y)}
	vehicle.rotation = checks.requireNotNil("rotation", rotation)
	vehicle.speed = 0
	vehicle.brand = checks.requireNotNil("brand", brand)
	vehicle.image = image(vehicle.brand.image, vehicle.position.x, vehicle.position.y, 1)
	vehicle.gear = 0
	vehicle.player = nil
	vehicle.alive = true
	tdm.vehicles.list[#tdm.vehicles.list + 1] = vehicle
	return vehicle
end


function tdm.vehicles.updateVehicle(vehicle, delta)

	if (vehicle.alive == false) then
		error("cant update dead vehicle")
	end

	-- friction
	vehicle.speed = vehicle.speed * (1 - tdm.vehicles.friction)

	-- rotation
	if (vehicle.player ~= nil) then
		vehicle.rotation = misc.turnTowards(vehicle.rotation, player(vehicle.player, "rot"), vehicle.speed)
	end

	-- gear
	local acceleration = vehicle.gear * vehicle.brand.speed
	vehicle.speed = vehicle.speed + acceleration

	-- movement
	vehicle.position.x = vehicle.position.x + misc.lengthdir_x(vehicle.rotation, vehicle.speed)
	vehicle.position.y = vehicle.position.y + misc.lengthdir_y(vehicle.rotation, vehicle.speed)

	tween_image(vehicle.image, delta, vehicle.position.x, vehicle.position.y, vehicle.rotation)

	if (vehicle.player ~= nil) then
		console.setpos(vehicle.player, vehicle.position.x, vehicle.position.y)
	end
end


function tdm.vehicles.destroyVehicle(vehicle)
	if (vehicle.player ~= nil) then
		tdm.vehicles.exitVehicle(vehicle.player)
	end

	vehicle.alive = false

	if (vehicle.image ~= nil) then
		freeimage(vehicle.image)
		vehicle.image = nil
	end

	for index, entity in ipairs(tdm.vehicles.list) do
		if (entity == vehicle) then
			tdm.vehicles.list[index] = tdm.vehicles.list[#tdm.vehicles.list]
			tdm.vehicles.list[#tdm.vehicles.list] = nil
			return
		end
	end
end


function tdm.vehicles.enterVehicle(id, vehicle)
	if (tdm.vehicles.isPlayerInVehicle(id)) then
		msg2(id, "You are already in a vehicle")
		return false
	end

	if (vehicle.player ~= nil) then
		msg2(id, player(vehicle.player, "name").." is already driving the "..vehicle.brand.name)
		return false
	end

	if (vehicle.alive == false) then
		msg2(id, "vehicle does not function") -- this can only happen for a short
		return false
	end

	vehicle.player = id
	msg2(id, "you entered the vehicle")
	return true
end


function tdm.vehicles.exitVehicle(id)
	local vehicle = tdm.vehicles.getPlayerVehicle(id)
	if (vehicle == nil) then
		msg2(id, "You are not inside a vehicle")
		return false
	end

	vehicle.gear = 0
	msg2(id, "you exited the vehicle")
	return true
end


function tdm.vehicles.isPlayerInVehicle(id)
	return tdm.vehicles.getPlayerVehicle(id) ~= nil
end


function tdm.vehicles.getPlayerVehicle(id)
	for _, vehicle in ipairs(tdm.vehicles.list) do
		if (vehicle.player == id) then
			return vehicle
		end
	end
	return nil
end


function tdm.vehicles.getClosest(x, y)
	local best = {
		vehicle = nil,
		distance = nil
	}
	for _, vehicle in ipairs(tdm.vehicles.list) do
		local distance = misc.point_distance(x,y,vehicle.position.x,vehicle.position.y)
		if (best.distance == nil or distance < best.distance) then
			best.vehicle = vehicle
			best.distance = distance
		end
	end
	return best.vehicle
end
