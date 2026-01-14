-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
require(script:WaitForChild("Types"))
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_tween
	v_u2.new("Miscellaneous"):playOneTime({
		["Parent"] = arg1.Handle,
		["Name"] = "Open Garage"
	})
	local v_new = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	return v_u_tween:Create(arg1.Handle, v_new, {
		["Position"] = arg2 + Vector3.new(0, 10, 0)
	})
end
local function v_u4(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_tween
	v_u2.new("Miscellaneous"):playOneTime({
		["Parent"] = arg1.Handle,
		["Name"] = "Close Garage"
	})
	return v_u_tween:Create(arg1.Handle, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Position"] = arg2
	})
end
return v_u1.observeTag("Garage", function(self)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u4
	self:WaitForChild("Handle")
	if self:IsDescendantOf(workspace) then
		local v_u_position = self.Handle.Position
		local v_u1 = nil
		return v_u1.observeAttribute(self, "CurrentState", function(arg1)
			-- upvalues: (ref) v_u1, (ref) v_u3, (copy) self, (copy) v_u_position, (ref) v_u4
			if v_u1 then
				v_u1:Cancel()
				v_u1 = nil
			end
			if not arg1 then
				local v1 = v_u4(self, v_u_position)
				v_u1 = v1
				v1:Play()
				return function()
					-- upvalues: (ref) self, (ref) v_u4, (ref) v_u_position
					if self:IsDescendantOf(workspace) then
						v_u4(self, v_u_position)
					end
				end
			end
			local v2 = v_u3(self, v_u_position)
			v_u1 = v2
			v2:Play()
		end)
	end
end)