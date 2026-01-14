-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_debris = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local function v_u3(arg1)
	-- upvalues: (copy) v_u_debris
	local v_getpivot = arg1:GetPivot()
	arg1:SetAttribute("Broken", false)
	arg1:RemoveTag("Market Window")
	arg1:RemoveTag("Interactable")
	local v_clone = arg1:Clone()
	v_clone:PivotTo(v_getpivot)
	v_clone.Parent = v_u_debris
	for _, v1 in ipairs(v_clone:GetChildren()) do
		if v1:IsA("BasePart") then
			v1.CanCollide = true
			v1.Transparency = 0
		end
	end
	return v_clone
end
local function v_u4(arg1)
	-- upvalues: (copy) v_u_debris, (copy) v_u2
	local v_direction = arg1:GetAttribute("Direction")
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v1:IsA("BasePart") then
			v1.CollisionGroup = "Debris"
			v1.Anchored = false
			v1:ApplyImpulse((Vector3.new(v_direction.X * math.random(7, 12), v_direction.Y * math.random(7, 12), v_direction.Z * math.random(7, 12))))
		end
	end
	v_u_debris:AddItem(arg1, 5)
	v_u2.new("Bullet"):playOneTime({
		["Name"] = "Break Market Window",
		["Parent"] = arg1.PrimaryPart
	})
end
return v_u1.observeTag("Market Window", function(self)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u4
	if self:IsDescendantOf(workspace) then
		return v_u1.observeAttribute(self, "Broken", function(arg1)
			-- upvalues: (ref) v_u3, (copy) self, (ref) v_u4
			if arg1 then
				v_u4((v_u3(self)))
			end
		end)
	end
end)