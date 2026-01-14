-- Decompiled with Bunni.lol Decompiler

local v1 = {}
game:GetService("ReplicatedStorage")
local v_u_haptic = game:GetService("HapticService")
local v_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u2 = {}
function v1.vibrate(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2
	if v_u2[arg1] then
		local v1 = v_u2[arg1]
		if v1.Length < arg3 then
			v1.Length = arg3
		end
		if v1.Intensity < arg2 then
			v1.Intensity = arg2
			return
		end
	else
		v_u2[arg1] = {
			["Intensity"] = arg2,
			["Length"] = arg3
		}
	end
end
v_run.RenderStepped:Connect(function(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_haptic
	for v1, v2 in pairs(v_u2) do
		v2.Length = v2.Length - arg1
		if v_u_haptic:IsMotorSupported(Enum.UserInputType.Gamepad1, v1) then
			v_u_haptic:SetMotor(Enum.UserInputType.Gamepad1, v1, v2.Intensity)
		end
		if v2.Length <= 0 then
			v_u_haptic:SetMotor(Enum.UserInputType.Gamepad1, v1, 0)
			if v_u2[v1] then
				v_u2[v1] = nil
			end
		end
	end
end)
return v1