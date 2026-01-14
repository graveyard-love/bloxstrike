-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u_tween = game:GetService("TweenService")
local v_run = game:GetService("RunService")
local v_players = game:GetService("Players")
local v_u_new = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v_u2 = {}
local v_u3 = {}
local v_u4 = {}
local function v_u5(arg1)
	local v_rightshoulder = arg1:FindFirstChild("RightShoulder", true)
	local v_leftshoulder = arg1:FindFirstChild("LeftShoulder", true)
	local v_rootjoint = arg1:FindFirstChild("RootJoint", true)
	return v_rightshoulder, v_leftshoulder, arg1:FindFirstChild("Waist", true), arg1:FindFirstChild("Neck", true), v_rootjoint
end
function v1.updateKinematics(arg1, arg2, arg3)
	-- upvalues: (copy) v_u5, (copy) v_u2, (copy) v_u_tween, (copy) v_u_new
	local v1, v2, v3, v4, v5 = v_u5(arg2)
	if v1 and (v2 and (v3 and v4)) then
		if not v_u2[arg1] then
			v_u2[arg1] = {
				v1.C0,
				v2.C0,
				v3.C0,
				v4.C0,
				v5 and v5.C0 or nil
			}
		end
		v_u_tween:Create(v1, v_u_new, {
			["C0"] = v_u2[arg1][1] * CFrame.Angles(1.0471975511965976 * arg3.LookVector.Y * 0.5, 0, 0)
		}):Play()
		v_u_tween:Create(v2, v_u_new, {
			["C0"] = v_u2[arg1][2] * CFrame.Angles(1.0471975511965976 * arg3.LookVector.Y * 0.5, 0, 0)
		}):Play()
		v_u_tween:Create(v3, v_u_new, {
			["C0"] = v_u2[arg1][3] * CFrame.Angles(1.0471975511965976 * arg3.LookVector.Y * 0.6, 0, 0)
		}):Play()
		v_u_tween:Create(v4, v_u_new, {
			["C0"] = v_u2[arg1][4] * CFrame.Angles(1.0471975511965976 * arg3.LookVector.Y, 0, 0)
		}):Play()
	end
end
function v1.setTargetRotation(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u4, (copy) v_u2, (copy) v_u5
	v_u3[arg1] = arg2
	if v_u4[arg1] == nil then
		v_u4[arg1] = arg2
	end
	local v_character = arg1.Character
	if v_character and not v_u2[arg1] then
		local v1, v2, v3, v4, v5 = v_u5(v_character)
		if v1 and (v2 and (v3 and v4)) then
			v_u2[arg1] = {
				v1.C0,
				v2.C0,
				v3.C0,
				v4.C0,
				v5 and v5.C0 or nil
			}
		end
	end
end
function v1.cleanup(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u3, (copy) v_u4, (copy) v_u5, (copy) v_u_tween, (copy) v_u_new
	local v1 = v_u2[arg1]
	v_u2[arg1] = nil
	v_u3[arg1] = nil
	v_u4[arg1] = nil
	if v1 and arg1.Character then
		local v2, v3, v4, v5, v6 = v_u5(arg1.Character)
		if not (v2 and (v3 and (v4 and v5))) then
			return
		end
		v_u_tween:Create(v2, v_u_new, {
			["C0"] = v1[1]
		}):Play()
		v_u_tween:Create(v3, v_u_new, {
			["C0"] = v1[2]
		}):Play()
		v_u_tween:Create(v4, v_u_new, {
			["C0"] = v1[3]
		}):Play()
		v_u_tween:Create(v5, v_u_new, {
			["C0"] = v1[4]
		}):Play()
		if v6 and v1[5] then
			v6.C0 = v1[5]
		end
	end
end
v_run.RenderStepped:Connect(function(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u4, (copy) v_u5, (copy) v_u2
	local v_min = math.min(1, arg1 * 15)
	for v1, v2 in pairs(v_u3) do
		local v_character = v1.Character
		if v_character then
			local v3 = v_u4[v1] or v2
			local v4 = v2 - v3
			while v4 > 3.141592653589793 do
				v4 = v4 - 6.283185307179586
			end
			while v4 < -3.141592653589793 do
				v4 = v4 + 6.283185307179586
			end
			local v5 = v3 + v4 * v_min
			v_u4[v1] = v5
			local _, _, _, _, v6 = v_u5(v_character)
			if v6 then
				local v7 = v_u2[v1]
				if v7 then
					v7 = v7[5]
				end
				if v7 then
					v6.C0 = CFrame.new(v7.Position) * CFrame.Angles(0, v5, 0)
				end
			end
		end
	end
end)
v_players.PlayerRemoving:Connect(function(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u3, (copy) v_u4
	v_u2[arg1] = nil
	v_u3[arg1] = nil
	v_u4[arg1] = nil
end)
return v1