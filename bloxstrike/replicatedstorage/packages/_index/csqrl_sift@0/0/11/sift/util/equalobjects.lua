-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.Types)
return function(...)
	local v1 = select(1, ...)
	for v2 = 2, select("#", ...) do
		if v1 ~= select(v2, ...) then
			return false
		end
	end
	return true
end