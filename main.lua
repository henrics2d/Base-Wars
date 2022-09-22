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
dofile(tdm.directory.."/talents.lua")
dofile(tdm.directory.."/customchat.lua")
dofile(tdm.directories.vehicles.."/engine.lua")
dofile(tdm.directories.customnpc.."/engine.lua")

tdm.player = {}

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
	parse("hudtxtclear "..id)
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
	if tdm.player[id].defaultclass == nil then
		return
	end
	tdm.setPlayerClass(id,tdm.player[id].defaultclass)
	if player(id,"team") == 1 then
		local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
		parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
	else
		local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
		parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
	end
end

function tdm.setPlayerClass(id,class)
	local playerdata = tdm.player[id]
	playerdata.class = class
	playerdata.health = playerdata.class.health + playerdata.chosentalent.healthbonus
	playerdata.maxhealth = playerdata.class.maxhealth + playerdata.chosentalent.healthbonus
	playerdata.damagemultiplier = playerdata.class.damagemultiplier + playerdata.chosentalent.damagebonus
	playerdata.armor = playerdata.class.armorpoints
	playerdata.armortype = tdm.armorstable[playerdata.class.armorid]
	playerdata.speed = playerdata.class.basespeed + playerdata.chosentalent.speedbonus
	playerdata.abilitycooldown = 0
	playerdata.effects = {}
	playerdata.effects.combattimer = 0
	playerdata.effects.immunityframes = 0
	playerdata.effects.dodgeframes = 0
	playerdata.effects.fire = 0
	playerdata.effects.poison = 0
	playerdata.effects.acidvenom = 0
	playerdata.effects.dodgeboost = 0
	playerdata.effects.resistancebuff = 0
	playerdata.effects.damagebuff = 0
	playerdata.gui = {}
	parse("speedmod "..id.." "..playerdata.speed)
	if playerdata.class.img ~= nil then
		if playerdata.class.name == "Solar Angel" then
			playerdata.knifeimage = image(images.."solarsword.png", 3, 0, 200 + id)
		end
    if playerdata.chosentalent.name ~= "Solar Eruption" then
      playerdata.image = image(images..playerdata.class.img, 3, 0, 200 + id)
    else
      playerdata.image = image(images.."solarradiance.png", 3, 0, 200 + id)
    end
	end
	--
	tdm.createRankIcon(id)
	parse("equip "..id.." 74")
	parse("equip "..id.." 47")
	playerdata.class.onSpawn(id)
end

addhook("ms100","tdm.ms100")
function tdm.ms100()
	tdm.updateAllPlayerUi()
	tdm.regeneration()
	tdm.abilityCountdown()
	tdm.effectsCounterUpdate()
	tdm.dodgeBoostEffect()
	tdm.damageBuffEffect()
	tdm.onFireEffect()
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
