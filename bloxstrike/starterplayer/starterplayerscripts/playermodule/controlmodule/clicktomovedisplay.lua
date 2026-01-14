-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u2 = "rbxasset://textures/ui/traildot.png"
local v_u3 = "rbxasset://textures/ui/waypoint.png"
local v_u4 = false
local v_u_new = UDim2.new(0, 42, 0, 50)
local v_u_new = Vector2.new(0, 0.5)
local v_u_new = Vector2.new(0, 1)
local v_u_new = Vector2.new(0, 0.5)
local v_u_new = Vector2.new(0.1, 0.5)
local v_u_new = Vector2.new(-0.1, 0.5)
local v_u_new = Vector2.new(1.5, 1.5)
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_players = game:GetService("Players")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_u_workspace = game:GetService("Workspace")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_userraycastupdateapi = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI")
local v_u_localplayer = v_players.LocalPlayer
local function v_u5()
	-- upvalues: (ref) v_u_new, (ref) v_u4, (ref) v_u2, (copy) v_u_new, (copy) v_u_new, (ref) v_u3, (copy) v_u_new
	local v_part = Instance.new("Part")
	v_part.Size = Vector3.new(1, 1, 1)
	v_part.Anchored = true
	v_part.CanCollide = false
	v_part.Name = "TrailDot"
	v_part.Transparency = 1
	local v_imagehandleadornment = Instance.new("ImageHandleAdornment")
	v_imagehandleadornment.Name = "TrailDotImage"
	v_imagehandleadornment.Size = v_u_new
	v_imagehandleadornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v_imagehandleadornment.AlwaysOnTop = v_u4
	v_imagehandleadornment.Image = v_u2
	v_imagehandleadornment.Adornee = v_part
	v_imagehandleadornment.Parent = v_part
	local v_part = Instance.new("Part")
	v_part.Size = Vector3.new(2, 2, 2)
	v_part.Anchored = true
	v_part.CanCollide = false
	v_part.Name = "EndWaypoint"
	v_part.Transparency = 1
	local v_imagehandleadornment = Instance.new("ImageHandleAdornment")
	v_imagehandleadornment.Name = "TrailDotImage"
	v_imagehandleadornment.Size = v_u_new
	v_imagehandleadornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v_imagehandleadornment.AlwaysOnTop = v_u4
	v_imagehandleadornment.Image = v_u2
	v_imagehandleadornment.Adornee = v_part
	v_imagehandleadornment.Parent = v_part
	local v_billboardgui = Instance.new("BillboardGui")
	v_billboardgui.Name = "EndWaypointBillboard"
	v_billboardgui.Size = v_u_new
	v_billboardgui.LightInfluence = 0
	v_billboardgui.SizeOffset = v_u_new
	v_billboardgui.AlwaysOnTop = true
	v_billboardgui.Adornee = v_part
	v_billboardgui.Parent = v_part
	local v_imagelabel = Instance.new("ImageLabel")
	v_imagelabel.Image = v_u3
	v_imagelabel.BackgroundTransparency = 1
	v_imagelabel.Size = UDim2.new(1, 0, 1, 0)
	v_imagelabel.Parent = v_billboardgui
	local v_part = Instance.new("Part")
	v_part.Size = Vector3.new(2, 2, 2)
	v_part.Anchored = true
	v_part.CanCollide = false
	v_part.Name = "FailureWaypoint"
	v_part.Transparency = 1
	local v_imagehandleadornment = Instance.new("ImageHandleAdornment")
	v_imagehandleadornment.Name = "TrailDotImage"
	v_imagehandleadornment.Size = v_u_new
	v_imagehandleadornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v_imagehandleadornment.AlwaysOnTop = v_u4
	v_imagehandleadornment.Image = v_u2
	v_imagehandleadornment.Adornee = v_part
	v_imagehandleadornment.Parent = v_part
	local v_billboardgui = Instance.new("BillboardGui")
	v_billboardgui.Name = "FailureWaypointBillboard"
	v_billboardgui.Size = v_u_new
	v_billboardgui.LightInfluence = 0
	v_billboardgui.SizeOffset = v_u_new
	v_billboardgui.AlwaysOnTop = true
	v_billboardgui.Adornee = v_part
	v_billboardgui.Parent = v_part
	local v_frame = Instance.new("Frame")
	v_frame.BackgroundTransparency = 1
	v_frame.Size = UDim2.new(0, 0, 0, 0)
	v_frame.Position = UDim2.new(0.5, 0, 1, 0)
	v_frame.Parent = v_billboardgui
	local v_imagelabel = Instance.new("ImageLabel")
	v_imagelabel.Image = v_u3
	v_imagelabel.BackgroundTransparency = 1
	v_imagelabel.Position = UDim2.new(0, -v_u_new.X.Offset / 2, 0, -v_u_new.Y.Offset)
	v_imagelabel.Size = v_u_new
	v_imagelabel.Parent = v_frame
	return v_part, v_part, v_part
