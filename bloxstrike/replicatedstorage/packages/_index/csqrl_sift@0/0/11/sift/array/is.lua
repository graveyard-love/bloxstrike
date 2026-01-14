-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v1
	if typeof(arg1) == "table" and #arg1 > 0 then
		v1 = next(arg1, #arg1) == nil
	else
		v1 = false
	end
	return v1
end