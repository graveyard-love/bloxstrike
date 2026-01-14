-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.Types)
return function(arg1, ...)
	local v_clone = table.clone(arg1)
	for _, v1 in { ... } do
		if typeof(v1) == "table" then
			for v2 in v1 do
				v_clone[v2] = nil
			end
		end
	end
	return v_clone
end