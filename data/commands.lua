tdm.commands = {}

--[[
commands.lua

locked = is this command accessible and clickable? true for locked (unclickable) false for unlocked (clickable)
permlevel = (PURELY COSMETIC) who can access this command?
name = name of the command
callback = execute these when activated
]]

tdm.commands[#tdm.commands+1] = {
	locked = true,
	permlevel = "",
	name = "Client Commands",
	callback = function(id)
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "Client",
	name = "Reset to spawn",
	callback = function(id)
		console.customkill(0,"Reset to spawn",id)
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "Client",
	name = "Set Default Spawn Class",
	callback = function(id)
		tdm.defaultClass(id)
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = true,
	permlevel = "",
	name = "Buy Classes",
	callback = function(id)
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "1000 BSCORE",
	name = "Buy Dreadnaut",
	callback = function(id)
		if tdm.player[id].battlescore >= 1000 then
			tdm.player[id].battlescore = tdm.player[id].battlescore - 1000
			tdm.deletePlayerClass(id)
			tdm.setPlayerClass(id,tdm.classestable[13])
			tdm.selectSpawn(id)
		end
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "500 BSCORE",
	name = "Buy Juggernaut",
	callback = function(id)
		if tdm.player[id].battlescore >= 500 then
			tdm.player[id].battlescore = tdm.player[id].battlescore - 500
			tdm.deletePlayerClass(id)
			tdm.setPlayerClass(id,tdm.classestable[14])
			tdm.selectSpawn(id)
		end
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "2000 BSCORE",
	name = "Buy Solar Angel",
	callback = function(id)
		if tdm.player[id].battlescore >= 2000 then
			tdm.player[id].battlescore = tdm.player[id].battlescore - 2000
			tdm.deletePlayerClass(id)
			tdm.setPlayerClass(id,tdm.classestable[15])
			tdm.selectSpawn(id)
		end
	end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "Client",
	name = "Talents",
	callback = function(id) tdm.showTalentList(id) end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "Client",
	name = "Owned Talents",
	callback = function(id) tdm.pickTalentList(id) end
}

tdm.commands[#tdm.commands+1] = {
	locked = false,
	permlevel = "Tester",
	name = "Recieve Random Talent",
	callback = function(id)
		if player(id,"usgn") == 129888 or player(id,"usgn") == 197238 then
			local talent = tdm.givePlayerRandomNewTalent(id)
			if (talent == nil) then
				msg2(id, rgb(100,255,0).."All talents already aquired!")
			end
		else
			msg2(id, rgb(255,0,0).."You are not a tester!")
		end
	end
}
