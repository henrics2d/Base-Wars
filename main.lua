tdm = {}
images = "gfx/henristdm/"

tdm.directory = "sys/lua/henristdm"

tdm.directories = {
	saves = tdm.directory.."/saves",
	vehicles = tdm.directory.."/vehicles",
	customnpc = tdm.directory.."/customnpcs",
	utility = tdm.directory.."/utility",
	data = tdm.directory.."/data"
}

dofile(tdm.directories.utility.."/utility.lua")
dofile(tdm.directories.data.."/commands.lua")
dofile(tdm.directories.data.."/armors.lua")
dofile(tdm.directories.data.."/ranks.lua")
dofile(tdm.directories.data.."/entities.lua")
dofile(tdm.directory.."/savingloading.lua")
dofile(tdm.directory.."/health.lua")
dofile(tdm.directory.."/effects.lua")
dofile(tdm.directory.."/menus.lua")
dofile(tdm.directory.."/classes.lua")
dofile(tdm.directory.."/projectiles.lua")
dofile(tdm.directory.."/bot.lua")
dofile(tdm.directory.."/gui.lua")
dofile(tdm.directory.."/spawns.lua")
dofile(tdm.directories.data.."/rarities.lua")
dofile(tdm.directory.."/buffsanddebuffs.lua")
dofile(tdm.directories.data.."/buffsdebuffs.lua")
dofile(tdm.directories.data.."/deathmessages.lua")
dofile(tdm.directory.."/talents.lua")
dofile(tdm.directory.."/customchat.lua")
dofile(tdm.directories.customnpc.."/engine.lua")
dofile(tdm.directories.vehicles.."/vehicles.lua")

tdm.player = {}

addhook("leave","tdm.deleteAllImages")
function tdm.deleteAllImages(id)
	tdm.deletePlayerClass(id)
end

addhook("die","tdm.saveondeath")
function tdm.saveondeath(id)
	tdm.save(id)
	if tdm.player[id].gui == nil then
		return
	end
	if tdm.player[id].gui.icon ~= nil then
		tdm.deleteRankIcon(id)
		tdm.player[id].gui.icon = nil
	end
	tdm.player[id].target = nil
end

addhook("join","tdm.initialize")
function tdm.initialize(id)
	tdm.player[id] = {}
	tdm.player[id].gui = {}
	tdm.player[id].defaultclass = nil
end

addhook("die","tdm.deletePlayerClass")
function tdm.deletePlayerClass(id)
	console.hudtxtclear(id)
	if tdm.player[id].effects ~= nil then
		for _,db in ipairs(tdm.player[id].effects) do
			if db.image ~= nil then
				freeimage(db.image)
			end
		end
	end
	if tdm.player[id].knifeimage ~= nil then
		freeimage(tdm.player[id].knifeimage)
		tdm.player[id].knifeimage = nil
	end
	if tdm.player[id].image ~= nil then
		freeimage(tdm.player[id].image)
		tdm.player[id].image = nil
	end
	tdm.player[id].class = nil
end

addhook("spawn","tdm.defaultSpawns")
function tdm.defaultSpawns(id)
	tdm.player[id].effects = {}
	if tdm.player[id].defaultclass == nil then
		return
	end
	tdm.setPlayerClass(id,tdm.player[id].defaultclass)
	tdm.selectSpawn(id)
end

function tdm.setPlayerClass(id,class)
	local playerdata = tdm.player[id]
	playerdata.class = class
	if playerdata.class == nil then
		return
	end
	playerdata.health = playerdata.class.health * (playerdata.chosentalent.healthbonus + 1)
	playerdata.maxhealth = playerdata.class.maxhealth * (playerdata.chosentalent.healthbonus + 1)
	playerdata.damagemultiplier = playerdata.class.damagemultiplier + playerdata.chosentalent.damagebonus
	playerdata.armor = playerdata.class.armorpoints
	playerdata.armortype = tdm.armorstable[playerdata.class.armorid]
	playerdata.speed = playerdata.class.basespeed + playerdata.chosentalent.speedbonus
	playerdata.abilitycooldown = 0
	playerdata.gui = {}
	console.speedmod(id,playerdata.speed)
	--
	tdm.createClassImg(id)
	--
	tdm.createRankIcon(id)
	console.equip(id,74)
	console.equip(id,47)
	playerdata.class.onSpawn(id)
end

function tdm.createClassImg(id)
	local playerdata = tdm.player[id]
	if playerdata.class.img ~= nil or playerdata.chosentalent.name == "Blessing of the Solar Angel" or playerdata.chosentalent.name == "Curse of the Brimstone Witch" or playerdata.chosentalent.name == "Curse of the Dead-King" then
		if playerdata.class.name == "Solar Angel" then
			playerdata.knifeimage = image(images.."solarsword.png", 3, 0, 200 + id)
		end
		if playerdata.chosentalent.name == "Curse of the Brimstone Witch" then
			playerdata.image = image(images.."brimstonehalo.png", 3, 0, 200 + id)
		else
	    if playerdata.chosentalent.name == "Blessing of the Solar Angel" then
	      playerdata.image = image(images.."solarradiance.png", 3, 0, 200 + id)
	    else
				if playerdata.chosentalent.name ~= "Curse of the Dead-King" then
		      playerdata.image = image(images..playerdata.class.img, 3, 0, 200 + id)
		    else
	      	playerdata.image = image(images.."crown.png", 3, 0, 200 + id)
				end
	    end
		end
	end
end

addhook("ms100","tdm.ms100")
function tdm.ms100()
	tdm.updateAllPlayerUi()
	tdm.abilityCountdown()
	tdm.regeneration()
end

addhook("kill","tdm.kill")
function tdm.kill(killer,victim,weapon,x,y,killerobject,assistant)
	tdm.killreward(killer,victim,x,y,killerobject,assistant)
	tdm.ranks(killer,victim,x,y,killerobject,assistant)
	tdm.save(killer)
	tdm.save(victim)
end

function tdm.killreward(killer,victim,x,y,killerobject,assistant)
	tdm.player[killer].battlescore = tdm.player[killer].battlescore + math.ceil(math.random(21,29))
	tdm.player[killer].kills = tdm.player[killer].kills + 1
end

function tdm.ranks(killer,victim,x,y,killerobject,assistant)
	tdm.player[killer].exp = tdm.player[killer].exp + math.ceil(math.random(21,29))
	if tdm.player[killer].exp >= tdm.player[killer].expreq and tdm.player[killer].rank ~= 22 then
		tdm.player[killer].expreq = tdm.playerranks[tdm.player[killer].rank + 1].expreq
		tdm.player[killer].exp = 0
		tdm.player[killer].rank = tdm.player[killer].rank + 1
		msg2(killer,""..rgb(255,255,255).."Rank "..rgb(255,255,128).."Up!@C")
		tdm.givePlayerRandomNewTalent(killer)
		tdm.deleteRankIcon(killer)
		tdm.createRankIcon(killer)
		msg(rgb(255,255,255)..player(killer, "name").." ranked up to "..rgb(255,255,128)..tdm.playerranks[tdm.player[killer].rank].name.."!")
	end
end

addhook("drop","tdm.dontDrop")
function tdm.dontDrop()
	return 1
end
