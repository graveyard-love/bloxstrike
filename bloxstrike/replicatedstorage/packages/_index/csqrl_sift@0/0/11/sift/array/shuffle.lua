-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copy)
return function(arg1)
	-- upvalues: (copy) v_u1
	local v_new = Random.new(os.time() * #arg1)
	local v1 = v_u1(arg1)
	for v2 = #v1, 1, -1 do
		local v_nextinteger = v_new:NextInteger(1, v2)
		v1[v2] = v1[v_nextinteger]
		v1[v_nextinteger] = v1[v2]
	end
	return v1
end