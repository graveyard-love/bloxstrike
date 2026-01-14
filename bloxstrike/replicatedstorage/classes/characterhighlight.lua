-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_replicatedstorage.Shared.Spring)
function v_u1.UpdateState(arg1, arg2)
	if arg1.IsEnabled ~= arg2 then
		arg1.Highlight.Enabled = arg2
		arg1.IsEnabled = arg2
	end
end
function v_u1.Construct(arg1)
	arg1.Highlight.OutlineTransparency = arg1.Properties.OutlineTransparency
	arg1.Highlight.FillTransparency = arg1.Properties.FillTransparency
	arg1.Highlight.OutlineColor = arg1.Properties.OutlineColor
	arg1.Highlight.DepthMode = arg1.Properties.DepthMode
	arg1.Highlight.FillColor = arg1.Properties.FillColor
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u3, (copy) v_u_run
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u2.new()
	v_u1.CurrentTransparency = v_u3.new(0.95, 1.5, 0.6)
	v_u1.Properties = arg2
	v_u1.Character = arg1
	v_u1.Highlight = v_u1.Janitor:Add(Instance.new("Highlight", arg1))
	v_u1.IsEnabled = false
	v_u1:Construct()
	local v_humanoid = arg1:WaitForChild("Humanoid")
	v_u1.Janitor:Add(v_humanoid.Died:Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:Destroy()
	end))
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		local v_getposition = v_u1.CurrentTransparency:getPosition()
		v_u1.CurrentTransparency:update(arg1)
		if v_getposition >= 0.8 then
			v_u1.CurrentTransparency:setGoal(0.6)
		elseif v_getposition <= 0.6 then
			v_u1.CurrentTransparency:setGoal(0.8)
		end
		v_u1.Highlight.FillTransparency = v_getposition
	end))
	return v_u1
end
function v_u1.Destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1