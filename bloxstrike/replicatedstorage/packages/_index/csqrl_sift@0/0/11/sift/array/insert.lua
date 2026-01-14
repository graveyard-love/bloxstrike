-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, ...)
	local v1 = #arg1
	if arg2 < 1 then
		arg2 = arg2 + (v1 + 1)
	end
	if v1 < arg2 then
		if v1 + 1 < arg2 then
			return arg1
		end
		arg2 = v1 + 1
		v1 = v1 + 1
	end
	local v2 = {}
	for v3 = 1, v1 do
		if v3 == arg2 then
			for _, v4 in ipairs({ ... }) do
				table.insert(v2, v4)
			end
		end
		table.insert(v2, arg1[v3])
	end
	return v2
end