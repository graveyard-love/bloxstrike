-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_new = require(v_u_replicatedstorage.Packages.Signal).new()
v1.OnActiveBundleUpdated = v_u_new
local v_u2 = nil
function v1.GetActiveBundle()
	-- upvalues: (ref) v_u2
	return v_u2
end
function v1.ObserveActiveBundle(arg1)
	-- upvalues: (copy) v_u_new, (ref) v_u2
	local v_u_connection = v_u_new:Connect(arg1)
	if v_u2 then
		arg1(v_u2)
	end
	return function()
		-- upvalues: (copy) v_u_connection
		v_u_connection:Disconnect()
	end
end
if v_u_replicatedstorage:GetAttribute("ActiveBundle") then
	v_u2 = v_u_http:JSONDecode((v_u_replicatedstorage:GetAttribute("ActiveBundle")))
	if #v_u_new:GetConnections() > 0 then
		v_u_new:Fire(v_u2)
	end
end
v_u_replicatedstorage:GetAttributeChangedSignal("ActiveBundle"):Connect(function()
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u2, (copy) v_u_http, (copy) v_u_new
	local v_activebundle = v_u_replicatedstorage:GetAttribute("ActiveBundle")
	if v_activebundle then
		v_u2 = v_u_http:JSONDecode(v_activebundle)
		if #v_u_new:GetConnections() > 0 then
			v_u_new:Fire(v_u2)
		end
	else
		return
	end
end)
return v1