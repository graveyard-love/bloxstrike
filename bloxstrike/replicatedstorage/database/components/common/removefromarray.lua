-- Decompiled with Bunni.lol Decompiler

game:GetService("ReplicatedStorage")
return function(arg1, arg2)
	local v1 = {}
	for v2 = 1, #arg1 do
		if arg2(v2, arg1[v2]) then
			table.insert(v1, v2)
		end
	end
	table.sort(v1, function(arg1, arg2)
		return arg2 < arg1
	end)
	for _, v3 in ipairs(v1) do
		table.remove(arg1, v3)
	end
	return arg1
end