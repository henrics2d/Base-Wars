tdm.dbs = {}

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

addhook("ms100","tdm.updatedbs")
function tdm.updatedbs()
end 
