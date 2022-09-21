function tdm.initPlayer(id)
	local playerdata = tdm.player[id]

	-- progress
	playerdata.rank = 1
	playerdata.exp = 0
	playerdata.expreq = 25

	-- status
	playerdata.battlescore = 100
	playerdata.kills = 0

	-- talents
	playerdata.talents = {}

	playerdata.chosentalent = tdm.talents[21]
end

function tdm.saveEnginePlayerSave(playerdata, file)
	-- progress
	SaveEngine.write(file,"progress","rank", playerdata.rank)
	SaveEngine.write(file,"progress","exp", playerdata.exp)
	SaveEngine.write(file,"progress","expreq",playerdata.expreq)

	-- status
	SaveEngine.write(file,"status","battlescore",playerdata.battlescore)
	SaveEngine.write(file,"status","kills",playerdata.kills)

	-- talents
	local talentsString = ""
	for talent, _ in pairs(playerdata.talents) do
		if (string.len(talentsString) > 0) then
			talentsString = talentsString..","
		end
		talentsString = talentsString..talent.id
	end
	SaveEngine.write(file,"talent","owned",talentsString)
end

function tdm.saveEnginePlayerLoad(playerdata, file)
	-- progress
	playerdata.rank = SaveEngine.read(file,"progress","rank", playerdata.rank)
	playerdata.exp = SaveEngine.read(file,"progress","exp", playerdata.exp)
	playerdata.expreq = SaveEngine.read(file,"progress","expreq",playerdata.expreq)

	-- status
	playerdata.battlescore = SaveEngine.read(file,"status","battlescore",playerdata.battlescore)
	playerdata.kills = SaveEngine.read(file,"status","kills",playerdata.kills)

	-- talents
	local talentsString = SaveEngine.read(file,"talent","owned","")
	for _,talentId in ipairs(misc.stringsplit(talentsString, ",")) do -- talentId should probalbly have leading/trailing spaces removed
		local talent = tdm.getTalentById(talentId)
		if (talent == nil) then
			print("failed to give player "..id.." talent: "..talentId.." (unknown talent)")
		else
			playerdata.talents[talent] = true
		end
	end
end

function tdm.getPlayerSaveFile(id)
	local usgn = player(id,"usgn")
	if usgn == 0 then
		return nil
	end
	return tdm.directories.saves.."/usgnsave_"..usgn..".txt"
end

addhook("leave","tdm.save")
function tdm.save(id)
	local file = tdm.getPlayerSaveFile(id)
	if file == nil then
		return
	end
	SaveEngine.open(file)
	tdm.saveEnginePlayerSave(tdm.player[id], file)
	SaveEngine.save(file)
end

addhook("join","tdm.join")
function tdm.join(id)
	tdm.player[id] = {}

	tdm.initPlayer(id)
	tdm.load(id)
end

function tdm.load(id)
	local file = tdm.getPlayerSaveFile(id)
	if file == nil then
		return
	end
	SaveEngine.open(file)
	tdm.saveEnginePlayerLoad(tdm.player[id], file)
	SaveEngine.save(file)
end

