tdm.spawnpoints = {}
for _,e in pairs(entitylist()) do
  if entity(e.x,e.y,"typename") == "Info_Dom_Point" then
    tdm.spawnpoints[#tdm.spawnpoints] = e
  end
end
