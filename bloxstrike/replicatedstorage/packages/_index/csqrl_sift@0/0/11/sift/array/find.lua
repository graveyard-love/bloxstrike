-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v1 = #arg1
	if type(arg3) == "number" then
		if arg3 < 1 then
			arg3 = v1 + arg3
		end
	else
		arg3 = 1
	end
	return table.find(arg1, arg2, arg3)
end