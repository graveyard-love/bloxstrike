-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = {
	["FR"] = "ForwardRight",
	["FL"] = "ForwardLeft",
	["F"] = "Forward",
	["BR"] = "BackwardRight",
	["BL"] = "BackwardLeft",
	["B"] = "Backward",
	["R"] = "Right",
	["L"] = "Left"
}
return function(arg1)
	-- upvalues: (copy) v_u1
	local v_primarypart = arg1.PrimaryPart
	local v1, v2, v3, v4
	if v_primarypart then
		local v5 = v_primarypart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
		if v5.Magnitude < 0.1 then
			v1 = false
			v2 = false
			v3 = false
			v4 = false
		else
			local v_dot = v_primarypart.CFrame.RightVector:Dot(v5.Unit)
			local v_dot = v_primarypart.CFrame.LookVector:Dot(v5.Unit)
			v2 = v_dot < -0.3
			v1 = v_dot > 0.3
			v4 = v_dot > 0.3
			v3 = v_dot < -0.3
		end
	else
		v1 = false
		v2 = false
		v3 = false
		v4 = false
	end
	return v_u1[table.concat({
		v1 and "F" or "",
		v2 and "B" or "",
		v3 and "L" or "",
		v4 and "R" or ""
	})]
end