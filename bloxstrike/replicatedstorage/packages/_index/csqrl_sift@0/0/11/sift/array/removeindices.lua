-- Decompiled with Bunni.lol Decompiler

return function(arg1, ...)
	local v1 = #arg1
	local v2 = {}
	local v3 = {}
	for _, v5 in ipairs({ ... }) do
		if v5 < 1 then
			local v5 = v5 + v1
		end
		v2[v5] = true
	end
	for v6, v7 in ipairs(arg1) do
		if not v2[v6] then
			table.insert(v3, v7)
		end
	end
	return v3
end