-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	["Connected"] = true
}
v_u1.__index = v_u1
function v_u1.Disconnect(arg1)
	if arg1.Connected then
		arg1.Connected = false
		arg1.Connection:Disconnect()
	end
end
function v_u1._new(arg1)
	-- upvalues: (copy) v_u1
	return setmetatable({
		["Connection"] = arg1
	}, v_u1)
end
function v_u1.__tostring(arg1)
	return "RbxScriptConnection<" .. tostring(arg1.Connected) .. ">"
end
return v_u1