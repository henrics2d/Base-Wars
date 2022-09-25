function tdm.applydb(id,type)
	local db = {}
	db.type = type
	db.holder = id
	db.active = true
	db.duration = db.type.duration
	db.image = image(db.type.image, 0, 0, 2, id)
	db.type.onCreate(db)
	tdm.dbs[#tdm.dbs + 1] = db
end

--[[addhook("ms100","tdm.updatedbs")
function tdm.updatedbs()
	for _,id in ipairs(player(0,"tableliving")) do
		local playerdata = tdm.player[id]
		local index = 0
		while index < #playerdata.effects do
			index = index + 1
			local db = playerdata.effects[index]
			-- lower duration
			db.duration = db.duration - 0.1
			if db.duration <= 0 then
				db.active = false
			end
			-- deactivate
			if db.active == false then
				db.type.onDespawn(db)
				freeimage(db.image)
				playerdata.effects[index] = playerdata.effects[#playerdata.effects]
				playerdata.effects[#playerdata.effects] = nil
				index = index - 1
			end
		end
	end
end]]
