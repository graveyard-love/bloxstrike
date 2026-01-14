-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_run = game:GetService("RunService")
local v_u1 = require(script.Parent.replicatedValue)
local v_u2 = v_run:IsServer() and "server" or "client"
local v_u3 = nil
local v_u4 = {}
return {
	["start"] = function()
		-- upvalues: (copy) v_u2, (copy) v_u_replicatedstorage, (ref) v_u3
		if v_u2 == "server" then
			local v_folder = Instance.new("Folder")
			v_folder.Name = "BytenetStorage"
			v_folder.Parent = v_u_replicatedstorage
			v_u3 = v_folder
		elseif v_u2 == "client" then
			v_u3 = v_u_replicatedstorage:WaitForChild("BytenetStorage")
		end
	end,
	["access"] = function(arg1)
		-- upvalues: (copy) v_u4, (copy) v_u2, (ref) v_u3, (copy) v_u1
		if v_u4[arg1] then
			return v_u4[arg1]
		end
		if v_u2 == "client" then
			local v1 = v_u3:FindFirstChild(arg1)
			if v1 and v1:IsA("StringValue") then
				local v2 = v_u1(v1)
				v_u4[arg1] = v2
				return v2
			end
		elseif v_u2 == "server" then
			local v_stringvalue = Instance.new("StringValue")
			v_stringvalue.Name = arg1
			v_stringvalue.Parent = v_u3
			local v3 = v_u1(v_stringvalue)
			v_u4[arg1] = v3
			return v3
		end
		return v_u4[arg1]
	end
}