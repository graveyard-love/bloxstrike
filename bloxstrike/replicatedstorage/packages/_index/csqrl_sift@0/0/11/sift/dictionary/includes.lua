-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	for _, v1 in pairs(arg1) do
		if v1 == arg2 then
			return true
		end
	end
	return false
end