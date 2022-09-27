function tdm.applydb(id,type)
	local db = {}
	db.type = type
	db.holder = id
	db.active = true
	db.duration = db.type.duration
	db.maxduration = db.type.duration
	local current = tdm.finddb(id,type)
	if current == nil then
		db.image = image(db.type.image, 200, (player(id,"screenh") - player(id,"screenh")) - 32, 2, id)
		db.type.onCreate(id)
		local playerdata = tdm.player[id]
		playerdata.effects[#playerdata.effects + 1] = db
		tdm.shiftguidbs(id)
	else
		current.duration = math.max(current.duration,db.duration)
		current.maxduration = math.max(current.maxduration,db.maxduration)
	end
end

function tdm.finddb(id,type)
	for _,effect in ipairs(tdm.player[id].effects) do
		if type == effect.type then
			return effect
		end
	end
end

addhook("ms100","tdm.updatedbs")
function tdm.updatedbs()
	for _,id in ipairs(player(0,"tableliving")) do
		local playerdata = tdm.player[id]
		local index = 0
		while index < #playerdata.effects do
			index = index + 1
			local db = playerdata.effects[index]
			-- update
			db.type.onUpdate(db,id)
			-- lower duration
			db.duration = db.duration - 0.1
			if db.duration <= 0 then
				db.active = false
			end
			-- fade
			local min_alpha = 0.2
			local alpha = min_alpha + ((1 - min_alpha) / db.maxduration * db.duration)
			tween_alpha(db.image,100,alpha)
			-- deactivate
			if db.active == false then
				db.type.onDespawn(id)
				freeimage(db.image)
				playerdata.effects[index] = playerdata.effects[#playerdata.effects]
				playerdata.effects[#playerdata.effects] = nil
				index = index - 1
				tdm.shiftguidbs(id)
			end
		end
	end
end

function tdm.shiftguidbs(id)
	for index,db in ipairs(tdm.player[id].effects) do
		local x = 200 + (index * 40)
		local y = (player(id,"screenh") - player(id,"screenh")) + 64
		tween_move(db.image,500,x,y,0)
	end
end
