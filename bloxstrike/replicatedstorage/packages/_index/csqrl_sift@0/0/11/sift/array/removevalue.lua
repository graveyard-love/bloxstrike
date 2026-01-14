-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for _, v2 in ipairs(arg1) do
		if v2 ~= arg2 then
			table.insert(v1, v2)
		end
	end
	return v1
end