-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2, _ in pairs(arg1) do
		local v3 = arg2(v2, arg1)
		if v3 ~= nil then
			v1[v3] = true
		end
	end
	return v1
end