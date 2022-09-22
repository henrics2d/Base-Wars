timer2_container = {}
function timer2(delay,args,callback)
	local index = #timer2_container+1
	local temp = {}
	temp.args = args
	temp.callback = callback
	timer2_container[index] = temp
	timer(delay,"timer2_handler",index)
end

function timer2_handler(index)
	local temp = timer2_container[tonumber(index)]
	temp.callback(unpack(temp.args))
	timer2_container[index] = nil
end
