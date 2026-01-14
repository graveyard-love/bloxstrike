-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_debris = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local function v_u2(arg1)
	-- upvalues: (copy) v_u_debris
	local v_getpivot = arg1:GetPivot()
	arg1:SetAttribute("Broken", false)
	arg1:RemoveTag("Snowman")
	arg1:RemoveTag("Interactable")
	local v_clone = arg1:Clone()
	v_clone:PivotTo(v_getpivot)
	v_clone.Parent = v_u_debris
	for _, v1 in ipairs(v_clone:GetChildren()) do
		if v1.Name == "Head" then
			v1.CanCollide = true
			v1.Transparency = 0
		end
	end
	return v_clone
end
local function v_u3(arg1)
	-- upvalues: (copy) v_u_debris
	local v_direction = arg1:GetAttribute("Direction")
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v1.Name == "Head" then
			v1.CollisionGroup = "Debris"
			v1.Anchored = false
			v1.Massless = true
			if v_direction then
				v1:ApplyImpulse(math.random(30, 40) * v_direction)
			end
		end
	end
	v_u_debris:AddItem(arg1, 10)
end
return v_u1.observeTag("Snowman", function(self)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u3
	if self:IsDescendantOf(workspace) then
		return v_u1.observeAttribute(self, "Broken", function(arg1)
			-- upvalues: (ref) v_u2, (copy) self, (ref) v_u3
			if arg1 then
				v_u3((v_u2(self)))
			end
		end)
	end
end)