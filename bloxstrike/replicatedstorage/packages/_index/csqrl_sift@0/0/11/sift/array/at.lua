-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = #arg1
	if arg2 < 1 then
		arg2 = arg2 + v1
	end
	return arg1[arg2]
end