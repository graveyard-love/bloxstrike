-- Decompiled with Bunni.lol Decompiler

local v_players = game:GetService("Players")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_u_workspace = game:GetService("Workspace")
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = v_u_workspace.CurrentCamera
local v_u_debris = v_u_workspace:WaitForChild("Debris")
local v_u_new = Color3.new(1, 1, 1)
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u1 = nil
local v_u2 = nil
local v_u3 = nil
local v_u4 = nil
local v_u5 = nil
local v_u6 = nil
local v_u7 = nil
local v_u8 = 0
local function v_u9()
	-- upvalues: (copy) v_u_new, (copy) v_u_playergui
	local v_screengui = Instance.new("ScreenGui")
	v_screengui.Name = "FlashbangEffect"
	v_screengui.DisplayOrder = 999
	v_screengui.IgnoreGuiInset = true
	v_screengui.ResetOnSpawn = false
	local v_frame = Instance.new("Frame")
	v_frame.Name = "FlashOverlay"
	v_frame.Size = UDim2.new(1, 0, 1, 0)
	v_frame.Position = UDim2.new(0, 0, 0, 0)
	v_frame.BackgroundColor3 = v_u_new
	v_frame.BackgroundTransparency = 1
	v_frame.BorderSizePixel = 0
	v_frame.ZIndex = 999
	v_frame.Parent = v_screengui
	v_screengui.Parent = v_u_playergui
	return v_screengui, v_frame
end
local function v_u10(arg1)
	-- upvalues: (ref) v_u8, (ref) v_u6, (ref) v_u7, (ref) v_u1, (ref) v_u2, (ref) v_u3, (copy) v_u9, (copy) v_u_lighting, (ref) v_u4, (ref) v_u5, (copy) v_u_tween
	task.wait(0.05)
	while v_u8 == arg1 do
		local v1 = v_u6
		local v2 = v_u7
		if not (v1 and v2) then
			break
		end
		local v_clock = os.clock()
		if v1 <= v_clock then
			break
		end
		local v3 = v_u1
		local v4 = v_u2
		local v5 = v_u3
		if not (v3 and v4) then
			v3, v4 = v_u9()
			v_u1 = v3
			v_u2 = v4
		end
		if not v5 then
			v5 = Instance.new("ColorCorrectionEffect")
			v5.Name = "FlashbangColorCorrection"
			v5.Brightness = 0
			v5.Contrast = 0
			v5.Saturation = 0
			v5.TintColor = Color3.new(1, 1, 1)
			v5.Parent = v_u_lighting
			v_u3 = v5
		end
		if v_clock < v2 then
			if v_u4 then
				v_u4:Cancel()
				v_u4 = nil
			end
			if v_u5 then
				v_u5:Cancel()
				v_u5 = nil
			end
			v4.BackgroundTransparency = 0
			v5.Brightness = 1
			v5.Saturation = -1
			task.wait(0.05)
		else
			local v6 = v1 - v_clock
			if v6 <= 0 then
				break
			end
			if v_u4 then
				v_u4:Cancel()
				v_u4 = nil
			end
			if v_u5 then
				v_u5:Cancel()
				v_u5 = nil
			end
			v_u4 = v_u_tween:Create(v4, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["BackgroundTransparency"] = 1
			})
			v_u5 = v_u_tween:Create(v5, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Brightness"] = 0,
				["Saturation"] = 0
			})
			v_u4:Play()
			v_u5:Play()
			while v_u8 == arg1 do
				local v_clock = os.clock()
				if v1 <= v_clock or v_u7 and v_clock < v_u7 then
					break
				end
				task.wait(0.05)
			end
		end
	end
	if v_u8 == arg1 then
		if v_u4 then
			v_u4:Cancel()
			v_u4 = nil
		end
		if v_u5 then
			v_u5:Cancel()
			v_u5 = nil
		end
		if v_u1 then
			v_u1:Destroy()
			v_u1 = nil
			v_u2 = nil
		end
		if v_u3 then
			v_u3:Destroy()
			v_u3 = nil
		end
		v_u6 = nil
		v_u7 = nil
	end
