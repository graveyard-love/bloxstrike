-- Decompiled with Bunni.lol Decompiler

local v_u_http = game:GetService("HttpService")
local v_u1 = game:GetService("RunService"):IsServer() and "server" or "client"
local v2 = {}
local v_u3 = {
	["__index"] = v2
}
function v2.write(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u_http
	assert(v_u1 == "server", "cannot write to replicatedvalue on client")
	arg1._luauData = arg2
	arg1._value.Value = v_u_http:JSONEncode(arg2)
end
function v2.read(arg1)
	return arg1._luauData
end
return function(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u1, (copy) v_u_http
	local v_u1 = setmetatable({}, v_u3)
	v_u1._luauData = {}
	v_u1._value = arg1
	if v_u1 == "client" then
		v_u1._luauData = table.freeze(v_u_http:JSONDecode(arg1.Value))
		arg1.Changed:Connect(function(arg1)
			-- upvalues: (copy) v_u1, (ref) v_u_http
			if arg1 then
				v_u1._luauData = table.freeze(v_u_http:JSONDecode(arg1))
			end
		end)
	end
	return v_u1
end