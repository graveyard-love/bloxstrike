-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v1
	if arg3 == nil then
		arg3 = arg1[1]
		v1 = 2
	else
		v1 = 1
	end
	for v2 = v1, #arg1 do
		arg3 = arg2(arg3, arg1[v2], v2, arg1)
	end
	return arg3
end