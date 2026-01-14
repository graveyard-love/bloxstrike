-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_sound = game:GetService("SoundService")
local v_u_run = game:GetService("RunService")
local v_u_workspace = game:GetService("Workspace")
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
return v1.observeTag("AmbiencePart", function(self)
	-- upvalues: (copy) v_u2, (copy) v_u_sound, (copy) v_u_run, (copy) v_u_workspace
	if not self:IsDescendantOf(workspace) then
		return function() end
	end
	local v1 = {}
	for _, v2 in self:GetChildren() do
		if v2:IsA("Sound") then
			table.insert(v1, v2)
		end
	end
	if #v1 <= 0 then
		return function() end
	end
	local v_u_new = v_u2.new()
	local v_u3 = {}
	for _, v4 in v1 do
		local v_add = v_u_new:Add(v4:Clone())
		v_add.RollOffMode = Enum.RollOffMode.Inverse
		v_add.RollOffMaxDistance = 10000
		v_add.RollOffMinDistance = 10000
		v_add.Parent = v_u_sound
		v_add.PlayOnRemove = false
		v_add.Volume = 0
		v_add:Play()
		table.insert(v_u3, {
			["MaximumVolume"] = v4.Volume > 0 and v4.Volume or 1,
			["GlobalSound"] = v_add,
			["CurrentVolume"] = 0
		})
	end
	v_u_new:Add(v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_workspace, (copy) self, (copy) v_u3
		if v_u_workspace.CurrentCamera then
			local v1 = self
			local v_pointtoobjectspace = v1.CFrame:PointToObjectSpace(UNNAMED_1728998936520.CFrame.Position)
			local v2 = v1.Size / 2
			local v3
			if math.abs(v_pointtoobjectspace.X) <= v2.X and math.abs(v_pointtoobjectspace.Y) <= v2.Y then
				v3 = math.abs(v_pointtoobjectspace.Z) <= v2.Z
			else
				v3 = false
			end
			for _, v4 in ipairs(v_u3) do
				v4.CurrentVolume = v4.CurrentVolume + ((v3 and (v4.MaximumVolume or 0) or 0) - v4.CurrentVolume) * math.min(1, arg1 * 3)
				v4.GlobalSound.Volume = v4.CurrentVolume
			end
		end
	end))
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end)