end
local v_u6, v_u7, v_u8 = v_u5()
local function v_u9(arg1, arg2)
	-- upvalues: (copy) v_u_userraycastupdateapi, (copy) v_u_new, (copy) v_u_workspace, (copy) v_u_localplayer
	if v_u_userraycastupdateapi then
		v_u_new.FilterDescendantsInstances = { v_u_workspace.CurrentCamera, v_u_localplayer.Character }
		local v_raycast = v_u_workspace:Raycast(arg2 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), v_u_new)
		if v_raycast then
			arg1.CFrame = CFrame.lookAlong(v_raycast.Position, v_raycast.Normal)
			local v_current_camera = v_u_workspace.CurrentCamera
			local v_clicktomovedisplay = v_current_camera:FindFirstChild("ClickToMoveDisplay")
			if not v_clicktomovedisplay then
				v_clicktomovedisplay = Instance.new("Model")
				v_clicktomovedisplay.Name = "ClickToMoveDisplay"
				v_clicktomovedisplay.Parent = v_current_camera
			end
			arg1.Parent = v_clicktomovedisplay
			return
		end
	else
		local v_findpartonraywithignorelist, v1, v2 = v_u_workspace:FindPartOnRayWithIgnoreList(Ray.new(arg2 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_workspace.CurrentCamera, v_u_localplayer.Character })
		if v_findpartonraywithignorelist then
			arg1.CFrame = CFrame.new(v1, v1 + v2)
			local v_current_camera = v_u_workspace.CurrentCamera
			local v_clicktomovedisplay = v_current_camera:FindFirstChild("ClickToMoveDisplay")
			if not v_clicktomovedisplay then
				v_clicktomovedisplay = Instance.new("Model")
				v_clicktomovedisplay.Name = "ClickToMoveDisplay"
				v_clicktomovedisplay.Parent = v_current_camera
			end
			arg1.Parent = v_clicktomovedisplay
		end
	end
end
local v_u10 = {}
v_u10.__index = v_u10
function v_u10.Destroy(arg1)
	arg1.DisplayModel:Destroy()
end
function v_u10.NewDisplayModel(_, arg2)
	-- upvalues: (ref) v_u6, (copy) v_u9
	local v_clone = v_u6:Clone()
	v_u9(v_clone, arg2)
	return v_clone
end
function v_u10.new(arg1, arg2)
	-- upvalues: (copy) v_u10
	local v1 = setmetatable({}, v_u10)
	v1.DisplayModel = v1:NewDisplayModel(arg1)
	v1.ClosestWayPoint = arg2
	return v1
end
local v_u11 = {}
v_u11.__index = v_u11
function v_u11.Destroy(arg1)
	arg1.Destroyed = true
	arg1.Tween:Cancel()
	arg1.DisplayModel:Destroy()
