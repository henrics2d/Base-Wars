tdm.spawnpoints = {}
for _,e in pairs(entitylist()) do
  if entity(e.x,e.y,"typename") == "Info_Dom_Point" then
    tdm.spawnpoints[#tdm.spawnpoints+1] = e
  end
end


for _,e in ipairs(tdm.spawnpoints) do
  print(e.x..","..e.y.."; "..entity(e.x,e.y,"name"))
end
