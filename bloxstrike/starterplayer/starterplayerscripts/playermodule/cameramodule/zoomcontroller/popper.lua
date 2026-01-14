-- Decompiled with Bunni.lol Decompiler

local v_players = game:GetService("Players")
local v_commonutils = script.Parent.Parent.Parent:WaitForChild("CommonUtils")
local v1 = require(v_commonutils:WaitForChild("FlagUtil"))
local v2 = require(v_commonutils:WaitForChild("CameraWrapper"))
local v3 = require(v_commonutils:WaitForChild("ConnectionUtil"))
local v_u_userraycastupdateapi = v1.getUserFlag("UserRaycastUpdateAPI")
local v_u_getuserflag = v1.getUserFlag("UserCurrentCameraUpdate2")
local v_u_getuserflag = v1.getUserFlag("UserPlayerConnectionMemoryLeak")
local v_u4
if v_u_getuserflag then
	v_u4 = v2.new()
else
	v_u4 = nil
end
local v_u5
if v_u_getuserflag then
	v_u5 = nil
else
	v_u5 = game.Workspace.CurrentCamera
end
if v_u_getuserflag then
	v_u4:Enable()
end
local v_u_min = math.min
local v_u_tan = math.tan
local v_u_rad = math.rad
local v_u_new = Ray.new
local v_u_new = RaycastParams.new()
v_u_new.IgnoreWater = true
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_u_new = RaycastParams.new()
v_u_new.IgnoreWater = true
v_u_new.FilterType = Enum.RaycastFilterType.Include
local v_u6
if v_u_getuserflag then
	v_u6 = v3.new()
else
	v_u6 = nil
end
local v_u7 = nil
local v_u8 = nil
local v_u9, v_u10, v_u11
if v_u_getuserflag then
	local function v12()
		-- upvalues: (copy) v_u4, (copy) v_u_rad, (ref) v_u8, (copy) v_u_tan, (ref) v_u7
		local v_getcamera = v_u4:getCamera()
		local v1 = v_u_rad(v_getcamera.FieldOfView)
		local v_viewportsize = v_getcamera.ViewportSize
		v_u7 = v_viewportsize.X / v_viewportsize.Y * (v_u_tan(v1 / 2) * 2)
	end
	v_u4:Connect("FieldOfView", v12)
	v_u4:Connect("ViewportSize", v12)
	local v_getcamera = v_u4:getCamera()
	local v13 = v_u_rad(v_getcamera.FieldOfView)
	local v_viewportsize = v_getcamera.ViewportSize
	local v14 = v_u_tan(v13 / 2) * 2
	local v15 = v_viewportsize.X / v_viewportsize.Y * v14
	local v_u_nearplanez = v_u4:getCamera().NearPlaneZ
	v_u4:Connect("NearPlaneZ", function()
		-- upvalues: (ref) v_u_nearplanez, (copy) v_u4
		v_u_nearplanez = v_u4:getCamera().NearPlaneZ
	end)
	v_u9 = v14
	v_u10 = v15
	v_u11 = v_u_nearplanez
else
	local function v16()
		-- upvalues: (ref) v_u5, (copy) v_u_rad, (ref) v_u8, (copy) v_u_tan, (ref) v_u7
		local v1 = v_u_rad(v_u5.FieldOfView)
		local v_viewportsize = v_u5.ViewportSize
		v_u7 = v_viewportsize.X / v_viewportsize.Y * (v_u_tan(v1 / 2) * 2)
	end
	v_u5:GetPropertyChangedSignal("FieldOfView"):Connect(v16)
	v_u5:GetPropertyChangedSignal("ViewportSize"):Connect(v16)
	local v17 = v_u_rad(v_u5.FieldOfView)
	local v_viewportsize = v_u5.ViewportSize
	local v18 = v_u_tan(v17 / 2) * 2
	local v19 = v_viewportsize.X / v_viewportsize.Y * v18
	local v_u_nearplanez = v_u5.NearPlaneZ
	v_u5:GetPropertyChangedSignal("NearPlaneZ"):Connect(function()
		-- upvalues: (ref) v_u_nearplanez, (ref) v_u5
		v_u_nearplanez = v_u5.NearPlaneZ
	end)
	v_u9 = v18
	v_u10 = v19
	v_u11 = v_u_nearplanez
