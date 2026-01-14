-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local v_u3 = v_replicatedstorage:FindFirstChild("Sounds") or Instance.new("Folder", v_replicatedstorage)
v_u3.Name = "Sounds"
local v_u_debris = workspace:WaitForChild("Debris")
local function v_u4(arg1)
	local v_split = string.split(arg1, ".")
	local v1 = game
	for v2, v3 in ipairs(v_split) do
		if v1 and v2 > 1 then
			v1 = v1:FindFirstChild(v3)
			if not v1 then
				error((("Path: \"%*\" does not exist"):format(arg1)))
			end
		end
	end
	return v1
end
local function v_u5(arg1, arg2, arg3)
	local v_sound = Instance.new("Sound")
	v_sound.RollOffMaxDistance = arg3.RollOffMaxDistance or 10000
	v_sound.RollOffMinDistance = arg3.RollOffMinDistance or 10
	v_sound.TimePosition = arg3.TimePosition or 0
	v_sound.RollOffMode = Enum.RollOffMode.Inverse
	v_sound.Looped = arg3.Looped or false
	v_sound.SoundId = ("rbxassetid://%*"):format(arg2)
	v_sound.Volume = arg3.Volume or 0.5
	v_sound.Name = arg1
	return v_sound
end
function v_u1.play(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_http, (copy) v_u4
	local v_format = ("Sound couldn\'t locate sound parent for %*"):format(arg2.Name)
	assert(arg2.Parent or arg2.Path, v_format)
	if not arg1.Sounds then
		return nil
	end
	local v1 = arg1.Sounds:FindFirstChild(arg2.Name)
	if v1 then
		local v_generateguid = v_u_http:GenerateGUID(false)
		local v_parent = arg2.Parent
		if arg2.Path and not v_parent then
			v_parent = v_u4(arg2.Path)
		end
		if not v_parent then
			return nil
		end
		local v_getchildren = v1:GetChildren()
		local v_u_clone = v1:WaitForChild((math.random(1, #v_getchildren))):Clone()
		v_u_clone.Volume = v_u_clone.Volume * (arg3 or 1)
		v_u_clone.Parent = v_parent
		v_u_clone.Name = v_generateguid
		v_u_clone:Play()
		v_u_clone.Ended:Once(function()
			-- upvalues: (copy) v_u_clone
			v_u_clone:Destroy()
		end)
		return v_u_clone
	end
end
function v_u1.playOneTime(arg1, arg2, arg3)
	return arg1:play(arg2, arg3 or 1)
end
function v_u1.PlaySoundAtPosition(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_debris, (copy) v_u_http
	if arg1.IsDestroyed then
		return
	elseif arg1.Sounds then
		local v1 = arg1.Sounds:FindFirstChild(arg2.Name)
		if v1 then
			local v_add = arg1.Janitor:Add(Instance.new("Part"))
			v_add.Size = Vector3.new(1, 1, 1)
			v_add.Position = arg2.Position
			v_add.CollisionGroup = "Debris"
			v_add.CanCollide = false
			v_add.CanTouch = false
			v_add.CanQuery = false
			v_add.Anchored = true
			v_add.Transparency = 1
			v_add.Parent = v_u_debris
			v_add.Name = "Sound"
			local v_getchildren = v1:GetChildren()
			local v_u_add = arg1.Janitor:Add((v1:WaitForChild((math.random(1, #v_getchildren))):Clone()))
			v_u_add.Volume = v_u_add.Volume * (arg4 or 1)
			v_u_add.Name = v_u_http:GenerateGUID(false)
			v_u_add.Parent = v_add
			v_u_add:Play()
			if v_u_add.Looped and arg3 then
				arg1.Janitor:Add(task.delay(arg3, function()
					-- upvalues: (copy) arg1
					arg1:destroy()
				end), true)
			else
				arg1.Janitor:Add(v_u_add.Ended:Once(function()
					-- upvalues: (copy) arg1
					arg1:destroy()
				end))
			end
			arg1.Janitor:Add(v_u_add.AncestryChanged:Connect(function()
				-- upvalues: (copy) v_u_add, (copy) arg1
				if not v_u_add.Parent then
					arg1:destroy()
				end
			end))
		else
			arg1:destroy()
		end
	else
		arg1:destroy()
		return
	end
end
function v_u1.createSoundGroup(arg1)
	-- upvalues: (ref) v_u3, (copy) v_u5
	local v1 = require(arg1)
	local v_folder = Instance.new("Folder", v_u3)
	v_folder.Name = arg1.Name
	for v2, v3 in pairs(v1) do
		local v_folder = Instance.new("Folder", v_folder)
		v_folder.Name = v2
		for v4, v5 in ipairs(v3.Identifiers) do
			v_u5(v4, v5, v3.Properties).Parent = v_folder
		end
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u2, (ref) v_u3
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u2.new()
	v1.IsDestroyed = false
	v1.SoundGroupName = arg1
	v1.Sounds = v_u3:WaitForChild(arg1, 10)
	return v1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		arg1.Janitor:Destroy()
		arg1.SoundGroupName = nil
		arg1.Janitor = nil
		arg1.Sounds = nil
	end
end
return v_u1