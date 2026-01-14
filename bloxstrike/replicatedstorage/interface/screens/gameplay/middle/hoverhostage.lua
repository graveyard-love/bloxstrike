-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.InputController)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u4 = nil
function v_u1.GetHoverState()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u_current_camera
	if v_u_localplayer:GetAttribute("Team") ~= "Counter-Terrorists" then
		return false
	end
	v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
	local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 5, v_u_new)
	if v_raycast then
		local v_instance = v_raycast.Instance
		if v_instance and (v_instance.Parent and v_instance.Parent:HasTag("Hostage")) or false then
			local v_parent = v_raycast.Instance.Parent
			if v_parent and v_parent:GetAttribute("CanRescue") == true then
				return true
			end
		end
	end
	return false
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u2, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u_run, (copy) v_u1
	v_u4 = arg2
	local function v_u1()
		-- upvalues: (ref) v_u2, (ref) v_u4
		local v_use = v_u2.GetActionKeybind("Use")
		v_u4.Text = ("[%*] Pick Up Hostage"):format(not v_use and "E" or v_use:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
	end
	local v_use = v_u2.GetActionKeybind("Use")
	v_u4.Text = ("[%*] Pick Up Hostage"):format(not v_use and "E" or v_use:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
	v_u3.CreateListener(v_u_localplayer, "Settings.Keyboard/Mouse", function(arg1)
		-- upvalues: (copy) v_u1
		if arg1 then
			task.defer(v_u1)
		end
	end)
	v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1, (ref) v_u4
		local v_character = v_u_localplayer.Character
		local v1
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			v1 = v_humanoid and v_humanoid.Health > 0 and true or false
		else
			v1 = false
		end
		if v1 then
			v_u4.Visible = v_u1.GetHoverState()
		end
	end)
end
return v_u1