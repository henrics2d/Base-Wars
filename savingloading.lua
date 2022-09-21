function tdm.initPlayer(id)
	local playerdata = {}
	tdm.player[id] = playerdata
	playerdata.battlescore = 100
	playerdata.rank = 1
	playerdata.exp = 0
	playerdata.expreq = 25
	playerdata.kills = 0
	tdm.playerTalents[id] = {}
	playerdata.chosentalent = tdm.talents[21]
end

function tdm.getPlayerSaveFile(id)
	local usgn = player(id,"usgn")
	if usgn == 0 then
		error("player "..player(id,"name").." ("..id..") does not have a USGN and thus cant save")
	end
	return tdm.directories.saves.."/usgnsave_"..usgn..".txt"
end

function tdm.load(id)
	local usgn = player(id,"usgn")
	if usgn == 0 then
		return
	end
	local playerdata = tdm.player[id]
	local file = io.open(tdm.getPlayerSaveFile(id),"r")
	if file == nil then
		return
	end
	playerdata.battlescore = tonumber(file:read())
	playerdata.rank = tonumber(file:read())
	playerdata.exp = tonumber(file:read())
	playerdata.expreq = tonumber(file:read())
	playerdata.kills = tonumber(file:read())
	file:close()
end

addhook("leave","tdm.save")
function tdm.save(id)
	local usgn = player(id,"usgn")
	if usgn == 0 then
		return
	end
	local playerdata = tdm.player[id]
	local file = io.open(tdm.getPlayerSaveFile(id),"w")
	file:write(playerdata.battlescore.."\n")
	file:write(playerdata.rank.."\n")
	file:write(playerdata.exp.."\n")
	file:write(playerdata.expreq.."\n")
	file:write(playerdata.kills.."\n")
	file:close()
end

addhook("join","tdm.join")
function tdm.join(id)
	tdm.initPlayer(id)
	tdm.load(id)
end
