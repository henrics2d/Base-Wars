addhook("say","tdm.customchat")
function tdm.customchat(id,txt)
  if txt == "Y" or txt == "y" then
    return 1
  end
  if txt == "N" or txt == "n" then
    return 1
  end
	if txt ~= "rank" then
    if player(id,"usgn") == 129888 then
      msg(rgb(255,255,128)..""..player(id,"name").." ["..rgb(255,255,0).."Admin"..rgb(255,255,128).."]:"..rgb(255,255,0).." "..txt)
      return 1
    end
    if tdm.player[id].class ~= nil then
  		if player(id,"team") == 2 then
  			msg(rgb(100,100,255)..""..player(id,"name").." ["..rgb(255,255,255)..""..tdm.player[id].class.name..""..rgb(100,100,255).."]:"..rgb(255,255,255).." "..txt)
  			return 1
  		end
  		if player(id,"team") == 1 then
  			msg(rgb(210,10,10)..""..player(id,"name").." ["..rgb(255,255,255)..""..tdm.player[id].class.name..""..rgb(255,0,0).."]:"..rgb(255,255,255).." "..txt)
  			return 1
  		end
    else
      msg(rgb(255,255,128)..""..player(id,"name").." ["..rgb(255,255,255).."Spectator"..rgb(255,255,128).."]:"..rgb(255,255,255).." "..txt)
      return 1
    end
	end
end
