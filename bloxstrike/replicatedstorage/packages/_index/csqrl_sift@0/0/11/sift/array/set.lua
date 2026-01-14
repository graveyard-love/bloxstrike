-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v1 = #arg1
	local v2 = {}
	if arg2 < 1 then
		arg2 = arg2 + v1
	end
	for v3, v4 in ipairs(arg1) do
		if v3 == arg2 then
			table.insert(v2, arg3)
		else
			table.insert(v2, v4)
		end
	end
	return v2
end