end
function v_u11.NewDisplayModel(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u9
	local v_clone = v_u7:Clone()
	v_u9(v_clone, arg2)
	return v_clone
end
function v_u11.CreateTween(arg1)
	-- upvalues: (copy) v_u_tween, (copy) v_u_new
	local v_new = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
	local v_create = v_u_tween:Create(arg1.DisplayModel.EndWaypointBillboard, v_new, {
		["SizeOffset"] = v_u_new
	})
	v_create:Play()
	return v_create
end
function v_u11.TweenInFrom(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	arg1.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (arg2 - arg1.DisplayModel.Position).Y, 0)
	local v_new = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v_create = v_u_tween:Create(arg1.DisplayModel.EndWaypointBillboard, v_new, {
		["StudsOffset"] = Vector3.new(0, 0, 0)
	})
	v_create:Play()
	return v_create
end
function v_u11.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u11
	local v_u1 = setmetatable({}, v_u11)
	v_u1.DisplayModel = v_u1:NewDisplayModel(arg1)
	v_u1.Destroyed = false
	if arg3 and (arg3 - arg1).Magnitude > 5 then
		v_u1.Tween = v_u1:TweenInFrom(arg3)
		coroutine.wrap(function()
			-- upvalues: (copy) v_u1
			v_u1.Tween.Completed:Wait()
			if not v_u1.Destroyed then
				v_u1.Tween = v_u1:CreateTween()
			end
		end)()
	else
		v_u1.Tween = v_u1:CreateTween()
	end
	v_u1.ClosestWayPoint = arg2
	return v_u1
end
local v_u12 = {}
v_u12.__index = v_u12
function v_u12.Hide(arg1)
	arg1.DisplayModel.Parent = nil
end
function v_u12.Destroy(arg1)
	arg1.DisplayModel:Destroy()
end
function v_u12.NewDisplayModel(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u9, (copy) v_u_userraycastupdateapi, (copy) v_u_new, (copy) v_u_workspace, (copy) v_u_localplayer
	local v_clone = v_u8:Clone()
	v_u9(v_clone, arg2)
	if v_u_userraycastupdateapi then
		v_u_new.FilterDescendantsInstances = { v_u_workspace.CurrentCamera, v_u_localplayer.Character }
		local v_raycast = v_u_workspace:Raycast(arg2 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), v_u_new)
		if v_raycast then
			v_clone.CFrame = CFrame.lookAlong(v_raycast.Position, v_raycast.Normal)
			local v_current_camera = v_u_workspace.CurrentCamera
			local v_clicktomovedisplay = v_current_camera:FindFirstChild("ClickToMoveDisplay")
			if not v_clicktomovedisplay then
				v_clicktomovedisplay = Instance.new("Model")
				v_clicktomovedisplay.Name = "ClickToMoveDisplay"
				v_clicktomovedisplay.Parent = v_current_camera
			end
			v_clone.Parent = v_clicktomovedisplay
			return v_clone
		end
	else
		local v_findpartonraywithignorelist, v1, v2 = v_u_workspace:FindPartOnRayWithIgnoreList(Ray.new(arg2 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_workspace.CurrentCamera, v_u_localplayer.Character })
		if v_findpartonraywithignorelist then
			v_clone.CFrame = CFrame.new(v1, v1 + v2)
			local v_current_camera = v_u_workspace.CurrentCamera
			local v_clicktomovedisplay = v_current_camera:FindFirstChild("ClickToMoveDisplay")
			if not v_clicktomovedisplay then
				v_clicktomovedisplay = Instance.new("Model")
				v_clicktomovedisplay.Name = "ClickToMoveDisplay"
				v_clicktomovedisplay.Parent = v_current_camera
			end
			v_clone.Parent = v_clicktomovedisplay
		end
	end
	return v_clone
end
function v_u12.RunFailureTween(arg1)
	-- upvalues: (copy) v_u_tween, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new
	wait(0.125)
	local v_new = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v_create = v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard, v_new, {
		["SizeOffset"] = v_u_new
	})
	v_create:Play()
	v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard.Frame, v_new, {
		["Rotation"] = 10
	}):Play()
	v_create.Completed:wait()
	local v_new = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
	local v_create = v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard, v_new, {
		["SizeOffset"] = v_u_new
	})
	v_create:Play()
	local v_new = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
	v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v_new, {
		["ImageColor3"] = Color3.new(0.75, 0.75, 0.75)
	}):Play()
	v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard.Frame, v_new, {
		["Rotation"] = -10
	}):Play()
	v_create.Completed:wait()
	local v_new = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v_create = v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard, v_new, {
		["SizeOffset"] = v_u_new
	})
	v_create:Play()
	v_u_tween:Create(arg1.DisplayModel.FailureWaypointBillboard.Frame, v_new, {
		["Rotation"] = 0
	}):Play()
	v_create.Completed:wait()
	wait(0.125)
end
function v_u12.new(arg1)
	-- upvalues: (copy) v_u12
	local v1 = setmetatable({}, v_u12)
	v1.DisplayModel = v1:NewDisplayModel(arg1)
	return v1
