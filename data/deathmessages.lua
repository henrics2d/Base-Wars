tdm.deathmsgs = {}

function tdm.generateRandomDeath()
	local chances = 0
	for _,death in ipairs(tdm.deathmsgs) do
		chances = chances + death.chance
	end
	local target = chances * math.random()
	for _,death in ipairs(tdm.deathmsgs) do
		target = target - death.chance
		if target <= 0 then
			return death.msg
		end
	end
end

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Killed",
	chance = 250
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Made mince meat of",
	chance = 100
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Shot down",
	chance = 100
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Destroyed",
	chance = 100
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Pulvurized",
	chance = 100
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Devoured the essence of",
	chance = 5
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Made holy ashes off of",
	chance = 5
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Beam katana'd",
	chance = 5
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Removed",
	chance = 5
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "Brimstone blasted",
	chance = 5
}

tdm.deathmsgs[#tdm.deathmsgs+1] = {
	msg = "This is an easter egg",
	chance = 1
}
