-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_new = require(v_u_replicatedstorage.Packages.Signal).new()
v1.OnAvailableCollectionsUpdated = v_u_new
local v_u2 = nil
function v1.GetCollectionByName(arg1)
	-- upvalues: (ref) v_u2
	for _, v1 in ipairs(v_u2) do
		if v1.name == arg1 then
			return v1
		end
	end
	return nil
end
function v1.ObserveAvailableCollections(arg1)
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
if v_u_replicatedstorage:GetAttribute("AvailableCollections") then
	v_u2 = v_u_http:JSONDecode((v_u_replicatedstorage:GetAttribute("AvailableCollections")))
	if #v_u_new:GetConnections() > 0 then
		v_u_new:Fire(v_u2)
	end
end
v_u_replicatedstorage:GetAttributeChangedSignal("AvailableCollections"):Connect(function()
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u2, (copy) v_u_http, (copy) v_u_new
	local v_availablecollections = v_u_replicatedstorage:GetAttribute("AvailableCollections")
	if v_availablecollections then
		v_u2 = v_u_http:JSONDecode(v_availablecollections)
		if #v_u_new:GetConnections() > 0 then
			v_u_new:Fire(v_u2)
		end
	else
		return
	end
end)
return v1