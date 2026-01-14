-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = require(v_replicatedstorage.Shared.DebugFlags)
return function()
	-- upvalues: (copy) v_u_debris, (copy) v_u1
	local v1 = 0
	local v2 = 0
	for _, v3 in ipairs(v_u_debris:GetChildren()) do
		if not v3:IsA("Folder") then
			local v4
			if v3:GetAttribute("PersistentDebris") == true then
				v4 = true
			else
				local v_name = v3.Name
				v4 = string.sub(v_name, -7) == "_Weapon" and true or string.find(v_name, "_WeaponAttachments", 1, true) ~= nil
			end
			if v4 then
				v1 = v1 + 1
			else
				v2 = v2 + 1
				v3:Destroy()
			end
		end
	end
	if v_u1.IsEnabled("DebrisCleanup") then
		warn(("[DebrisCleanup][Client] CleanupDebris received: destroyed=%d skipped=%d"):format(v2, v1))
	end
end