end
local v_u20 = {}
local v_u21 = {}
local function v22(self)
	-- upvalues: (copy) v_u21, (ref) v_u20, (copy) v_u_getuserflag, (copy) v_u6
	local function v1(arg1)
		-- upvalues: (ref) v_u21, (copy) self, (ref) v_u20
		v_u21[self] = arg1
		local v1 = 1
		v_u20 = {}
		for _, v2 in pairs(v_u21) do
			v_u20[v1] = v2
			v1 = v1 + 1
		end
	end
	local function v2()
		-- upvalues: (ref) v_u21, (copy) self, (ref) v_u20
		v_u21[self] = nil
		local v1 = 1
		v_u20 = {}
		for _, v2 in pairs(v_u21) do
			v_u20[v1] = v2
			v1 = v1 + 1
		end
	end
	if v_u_getuserflag then
		v_u6:trackConnection(("%*CharacterAdded"):format(self.UserId), self.CharacterAdded:Connect(v1))
		v_u6:trackConnection(("%*CharacterRemoving"):format(self.UserId), self.CharacterRemoving:Connect(v2))
	else
		self.CharacterAdded:Connect(v1)
		self.CharacterRemoving:Connect(v2)
	end
	if self.Character then
		v_u21[self] = self.Character
		local v3 = 1
		v_u20 = {}
		for _, v4 in pairs(v_u21) do
			v_u20[v3] = v4
			v3 = v3 + 1
		end
	end
end
local function v23(arg1)
	-- upvalues: (copy) v_u21, (ref) v_u20, (copy) v_u_getuserflag, (copy) v_u6
	v_u21[arg1] = nil
	local v1 = 1
	v_u20 = {}
	for _, v2 in pairs(v_u21) do
		v_u20[v1] = v2
		v1 = v1 + 1
	end
	if v_u_getuserflag then
		v_u6:disconnect((("%*CharacterAdded"):format(arg1.UserId)))
		v_u6:disconnect((("%*CharacterRemoving"):format(arg1.UserId)))
	end
end
v_players.PlayerAdded:Connect(v22)
v_players.PlayerRemoving:Connect(v23)
for _, v24 in ipairs(v_players:GetPlayers()) do
	v22(v24)
end
local v25 = 1
v_u20 = {}
local v_u26 = v_u20
for _, v27 in pairs(v_u21) do
	v_u26[v25] = v27
	v25 = v25 + 1
end
local v_u28 = nil
local v_u29 = nil
if v_u_getuserflag then
	v_u4:Connect("CameraSubject", function()
		-- upvalues: (copy) v_u4, (ref) v_u29
		local v_camerasubject = v_u4:getCamera().CameraSubject
		if v_camerasubject and v_camerasubject:IsA("Humanoid") then
			v_u29 = v_camerasubject.RootPart
			return
		elseif v_camerasubject and v_camerasubject:IsA("BasePart") then
			v_u29 = v_camerasubject
		else
			v_u29 = nil
		end
	end)
else
	v_u5:GetPropertyChangedSignal("CameraSubject"):Connect(function()
		-- upvalues: (ref) v_u5, (ref) v_u29
		local v_camerasubject = v_u5.CameraSubject
		if v_camerasubject:IsA("Humanoid") then
			v_u29 = v_camerasubject.RootPart
			return
		elseif v_camerasubject:IsA("BasePart") then
			v_u29 = v_camerasubject
		else
			v_u29 = nil
		end
	end)
