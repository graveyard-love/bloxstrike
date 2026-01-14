-- Decompiled with Bunni.lol Decompiler

return function(...)
	local v1 = select("#", ...)
	local v2 = select(1, ...)
	local v3 = {}
	for v4, _ in pairs(v2) do
		local v5 = true
		for v6 = 2, v1 do
			if select(v6, ...)[v4] ~= true then
				v5 = false
				break
			end
		end
		if v5 then
			v3[v4] = true
		end
	end
	return v3
end