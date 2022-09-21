addhook("spawn","tdm.bots")
function tdm.bots(id)
  if player(id,"bot") then
    tdm.deletePlayerClass(id)
    tdm.setPlayerClass(id,tdm.getRandomClass())
    tdm.player[id].chosentalent = tdm.generateRandomTalent(id)
    if tdm.player[id].class.unique then
      tdm.bots(id)
      console.strip(id, 47)
      console.strip(id, 90)
      console.strip(id, 11)
      console.strip(id, 40)
    end
    if player(id,"team") == 1 then
      local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
      console.setpos(id, misc.tile_to_pixel(entity.x), misc.tile_to_pixel(entity.y))
    else
      local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
      console.setpos(id, misc.tile_to_pixel(entity.x), misc.tile_to_pixel(entity.y))
    end
  end
end
