addhook("spawn","tdm.classmenu")
function tdm.classmenu(id)
  if tdm.player[id].defaultclass ~= nil then
    return
  end
  sme.createMenu(id,tdm.equipClass,tdm.showClass,"Classes",true,tdm.classestable,false)
end

function tdm.showClass(id,data,parameter)
  local text = data.name.."| Health: "..data.health
  if data.unique then
    text = "("..text..")"
  end
  return text
end

function tdm.equipClass(id,button,data,parameter)
  tdm.confirmClass(id,data)
end

function tdm.confirmClass(id,data)
  msg2(id,rgb(255,255,255).."Class Name: "..rgb(255,255,128)..data.name)
  msg2(id,rgb(255,255,255).."Class Description: "..rgb(255,255,128)..data.description)
  msg2(id,rgb(255,255,128)..data.description2)
  msg2(id,rgb(255,255,255).."Confirm this as your class on spawn? "..rgb(000,255,000).."Y"..rgb(255,255,255).."/"..rgb(255,0,0).."n")
  tdm.player[id].chosenclass = data
end

addhook("say","tdm.sayClass")
function tdm.sayClass(id,txt)
  if tdm.player[id].chosenclass ~= nil then
    if (txt == "Y") or (txt == "y") then
      msg2(id,rgb(255,255,255).."Action "..rgb(000,255,000).."Confirmed!")
      tdm.deletePlayerClass(id)
      tdm.setPlayerClass(id,tdm.player[id].chosenclass)
      tdm.player[id].chosenclass = nil
      tdm.selectSpawn(id)
      return 1
    end
    if (txt == "N") or (txt == "n") then
      msg2(id,rgb(255,255,255).."Action "..rgb(255,000,000).."Cancelled.")
      sme.createMenu(id,tdm.equipClass,tdm.showClass,"Classes",true,tdm.classestable,false)
      return 1
    end
  end
  return 1
end

function tdm.choosespawn(id)
  sme.createMenu(id,tdm.chooseSpawnpoint,tdm.showSpawnpoint,"Spawn Points",true,tdm.spawnpoints,false)
end

function tdm.showSpawnpoint(id,data,parameter)
  local text = data.name
  if player(id,"team") ~= data.ownedby then
    text = "("..data..")"
  end
  return text
end

function tdm.chooseSpawnpoint(id,button,data,parameter)
  parse("setpos "..id.." "..misc.tile_to_pixel(data.x).." "..misc.tile_to_pixel(data.y))
end

addhook("serveraction","tdm.serveraction")
function tdm.serveraction(id,action)
  if (action == 1) then
    sme.createMenu(id,tdm.doCommand,tdm.showCommand,"Commands",true,tdm.commands,false)
  end
end

function tdm.showCommand(id,data,parameter)
  local text = data.name.."|"..data.permlevel
  if data.locked then
    text = "("..text..")"
  end
  return text
end

function tdm.doCommand(id,button,data,parameter)
  data.callback(id)
end

function tdm.defaultClass(id)
  if tdm.player[id].defaultclass == nil then
    sme.createMenu(id,tdm.equipDefaultClass,tdm.showClass,"Classes",true,tdm.classestable,true)
  else
    tdm.optionDefaultClass(id)
  end
end

function tdm.equipDefaultClass(id,button,data,parameter)
  tdm.confirmDefaultClass(id,data)
end

function tdm.confirmDefaultClass(id,data)
  msg2(id,rgb(255,255,255).."Class Name: "..rgb(255,255,128)..data.name)
  msg2(id,rgb(255,255,255).."Class Description: "..rgb(255,255,128)..data.description)
  msg2(id,rgb(255,255,128)..data.description2)
  msg2(id,rgb(255,255,128)..data.name..rgb(255,255,255).." has been set as your default class!")
  tdm.player[id].defaultclass = data
  parse("customkill 0 Suicide "..id)
end

function tdm.optionDefaultClass(id)
  msg2(id,rgb(255,0,0).."Default class on spawn removed.")
  tdm.player[id].defaultclass = nil
end


function tdm.showTalentList(id)
  sme.createMenu(id,tdm.talentDescription,tdm.showTalent,"Talents",true,tdm.talents,false)
end

function tdm.showTalent(id,data,parameter)
  local text = data.name.."|"..data.rarity
  return text
end

function tdm.talentDescription(id,button,data,parameter)
  msg2(id,rgb(255,255,128).."Talent Description: "..data.name)
  msg2(id,rgb(255,255,255)..data.rarity.." Talent")
  msg2(id,rgb(255,255,255)..data.description)
  msg2(id,rgb(255,255,255)..data.description2)
end

function tdm.pickTalentList(id)
  sme.createMenu(id,tdm.pickTalent,tdm.showTalentUnlocked,"Owned Talents",true,tdm.playerTalents[id],false)
end

function tdm.showTalentUnlocked(id,data,parameter)
  local text = data.name.."|"..data.rarity
  return text
end

function tdm.pickTalent(id,button,data,parameter)
  tdm.showTalentStats(id,data,parameter)
end

function tdm.showTalentStats(id,data,parameter)
  msg2(id,rgb(255,255,128).."Talent "..data.name)
  msg2(id,rgb(255,255,255)..data.rarity.." Talent")
  msg2(id,rgb(255,255,255)..data.healthbonus.." extra health")
  msg2(id,rgb(255,255,255)..data.speedbonus.." extra base speed")
  msg2(id,rgb(255,255,255)..data.damagebonus * 100 .."% extra damage")
  msg2(id,rgb(255,255,255).."Talent "..rgb(000,255,000).."Equipped!")
  tdm.player[id].chosentalent = data
end

function tdm.selectSpawn(id)
  sme.createMenu(id,tdm.pickSpawn,tdm.showSpawn,"Spawnpoints",true,tdm.spawnpoints,false)
end

function tdm.showSpawn(id,data,parameter)
  local text = entity(data.x,data.y,"name")
  if player(id,"team") ~= entity(data.x,data.y,"int0") then
    text = "("..text..")"
  end
  return text
end

function tdm.pickSpawn(id,button,data,parameter)
  if player(id,"team") ~= entity(data.x,data.y,"int0") then
    return
  end
  parse("setpos "..id.." "..misc.tile_to_pixel(data.x).." "..misc.tile_to_pixel(data.y))
end