end
local v_u30 = {
	Vector2.new(0.4, 0),
	Vector2.new(-0.4, 0),
	Vector2.new(0, -0.4),
	Vector2.new(0, 0.4),
	Vector2.new(0, 0.2)
}
local function v_u31(arg1, arg2)
	-- upvalues: (copy) v_u_userraycastupdateapi, (copy) v_u_new, (ref) v_u26, (copy) v_u_new
	if v_u_userraycastupdateapi then
		v_u_new.FilterDescendantsInstances = v_u26
		while true do
			local v_raycast = workspace:Raycast(arg1, arg2, v_u_new)
			if v_raycast then
				if v_raycast.Instance.CanCollide then
					return v_raycast.Position, true
				end
				v_u_new:AddToFilter(v_raycast.Instance)
			end
			if not v_raycast then
				::l8::
				return arg1 + arg2, false
			end
		end
	else
		local v1 = #v_u26
		while true do
			local v_findpartonraywithignorelist, v2 = workspace:FindPartOnRayWithIgnoreList(v_u_new(arg1, arg2), v_u26, false, true)
			if v_findpartonraywithignorelist then
				if v_findpartonraywithignorelist.CanCollide then
					local v3 = v_u26
					for v4 = #v3, v1 + 1, -1 do
						v3[v4] = nil
					end
					return v2, true
				end
				v_u26[#v_u26 + 1] = v_findpartonraywithignorelist
			end
			if not v_findpartonraywithignorelist then
				local v5 = v_u26
				for v6 = #v5, v1 + 1, -1 do
					v5[v6] = nil
				end
				goto l8
			end
		end
	end
end
local function v_u32(arg1, arg2, arg3, arg4)
	-- upvalues: (ref) v_u26, (ref) v_u11, (copy) v_u_userraycastupdateapi, (copy) v_u_new, (ref) v_u28, (copy) v_u_new, (copy) v_u_new
	debug.profilebegin("queryPoint")
	local v1 = #v_u26
	local v2 = arg3 + v_u11
	local v3 = arg1 + arg2 * v2
	local v4 = (1 / 0)
	local v5 = (1 / 0)
	local v6 = 0
	local v7
	if v_u_userraycastupdateapi then
		v_u_new.FilterDescendantsInstances = v_u26
		local v8 = arg1
		while true do
			local v_raycast = workspace:Raycast(arg1, v3 - arg1, v_u_new)
			if not v_raycast then
				v7 = v4
				break
			end
			v6 = v6 + 1
			local v_instance = v_raycast.Instance
			local v_position = v_raycast.Position
			v7 = (v_position - v8).Magnitude
			if v6 >= 64 then
				v5 = v7
				v7 = v4
			else
				local v9 = 1 - (1 - v_instance.Transparency) * (1 - v_instance.LocalTransparencyModifier) < 0.25 and v_instance.CanCollide
				if v9 then
					if v_u28 == (v_instance:GetRootPart() or v_instance) then
						v9 = false
					else
						v9 = not v_instance:IsA("TrussPart")
					end
				end
				if v9 then
					v_u_new.FilterDescendantsInstances = { v_instance }
					if workspace:Raycast(v3, v_position - v3, v_u_new) then
						local v10
						if arg4 then
							v10 = workspace:Raycast(arg4, v3 - arg4, v_u_new) or workspace:Raycast(v3, arg4 - v3, v_u_new)
						else
							v10 = false
						end
						if v10 then
							v5 = v7
							v7 = v4
						elseif v2 >= v4 then
							v7 = v4
						end
					else
						v5 = v7
						v7 = v4
					end
				else
					v7 = v4
				end
			end
			v_u_new:AddToFilter(v_instance)
			arg1 = v_position - arg2 * 0.001
			if v5 < (1 / 0) or not v_instance then
				break
			end
			v4 = v7
		end
	else
		local v11 = arg1
		while true do
			if true then
				local v_findpartonraywithignorelist, v12 = workspace:FindPartOnRayWithIgnoreList(v_u_new(arg1, v3 - arg1), v_u26, false, true)
				v6 = v6 + 1
				if v_findpartonraywithignorelist then
					local v13 = v6 >= 64
					local v14 = 1 - (1 - v_findpartonraywithignorelist.Transparency) * (1 - v_findpartonraywithignorelist.LocalTransparencyModifier) < 0.25 and v_findpartonraywithignorelist.CanCollide
					if v14 then
						if v_u28 == (v_findpartonraywithignorelist:GetRootPart() or v_findpartonraywithignorelist) then
							v14 = false
						else
							v14 = not v_findpartonraywithignorelist:IsA("TrussPart")
						end
					end
					if v14 or v13 then
						local v15 = { v_findpartonraywithignorelist }
						local v_findpartonraywithwhitelist = workspace:FindPartOnRayWithWhitelist(v_u_new(v3, v12 - v3), v15, true)
						v7 = (v12 - v11).Magnitude
						if v_findpartonraywithwhitelist and not v13 then
							local v16
							if arg4 then
								v16 = workspace:FindPartOnRayWithWhitelist(v_u_new(arg4, v3 - arg4), v15, true) or workspace:FindPartOnRayWithWhitelist(v_u_new(v3, arg4 - v3), v15, true)
							else
								v16 = false
							end
							if v16 then
								v5 = v7
								v7 = v4
							elseif v2 >= v4 then
								v7 = v4
							end
						else
							v5 = v7
							v7 = v4
						end
					else
						v7 = v4
					end
					v_u26[#v_u26 + 1] = v_findpartonraywithignorelist
					arg1 = v12 - arg2 * 0.001
				else
					v7 = v4
				end
			end
			if v5 < (1 / 0) or not v_findpartonraywithignorelist then
				break
			end
			v4 = v7
		end
		local v17 = v_u26
		for v18 = #v17, v1 + 1, -1 do
			v17[v18] = nil
		end
	end
	debug.profileend()
	return v7 - v_u11, v5 - v_u11
end
local function v_u33(arg1, arg2)
	-- upvalues: (ref) v_u5, (copy) v_u_getuserflag, (copy) v_u4, (ref) v_u10, (ref) v_u9, (ref) v_u11, (copy) v_u32
	debug.profilebegin("queryViewport")
	local v_p = arg1.p
	local v_rightvector = arg1.rightVector
	local v_upvector = arg1.upVector
	local v1 = -arg1.lookVector
	local v2
	if v_u_getuserflag then
		v2 = v_u4:getCamera()
	else
		v2 = v_u5
	end
	local v_viewportsize = v2.ViewportSize
	local v3 = (1 / 0)
	local v4 = (1 / 0)
	for v5 = 0, 1 do
		local v6 = v_rightvector * ((v5 - 0.5) * v_u10)
		for v7 = 0, 1 do
			local v8, v9 = v_u32(v_p + v_u11 * (v6 + v_upvector * ((v7 - 0.5) * v_u9)), v1, arg2, v_u5:ViewportPointToRay(v_viewportsize.x * v5, v_viewportsize.y * v7).Origin)
			if v9 >= v3 then
				v9 = v3
			end
			if v8 < v4 then
				v4 = v8
				v3 = v9
			else
				v3 = v9
			end
		end
	end
	debug.profileend()
	return v4, v3
end
local function v_u34()
	-- upvalues: (copy) v_u31, (copy) v_u_min, (copy) v_u32, (copy) v_u30
	-- failed to decompile
end
return function(arg1, arg2, arg3)
	-- upvalues: (ref) v_u28, (ref) v_u29, (copy) v_u33, (copy) v_u34
	debug.profilebegin("popper")
	v_u28 = v_u29 and v_u29:GetRootPart() or v_u29
	local v1, v2 = v_u33(arg1, arg2)
	if v2 >= arg2 then
		v2 = arg2
	end
	if v1 < v2 then
		if not v_u34(arg1, arg2, arg3) then
			v1 = v2
		end
	else
		v1 = v2
	end
	v_u28 = nil
	debug.profileend()
	return v1
end