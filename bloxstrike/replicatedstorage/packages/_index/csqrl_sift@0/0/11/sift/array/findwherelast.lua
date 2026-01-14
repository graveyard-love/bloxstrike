-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v1 = #arg1
	if type(arg3) == "number" then
		if arg3 < 1 then
			arg3 = v1 + arg3
		end
	else
		arg3 = v1
	end
	for v2 = arg3, 1, -1 do
		if arg2(arg1[v2], v2, arg1) then
			return v2
		end
	end
end