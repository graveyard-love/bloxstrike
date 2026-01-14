-- Decompiled with Bunni.lol Decompiler

local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_userraycastupdateapi = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI")
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_u1 = {
	["spacing"] = 8,
	["image"] = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
	["imageSize"] = Vector2.new(2, 2)
}
local v_u_model = Instance.new("Model")
v_u_model.Name = "PathDisplayPoints"
local v_part = Instance.new("Part")
v_part.Anchored = true
v_part.CanCollide = false
v_part.Transparency = 1
v_part.Name = "PathDisplayAdornee"
v_part.CFrame = CFrame.new(0, 0, 0)
v_part.Parent = v_u_model
local v_u2 = 30
local v_u3 = {}
local v_u4 = {}
local v_u5 = {}
for v6 = 1, v_u2 do
	local v_imagehandleadornment = Instance.new("ImageHandleAdornment")
	v_imagehandleadornment.Archivable = false
	v_imagehandleadornment.Adornee = v_part
	v_imagehandleadornment.Image = v_u1.image
	v_imagehandleadornment.Size = v_u1.imageSize
	v_u3[v6] = v_imagehandleadornment
end
local function v_u7(arg1, _)
	-- upvalues: (ref) v_u2, (copy) v_u3, (copy) v_u_userraycastupdateapi, (copy) v_u_new, (copy) v_u_model
	if v_u2 == 0 then
		return nil
	else
		local v1 = v_u3[1]
		if v1 then
			v_u3[1] = v_u3[v_u2]
			v_u3[v_u2] = nil
			v_u2 = v_u2 - 1
		else
			v1 = nil
		end
		if v_u_userraycastupdateapi then
			v_u_new.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
			local v_raycast = workspace:Raycast(arg1 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0), v_u_new)
			if not v_raycast then
				return nil
			end
			v1.CFrame = CFrame.lookAlong(v_raycast.Position, v_raycast.Normal)
			v1.Parent = v_u_model
			return v1
		else
			local v_new = Ray.new(arg1 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0))
			local v_findpartonraywithignorelist, v2, v3 = workspace:FindPartOnRayWithIgnoreList(v_new, { game.Players.LocalPlayer.Character, workspace.CurrentCamera })
			if not v_findpartonraywithignorelist then
				return nil
			end
			v1.CFrame = CFrame.new(v2, v2 + v3)
			v1.Parent = v_u_model
			return v1
		end
	end
end
function v_u1.setCurrentPoints(arg1)
	-- upvalues: (ref) v_u4
	if typeof(arg1) == "table" then
		v_u4 = arg1
	else
		v_u4 = {}
	end
end
function v_u1.clearRenderedPath()
	-- upvalues: (ref) v_u5, (ref) v_u2, (copy) v_u3, (copy) v_u_model
	for _, v1 in ipairs(v_u5) do
		v1.Parent = nil
		v_u3[v_u2 + 1] = v1
	end
	v_u5 = {}
	v_u_model.Parent = nil
end
function v_u1.renderPath()
	-- upvalues: (copy) v_u1, (ref) v_u4, (ref) v_u5, (copy) v_u7, (copy) v_u_model
	v_u1.clearRenderedPath()
	if v_u4 and #v_u4 ~= 0 then
		local v1 = #v_u4
		v_u5[1] = v_u7(v_u4[v1], true)
		if v_u5[1] then
			local v2 = 0
			while true do
				local v3 = v_u4[v1]
				local v4 = v_u4[v1 - 1]
				if v1 < 2 then
					break
				end
				local v5 = v4 - v3
				local v_magnitude = v5.magnitude
				if v_magnitude < v2 then
					v2 = v2 - v_magnitude
					v1 = v1 - 1
				else
					local v6 = v_u7(v3 + v5.unit * v2, false)
					if v6 then
						v_u5[#v_u5 + 1] = v6
					end
					v2 = v2 + v_u1.spacing
				end
			end
			v_u_model.Parent = workspace.CurrentCamera
		end
	else
		return
	end
end
return v_u1