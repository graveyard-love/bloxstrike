-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2, v3 in pairs(arg1) do
		if v3 ~= arg2 then
			v1[v2] = v3
		end
	end
	return v1
end