end
local function v_u11(arg1, arg2)
	-- upvalues: (copy) v_u_debris, (copy) v_u_localplayer, (copy) v_u_workspace, (copy) v_u_new
	local v1 = { v_u_debris }
	local v_character = v_u_localplayer.Character
	if v_character then
		table.insert(v1, v_character)
	end
	local v_map = v_u_workspace:FindFirstChild("Map")
	local v2 = v_map and v_map:FindFirstChild("Barriers")
	if v2 then
		table.insert(v1, v2)
	end
	v_u_new.FilterDescendantsInstances = v1
	local v3 = { -0.5, 0, 0.5 }
	for _, v4 in ipairs(v3) do
		for _, v5 in ipairs(v3) do
			for _, v6 in ipairs(v3) do
				local v7 = arg1 + Vector3.new(v4, v5, v6)
				local v8 = arg2 - v7
				local v_magnitude = v8.Magnitude
				if v_magnitude < 0.1 then
					return true
				end
				local v_raycast = v_u_workspace:Raycast(v7, v8, v_u_new)
				if not v_raycast or v_raycast.Distance >= v_magnitude - 0.5 then
					return true
				end
			end
		end
	end
	return false
end
return {
	["Flash"] = function(arg1)
		-- upvalues: (copy) v_u_current_camera, (copy) v_u11, (ref) v_u6, (ref) v_u7, (ref) v_u1, (ref) v_u2, (ref) v_u3, (copy) v_u9, (copy) v_u_lighting, (ref) v_u4, (ref) v_u5, (copy) v_u_tween, (ref) v_u8, (copy) v_u10
		local v_position = arg1.Position
		local v_position = v_u_current_camera.CFrame.Position
		local v_lookvector = v_u_current_camera.CFrame.LookVector
		local v1 = v_position - v_position
		local v_magnitude = v1.Magnitude
		if v_magnitude > 100 then
			return
		elseif v_u11(v_position, v_position) then
			local v2 = (0.2 + 4.8 * ((v_lookvector:Dot(v1.Unit) + 1) / 2)) * (v_magnitude <= 20 and 1 or (v_magnitude >= 100 and 0 or 1 - (v_magnitude - 20) / 80))
			if v2 >= 0.1 then
				local v_clock = os.clock()
				local v_max = math.max(v_u7 or 0, v_clock + 0.05 + v2 * 0.3)
				v_u7 = math.min(v_clock + math.min(5, (v_u6 and (math.max(0, v_u6 - v_clock) or 0) or 0) + v2), v_max)
				local v3 = v_u1
				local v4 = v_u2
				local v5 = v_u3
				if not (v3 and v4) then
					v3, v4 = v_u9()
					v_u1 = v3
					v_u2 = v4
				end
				if not v5 then
					v5 = Instance.new("ColorCorrectionEffect")
					v5.Name = "FlashbangColorCorrection"
					v5.Brightness = 0
					v5.Contrast = 0
					v5.Saturation = 0
					v5.TintColor = Color3.new(1, 1, 1)
					v5.Parent = v_u_lighting
					v_u3 = v5
				end
				if v_u4 then
					v_u4:Cancel()
					v_u4 = nil
				end
				if v_u5 then
					v_u5:Cancel()
					v_u5 = nil
				end
				local v_create = v_u_tween:Create(v4, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["BackgroundTransparency"] = 0
				})
				local v_create = v_u_tween:Create(v5, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Brightness"] = 1,
					["Saturation"] = -1
				})
				v_create:Play()
				v_create:Play()
				local v_u6 = v_u8 + 1
				task.spawn(function()
					-- upvalues: (ref) v_u10, (copy) v_u6
					v_u10(v_u6)
				end)
			end
		else
			return
		end
	end,
	["IsFlashed"] = function()
		-- upvalues: (ref) v_u6
		if v_u6 then
			return os.clock() < v_u6
		else
			return false
		end
	end
}