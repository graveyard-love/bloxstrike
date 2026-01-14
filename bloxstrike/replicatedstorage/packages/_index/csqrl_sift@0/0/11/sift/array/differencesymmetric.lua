-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.Types)
local v_u1 = require(script.Parent.toSet)
local v_u2 = require(script.Parent.Parent.Set.toArray)
local v_u3 = require(script.Parent.Parent.Set.differenceSymmetric)
return function(arg1, ...)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u2
	local v1 = v_u1(arg1)
	local v2 = {}
	for _, v3 in { ... } do
		if typeof(v3) == "table" then
			table.insert(v2, v_u1(v3))
		end
	end
	return v_u2((v_u3(v1, unpack(v2))))
end