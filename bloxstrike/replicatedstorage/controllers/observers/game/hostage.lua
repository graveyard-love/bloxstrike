-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_replicatedstorage.Classes.Sound)
local v_u_animation = Instance.new("Animation", nil)
v_u_animation.AnimationId = "rbxassetid://130065050998927"
v_u_animation.Name = "HOSTAGE_IDLE"
local v_u_animation = Instance.new("Animation", nil)
v_u_animation.AnimationId = "rbxassetid://84183418979817"
v_u_animation.Name = "HOSTAGE_CARRYING"
local function v_u4(arg1)
	-- upvalues: (copy) v_u_animation, (copy) v_u_animation
	local v_animator = arg1:WaitForChild("Humanoid"):WaitForChild("Animator")
	local v1 = arg1:GetAttribute("State") == "Carrying" and v_animator:LoadAnimation(v_u_animation) or (arg1:GetAttribute("State") == "Idle" and v_animator:LoadAnimation(v_u_animation) or nil)
	if v1 then
		v1:Play()
	end
	return v1
end
return v1.observeTag("Hostage", function(self)
	-- upvalues: (copy) v_u2, (copy) v_u3, (copy) v_u4
	local v_humanoidrootpart = self:WaitForChild("HumanoidRootPart", 10)
	local v_humanoid = self:WaitForChild("Humanoid", 10)
	local v1 = self:WaitForChild("Head", 10) or (v_humanoid or v_humanoidrootpart)
	if v1 then
		if not self:IsDescendantOf(workspace) then
			return function() end
		end
		local v_u_new = v_u2.new()
		local v_u_hostage = v_u3.new("Hostage")
		local v_u2 = nil
		v_u_hostage:playOneTime({
			["Name"] = "Hostage Idle",
			["Parent"] = v1
		})
		v_u_new:Add(self:GetAttributeChangedSignal("State"):Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u4, (copy) self
			if v_u2 then
				v_u2:Stop()
				v_u2 = nil
			end
			v_u2 = v_u4(self)
		end))
		v_u2 = v_u4(self)
		v_u_new:Add(function()
			-- upvalues: (copy) v_u_hostage
			v_u_hostage:destroy()
		end)
		return function()
			-- upvalues: (copy) v_u_new
			v_u_new:Destroy()
		end
	end
end)