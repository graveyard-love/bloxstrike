-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u1 = require(v_replicatedstorage.Database.Security.Router)
return function(self)
	-- upvalues: (copy) v_u1, (copy) v_u_tween, (copy) v_u_new
	local v_u_size = self.Size
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		v_u1.broadcastRouter("RunInterfaceSound", "UI Highlight")
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_u_new, v1):Play()
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		v_u1.broadcastRouter("RunInterfaceSound", "UI Highlight")
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 1, v2.X.Offset, v2.Y.Scale * 1, v2.Y.Offset)
		v_u_tween:Create(self, v_u_new, v1):Play()
	end)
	self.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		v_u1.broadcastRouter("RunInterfaceSound", "UI Click")
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.9, v2.X.Offset, v2.Y.Scale * 0.9, v2.Y.Offset)
		v_u_tween:Create(self, v_u_new, v1):Play()
	end)
	self.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_u_new, v1):Play()
	end)
end