-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	for v1, v2 in ipairs(arg1) do
		if not arg2(v2, v1, arg1) then
			return false
		end
	end
	return true
end