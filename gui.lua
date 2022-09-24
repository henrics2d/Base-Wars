function tdm.updateAllPlayerUi()
	local players = player(0,"tableliving")
	for _,id in ipairs(players) do
		tdm.updateBaseStats(id)
		tdm.updateInfoStats(id)
	end
end

function tdm.updateBaseStats(id)
	local playerdata = tdm.player[id]
	if playerdata.class ~= nil then
		if (math.ceil(playerdata.health) / math.ceil(playerdata.maxhealth)) * 100 < 20 then
			console.hudtxt2(id,1,rgb(255,0,0).."(!!!) HP: "..math.ceil(playerdata.health).."/"..math.ceil(playerdata.maxhealth),player(id,"screenw") / 2.25,player(id,"screenh") / 1.5,0,0,25)
		else
			console.hudtxt2(id,1,rgb(255,255,128).."HP: "..rgb(255,255,255)..math.ceil(playerdata.health).."/"..math.ceil(playerdata.maxhealth),player(id,"screenw") / 2.25,player(id,"screenh") / 1.5,0,0,25)
		end
		console.hudtxt2(id,2,rgb(128,128,255).."AP: "..rgb(255,255,255)..math.ceil(playerdata.armor),player(id,"screenw") / 2.25,player(id,"screenh") / 1.44,0,0,25)
		console.hudtxt2(id,3,rgb(128,128,255).."Armor: "..rgb(255,255,255)..playerdata.armortype.name,player(id,"screenw") / 2.25,player(id,"screenh") / 1.38,0,0,25)
	end
end

function tdm.updateInfoStats(id)
	local playerdata = tdm.player[id]
	if playerdata.class ~= nil then
		console.hudtxt2(id,4,rgb(255,255,128).."Class: "..rgb(255,255,255)..playerdata.class.name,player(id,"screenw") - player(id,"screenw"),player(id,"screenh") / 1.05,0,0,25)
		console.hudtxt2(id,5,rgb(255,255,128).."Ability: "..rgb(255,255,255)..tdm.getPlayerAbilityStatus(id),player(id,"screenw") - player(id,"screenw"),player(id,"screenh") / 1.075,0,0,25)
		console.hudtxt2(id,6,rgb(255,255,128).."Rank: "..rgb(255,255,255)..tdm.playerranks[playerdata.rank].name,player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 300,0,0,25)
		if tdm.player[id].rank ~= 22 then
			console.hudtxt2(id,7,rgb(255,255,128).."EXP: "..rgb(255,255,255)..math.ceil(playerdata.exp)..'/'..math.ceil(playerdata.expreq),player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 325,0,0,25)
		else
			console.hudtxt2(id,7,rgb(255,255,128).."EXP: "..rgb(255,255,255).."Max Rank Attained!",player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 325,0,0,25)
		end
		console.hudtxt2(id,8,rgb(255,255,128).."Battle Score: "..rgb(255,255,255)..math.ceil(playerdata.battlescore),player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 350,0,0,25)
		console.hudtxt2(id,9,rgb(255,255,128).."Kills: "..rgb(255,255,255)..math.ceil(playerdata.kills),player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 375,0,0,25)
		if tdm.player[id].chosentalent ~= nil then
			console.hudtxt2(id,10,rgb(255,255,128).."Talent: "..rgb(255,255,255)..playerdata.chosentalent.name,player(id,"screenw") - player(id,"screenw"),player(id,"screenh") - player(id,"screenh") + 400,0,0,25)
		end
	end
	local target = tdm.getPlayerTarget(id)
	if target ~= nil then
		console.hudtxt2(id,11,rgb(255,255,128).."Enemy HP: "..rgb(255,255,255)..math.ceil(tdm.player[target].health)..'/'..math.ceil(tdm.player[target].maxhealth),player(id,"mousex") + player(id,"mousex"),player(id,"mousey") + player(id,"mousey"),0,0,15)
		console.hudtxt2(id,12,rgb(128,128,255).."Enemy AP: "..rgb(255,255,255)..math.ceil(tdm.player[target].armor),player(id,"mousex") + player(id,"mousex"),player(id,"mousey") + player(id,"mousey")+15,0,0,15)
	end
end

function tdm.createRankIcon(id)
	if tdm.player[id].gui == nil then
		return
	end
	tdm.player[id].gui.icon = image(images..""..tdm.playerranks[tdm.player[id].rank].imgicon.."", player(id,"screenw") - player(id,"screenw") + 20, player(id,"screenh") - player(id,"screenh") + 280, 2, id)
	imagescale(tdm.player[id].gui.icon,1.35,1.35)
end

function tdm.deleteRankIcon(id)
	if tdm.player[id].gui.icon ~= nil then
		freeimage(tdm.player[id].gui.icon)
	end
end

function tdm.getPlayerAbilityName(id)
	if tdm.player[id].class.gadget == nil then
		return rgb(255,0,0).."None"
	end
	return rgb(255,255,255)..tdm.player[id].class.gadget.name
end

function tdm.getPlayerAbilityStatus(id)
	local abilitystatus = tdm.getPlayerAbilityName(id)
	if tdm.player[id].class.gadget == nil then
		return abilitystatus
	end
	if tdm.player[id].abilitycooldown == 0 then
		abilitystatus = abilitystatus..rgb(0,255,0).." [Ready!]"
	else
		abilitystatus = abilitystatus..rgb(255,255,0).." [Ready in "..math.ceil(tdm.player[id].abilitycooldown).."]"
	end
	return abilitystatus
end

function tdm.getPlayerTarget(id)
	if tdm.player[id].target == nil then
		console.hudtxt2(id,11,"",2,270)
		console.hudtxt2(id,12,"",2,270)
		return nil
	end
	if player(tdm.player[id].target, "health") <= 0 then
		tdm.player[id].target = nil
		return nil
	end
	if player(tdm.player[id].target, "team") == player(id, "team") then
		tdm.player[id].target = nil
		return nil
	end
	return tdm.player[id].target
end