end
local v_u_animation = Instance.new("Animation")
v_u_animation.AnimationId = "rbxassetid://2874840706"
local v_u13 = nil
local function v_u14(arg1, arg2)
	-- upvalues: (copy) v_u10, (copy) v_u11
	local v1 = {}
	local v2 = 1
	for v3 = 1, #arg1 - 1 do
		local v4 = (arg1[v3].Position - arg1[#arg1].Position).Magnitude < 3
		local v5
		if v3 % 2 == 0 then
			v5 = not v4
		else
			v5 = false
		end
		if v5 then
			v1[v2] = v_u10.new(arg1[v3].Position, v3)
			v2 = v2 + 1
		end
	end
	local v_new = v_u11.new(arg1[#arg1].Position, #arg1, arg2)
	table.insert(v1, v_new)
	local v6 = {}
	local v7 = 1
	for v8 = #v1, 1, -1 do
		v6[v7] = v1[v8]
		v7 = v7 + 1
	end
	return v6
end
local v_u15 = 0
function v1.CreatePathDisplay(arg1, arg2)
	-- upvalues: (ref) v_u15, (copy) v_u14, (copy) v_u_run, (copy) v_u_workspace, (ref) v_u_new
	local v_u1 = v_u14(arg1, arg2)
	local function v_u2(arg1)
		-- upvalues: (copy) v_u1
		for v1 = #v_u1, 1, -1 do
			local v2 = v_u1[v1]
			if v2.ClosestWayPoint > arg1 then
				break
			end
			v2:Destroy()
			v_u1[v1] = nil
		end
	end
	local v_u3 = "ClickToMoveResizeTrail" .. v_u15 + 1
	local function v4()
		-- upvalues: (copy) v_u1, (ref) v_u_run, (copy) v_u3, (ref) v_u_workspace, (ref) v_u_new
		if #v_u1 == 0 then
			v_u_run:UnbindFromRenderStep(v_u3)
		else
			local v_p = v_u_workspace.CurrentCamera.CFrame.p
			for v1 = 1, #v_u1 do
				local v_traildotimage = v_u1[v1].DisplayModel:FindFirstChild("TrailDotImage")
				if v_traildotimage then
					v_traildotimage.Size = v_u_new * (math.clamp((v_u1[v1].DisplayModel.Position - v_p).Magnitude - 10, 0, 90) / 90 * 1.5 + 1)
				end
			end
		end
	end
	v_u_run:BindToRenderStep(v_u3, Enum.RenderPriority.Camera.Value - 1, v4)
	return function()
		-- upvalues: (copy) v_u2, (copy) arg1
		v_u2(#arg1)
	end, v_u2
end
local v_u16 = nil
function v1.DisplayFailureWaypoint(arg1)
	-- upvalues: (ref) v_u16, (copy) v_u12
	if v_u16 then
		v_u16:Hide()
	end
	local v_u_new = v_u12.new(arg1)
	v_u16 = v_u_new
	coroutine.wrap(function()
		-- upvalues: (ref) v_u_new
		v_u_new:RunFailureTween()
		v_u_new:Destroy()
		v_u_new = nil
	end)()
end
function v1.CreateEndWaypoint(arg1)
	-- upvalues: (copy) v_u11
	return v_u11.new(arg1)
end
function v1.PlayFailureAnimation()
	-- upvalues: (copy) v_u_localplayer, (ref) v_u13, (copy) v_u_animation
	local v_character = v_u_localplayer.Character
	local v1
	if v_character then
		v1 = v_character:FindFirstChildOfClass("Humanoid")
	else
		v1 = nil
	end
	if v1 then
		local v2
		if v1 == nil then
			v2 = v_u13
		else
			v_u13 = v1:LoadAnimation(v_u_animation)
			assert(v_u13, "")
			v_u13.Priority = Enum.AnimationPriority.Action
			v_u13.Looped = false
			v2 = v_u13
		end
		v2:Play()
	end
end
function v1.CancelFailureAnimation()
	-- upvalues: (ref) v_u13
	if v_u13 ~= nil and v_u13.IsPlaying then
		v_u13:Stop()
	end
end
function v1.SetWaypointTexture(arg1)
	-- upvalues: (ref) v_u2, (ref) v_u6, (ref) v_u7, (ref) v_u8, (copy) v_u5
	v_u2 = arg1
	local v1, v2, v3 = v_u5()
	v_u6 = v1
	v_u7 = v2
	v_u8 = v3
end
function v1.GetWaypointTexture()
	-- upvalues: (ref) v_u2
	return v_u2
end
function v1.SetWaypointRadius(arg1)
	-- upvalues: (ref) v_u_new, (ref) v_u6, (ref) v_u7, (ref) v_u8, (copy) v_u5
	v_u_new = Vector2.new(arg1, arg1)
	local v1, v2, v3 = v_u5()
	v_u6 = v1
	v_u7 = v2
	v_u8 = v3
end
function v1.GetWaypointRadius()
	-- upvalues: (ref) v_u_new
	return v_u_new.X
end
function v1.SetEndWaypointTexture(arg1)
	-- upvalues: (ref) v_u3, (ref) v_u6, (ref) v_u7, (ref) v_u8, (copy) v_u5
	v_u3 = arg1
	local v1, v2, v3 = v_u5()
	v_u6 = v1
	v_u7 = v2
	v_u8 = v3
end
function v1.GetEndWaypointTexture()
	-- upvalues: (ref) v_u3
	return v_u3
end
function v1.SetWaypointsAlwaysOnTop(arg1)
	-- upvalues: (ref) v_u4, (ref) v_u6, (ref) v_u7, (ref) v_u8, (copy) v_u5
	v_u4 = arg1
	local v1, v2, v3 = v_u5()
	v_u6 = v1
	v_u7 = v2
	v_u8 = v3
end
function v1.GetWaypointsAlwaysOnTop()
	-- upvalues: (ref) v_u4
	return v_u4
end
return v1