-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v_create = table.create(#arg1)
	for _, v1 in ipairs(arg1) do
		v_create[v1] = true
	end
	return v_create
end