-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2, v3 in ipairs(arg1) do
		local v4 = arg2(v3, v2, arg1)
		if v4 ~= nil then
			table.insert(v1, v4)
		end
	end
	return v1
end