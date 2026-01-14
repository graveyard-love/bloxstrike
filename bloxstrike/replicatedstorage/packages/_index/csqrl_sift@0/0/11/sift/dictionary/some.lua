-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	for v1, v2 in pairs(arg1) do
		if arg2(v2, v1, arg1) then
			return true
		end
	end
	return false
end