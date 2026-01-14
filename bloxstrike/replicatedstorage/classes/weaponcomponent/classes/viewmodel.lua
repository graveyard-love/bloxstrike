-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_replicatedfirst = game:GetService("ReplicatedFirst")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_u_replicatedstorage.Classes.Sound)
local v_u5 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u7 = require(script.Classes.Animation)
local v_u8 = require(script.Classes.Bobble)
local v_u_current_camera = workspace.CurrentCamera
local function v_u9(arg1, arg2)
	local v_getdescendants = arg1:GetDescendants()
	for _, v1 in ipairs(v_getdescendants) do
		if v1:IsA("BasePart") then
			local v_hiddentransparency = v1:GetAttribute("HiddenTransparency")
			if arg2 then
				local v_transparency = v1.Transparency
				v1.Transparency = 1
				if not v_hiddentransparency then
					v1:SetAttribute("HiddenTransparency", v_transparency)
				end
			elseif v_hiddentransparency then
				v1.Transparency = v_hiddentransparency
			end
		end
	end
end
local function v_u10(arg1, arg2)
	for _, v1 in pairs(arg1:GetDescendants()) do
		if v1:IsA("MeshPart") then
			v1.Transparency = arg2 == true and 0 or 1
		elseif v1:IsA("SurfaceGui") then
			v1.Enabled = arg2
		end
	end
end
function v_u1.aim(arg1)
	-- upvalues: (copy) v_u10, (copy) v_u_current_camera
	if arg1.Bobble then
		arg1.Bobble:setIsAiming(true)
	end
	v_u10(arg1.Bobble.Scope, true)
	v_u10(arg1.Bobble.ScopeReticlePart, true)
	if arg1.MuzzlePartWeld then
		local v_cframe = v_u_current_camera.CFrame
		local v_worldpivot = arg1.Model.WorldPivot
		arg1.MuzzlePartWeld.C0 = arg1.MuzzlePartWeld.Part0.CFrame:Inverse() * (v_cframe + v_cframe.UpVector * -0.5 + v_worldpivot.LookVector * 1 + v_worldpivot.RightVector * 0.1)
	end
end
function v_u1.unaim(arg1)
	-- upvalues: (copy) v_u10
	if arg1.Bobble then
		arg1.Bobble:setIsAiming(false)
	end
	v_u10(arg1.Bobble.Scope, false)
	v_u10(arg1.Bobble.ScopeReticlePart, false)
	if arg1.OriginalC0 and arg1.MuzzlePartWeld then
		arg1.MuzzlePartWeld.C0 = arg1.OriginalC0
	end
end
function v_u1.unhide(arg1)
	-- upvalues: (copy) v_u9
	if arg1.Hidden then
		v_u9(arg1.Model, false)
		arg1.Hidden = false
	end
end
function v_u1.hide(arg1)
	-- upvalues: (copy) v_u9
	if not arg1.Hidden then
		v_u9(arg1.Model, true)
		arg1.Hidden = true
	end
end
function v_u1.equip(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera
	arg1.Model.Parent = v_u_current_camera
	if arg1.LargeWeaponModel then
		arg1.LargeWeaponModel.Parent = v_u_current_camera
	end
	arg1.Animation:stopAnimations()
	arg1.Animation:play("Idle")
	if arg1.Hidden then
		arg1:unhide()
	end
	if not arg2 then
		arg1.Animation:play("Equip")
	end
end
function v_u1.unequip(arg1)
	arg1.Animation:stopAnimations()
	arg1.Model.Parent = nil
	if arg1.LargeWeaponModel then
		arg1.LargeWeaponModel.Parent = nil
	end
end
function v_u1.applyCharmImpulse(arg1, arg2)
	if arg1.LargeCharmModel and arg1.LargeCharmModel.PrimaryPart then
		local v1 = 0
		for _, v2 in ipairs(arg1.LargeCharmModel:GetDescendants()) do
			if v2:IsA("BasePart") then
				v1 = v1 + v2:GetMass()
			end
		end
		arg1.LargeCharmModel.PrimaryPart:ApplyImpulse(arg2 * 10 * v1)
	end
end
function v_u1.render(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_current_camera
	local v1 = v_u2.Get(arg1.Player, "Settings.Game.Viewmodel") or {}
	if arg1.Bobble and (arg1.Bobble.Character and arg1.Bobble.Character.PrimaryPart) then
		local v_getnextcframe, v2, v3 = arg1.Bobble:getNextCFrame(arg2)
		arg1.Model:PivotTo(v_u_current_camera.CFrame * v_getnextcframe * CFrame.Angles(arg1.Model.Stats.Rotation.Value.X, arg1.Model.Stats.Rotation.Value.Y, arg1.Model.Stats.Rotation.Value.Z) * CFrame.new(arg1.Model.Stats.Default.Value) * CFrame.new((v1["X Offset"] or 0) / 100, (v1["Y Offset"] or 0) / 100, (v1["Z Offset"] or 0) / 100))
		if arg1.LargeWeaponModel and arg1.SmallWeaponModel then
			arg1.LargeWeaponModel:PivotTo(arg1.SmallWeaponModel:GetPivot())
			local v_position = arg1.Model.WorldPivot.Position
			if arg1.LastViewmodelPosition then
				local v4 = v_position - arg1.LastViewmodelPosition
				if arg1.LargeCharmModel and arg1.LargeCharmModel.PrimaryPart then
					arg1:applyCharmImpulse(-v4 * 0.2)
				end
			end
			arg1.LastViewmodelPosition = v_position
		end
		if arg1.Bobble.Scope and arg1.Bobble.IsAiming then
			local v_cframe = v_u_current_camera.CFrame
			arg1.Bobble.Scope:PivotTo(v_cframe + v_cframe.LookVector * 0.15 + v2 + (v3.X * -v_cframe.LookVector + v3.Y * -v_cframe.UpVector))
			if arg1.Bobble.ScopeReticlePart then
				arg1.Bobble.ScopeReticlePart.CFrame = v_cframe * CFrame.Angles(1.5707963267948966, 1.5707963267948966, -1.5707963267948966) + v_cframe.LookVector * 0.15
			end
		end
	end
end
function v_u1.attachSleeves(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage
	local v1 = v_u_replicatedstorage.Assets.Sleeves:FindFirstChild(arg2)
	if v1 then
		for _, v2 in ipairs(v1:GetChildren()) do
			local v3 = arg1.Model:FindFirstChild(v2.Name)
			if v3 then
				local v_clone = v2:Clone()
				v_clone.CastShadow = false
				v_clone.CanCollide = false
				v_clone.CanTouch = false
				v_clone.Anchored = false
				v_clone.CanQuery = false
				v_clone.Name = "Sleeve"
				v_clone.Size = Vector3.new(v3.Size.X * 1.3, v3.Size.Y * 1.4, v3.Size.Z * 0.79)
				local v_new = CFrame.new(0, -0.02, -(v3.Size.Z / 2 - v_clone.Size.Z / 2))
				v_clone.Parent = v3
				local v_motor6d = Instance.new("Motor6D", v_clone)
				v_motor6d.Part0 = v3
				v_motor6d.Part1 = v_clone
				v_motor6d.C0 = CFrame.identity
				v_motor6d.C1 = v_new
			end
		end
	end
end
function v_u1.addAttachments(arg1, arg2)
	-- upvalues: (copy) v_u6, (copy) v_u3
	local v_broadcastrouter = v_u6.broadcastRouter("GetInventoryItemFromIdentifier", arg1.Player, arg2)
	if v_broadcastrouter then
		local v_getgloves = v_u3.GetGloves(v_broadcastrouter.Name, v_broadcastrouter.Skin, v_broadcastrouter.Float)
		if v_getgloves then
			for _, v1 in ipairs(v_getgloves:GetChildren()) do
				local v2 = arg1.Model:FindFirstChild(v1.Name)
				if v2 then
					local v_clone = v1:Clone()
					v_clone.CastShadow = false
					v_clone.CanCollide = false
					v_clone.CanTouch = false
					v_clone.Anchored = true
					v_clone.CanQuery = false
					v_clone.Name = "Glove"
					v_clone.Size = Vector3.new(v2.Size.X * 1.15, v2.Size.Y * 1.18, v2.Size.Z * 0.245)
					v_clone.Parent = v2
					local v_weldconstraint = Instance.new("WeldConstraint", v_clone)
					v_weldconstraint.Part0 = v2
					v_weldconstraint.Part1 = v_clone
					v_clone.CFrame = v2.CFrame * (CFrame.new(0, 0, -(v2.Size.Z / 2 - v_clone.Size.Z / 2) * 1.035) * v_clone.PivotOffset)
					v_clone.Anchored = false
				end
			end
			if arg1.Team == "Counter-Terrorists" then
				arg1:attachSleeves((workspace:GetAttribute("CTCharacter")))
			end
		end
	else
		return
	end
end
function v_u1.construct(arg1, arg2, _)
	-- upvalues: (copy) v_u3, (copy) v_u_replicatedfirst, (copy) v_u_http
	local v1 = nil
	local v2
	if arg1.Weapon == "Smoke Grenade" then
		v2 = arg1.Team
		if v2 ~= "Counter-Terrorists" and v2 ~= "Terrorists" then
			v2 = v1
		end
	else
		v2 = v1
	end
	arg1.Model = v_u3.GetCameraModel(arg1.Weapon, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag, arg1.Charm, arg1.Stickers, v2)
	if not arg1.Model then
		error((("Viewmodel.construct: Failed to get camera model for weapon \"%*\" with skin \"%*\""):format(arg1.Weapon, arg1.Skin)))
	end
	arg1.Model.Parent = v_u_replicatedfirst
	arg1.Model.Name = arg1.Weapon
	local v_equippedgloves = arg2:GetAttribute("EquippedGloves")
	if v_equippedgloves then
		v_equippedgloves = v_u_http:JSONDecode(v_equippedgloves)
	end
	if v_equippedgloves then
		arg1:addAttachments(v_equippedgloves.SkinIdentifier)
	end
	for _, v3 in ipairs(arg1.Model:GetDescendants()) do
		if v3:IsA("BasePart") then
			v3.CollisionGroup = "Viewmodel"
			v3.CanCollide = false
			v3.CastShadow = false
			v3.CanQuery = true
			v3.CanTouch = false
			if v3.Name == "HumanoidRootPart" or v3.Name == "ViewmodelLight" then
				v3.Transparency = 1
			end
		end
	end
	local v_body_colors = arg2:FindFirstChild("Body Colors")
	for _, v4 in ipairs({ "Right Arm", "Left Arm" }) do
		if arg1.Model:FindFirstChild(v4) then
			arg1.Model:FindFirstChild(v4).Color = v_body_colors.TorsoColor3
		end
	end
	local v_interactables = arg1.Model:FindFirstChild("Interactables")
	local v5 = not v_interactables or v_interactables:FindFirstChild("MuzzlePart", true) or (v_interactables:FindFirstChild("MuzzlePartL", true) or v_interactables:FindFirstChild("MuzzlePartR", true))
	arg1.MuzzlePart = v5
	if v_interactables then
		arg1.MuzzlePartL = v_interactables:FindFirstChild("MuzzlePartL", true)
		arg1.MuzzlePartR = v_interactables:FindFirstChild("MuzzlePartR", true)
		if arg1.MuzzlePartL and arg1.MuzzlePartL:IsA("BasePart") then
			arg1.MuzzlePartL.Transparency = 1
		end
		if arg1.MuzzlePartR and arg1.MuzzlePartR:IsA("BasePart") then
			arg1.MuzzlePartR.Transparency = 1
		end
	end
	if arg1.MuzzlePart and arg1.MuzzlePart:IsA("BasePart") then
		arg1.MuzzlePart.Transparency = 1
	end
	if arg1.MuzzlePart and not arg1.MuzzlePart:FindFirstChild("WeldConstraint", true) then
		local v_getdescendants = arg1.Model:GetDescendants()
		for _, v6 in ipairs(v_getdescendants) do
			if v6:IsA("Weld") and (v6.Part1 == v5 or v6.Part0 == v5) then
				arg1.MuzzlePartWeld = v6
				arg1.OriginalC0 = v6.C0
				break
			end
		end
	end
	arg1.Model:ScaleTo(0.1)
	local v_charmbase = arg1.Model:FindFirstChild("CharmBase", true)
	if v_charmbase and v_charmbase:IsA("Model") then
		local v_model = v_charmbase:FindFirstChildOfClass("Model")
		if v_model and v_model.PrimaryPart then
			arg1.CharmModel = v_model
		end
	end
end
function v_u1.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u5, (copy) v_u_current_camera, (copy) v_u_run, (copy) v_u4, (copy) v_u7, (copy) v_u8
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u5.new()
	v_u1.IsDestroyed = false
	v_u1.Player = arg1.Player
	v_u1.Team = v_u1.Player:GetAttribute("Team")
	v_u1.Weapon = arg2
	v_u1.Skin = arg3
	v_u1.StatTrack = arg1.StatTrack
	v_u1.Stickers = arg1.Stickers
	v_u1.NameTag = arg1.NameTag
	v_u1.Float = arg1.Float
	v_u1.Charm = arg1.Charm
	debug.profilebegin("Viewmodel.new.construct")
	local v2 = not arg1.Character and v_u1.Player
	if v2 then
		v2 = v_u1.Player.Character
	end
	if v2 then
		v_u1:construct(v2, arg1)
	end
	debug.profileend()
	if v_u1.CharmModel then
		debug.profilebegin("Viewmodel.new.construct.CharmPhysics")
		v_u1.CharmModel:PivotTo(v_u1.CharmModel.Parent.PrimaryPart.CFrame * CFrame.new(0, 0, -1))
		local v_u_charmmodel = v_u1.CharmModel
		local v_u3 = v_u1.Model:FindFirstChild("Weapon") or (v_u1.Model:FindFirstChild("WeaponL") or v_u1.Model:FindFirstChild("WeaponR"))
		local v_u_clone = v_u3.Parent:Clone()
		v_u_clone.Parent = v_u_current_camera
		local v_u4 = v_u_clone:FindFirstChild("Weapon") or (v_u1.Model:FindFirstChild("WeaponL") or v_u1.Model:FindFirstChild("WeaponR"))
		for _, v5 in v_u_clone:GetChildren() do
			if v5.Name ~= "Weapon" and (v5.Name ~= "WeaponL" and (v5.Name ~= "WeaponR" and v5.Name ~= "CharmBase")) then
				v5:Destroy()
			end
		end
		v_u_clone:ScaleTo(1)
		v_u_clone:PivotTo(v_u3.Parent:GetPivot())
		v_u4.PrimaryPart.Anchored = true
		local v_getboundingbox = v_u_clone:GetBoundingBox()
		if v_u_clone.PrimaryPart then
			v_u_clone.PrimaryPart.PivotOffset = v_u_clone.PrimaryPart.CFrame:ToObjectSpace(v_getboundingbox)
		else
			v_u_clone.WorldPivot = v_getboundingbox
		end
		v_u_clone.PrimaryPart = v_u4.PrimaryPart
		for _, v6 in ipairs(v_u_clone:GetDescendants()) do
			if v6:IsA("BasePart") then
				v6.Transparency = 1
				v6.CanCollide = true
			elseif v6:IsA("Decal") or (v6:IsA("Texture") or v6:IsA("Beam")) then
				v6.Transparency = 1
			elseif v6:IsA("SurfaceGui") then
				v6.Enabled = false
			elseif v6:IsA("ParticleEmitter") then
				v6.Enabled = false
			end
		end
		local v_charmbase = v_u_clone:FindFirstChild("CharmBase", true)
		local v7
		if v_charmbase and v_charmbase:IsA("Model") then
			v7 = v_charmbase:FindFirstChildOfClass("Model")
			if v7 then
				for _, v8 in ipairs(v7:GetDescendants()) do
					if v8:IsA("BasePart") then
						v8.CanCollide = true
						v8.CollisionGroup = "Charm"
					end
				end
			end
		else
			v7 = nil
		end
		v_u1.LargeWeaponModel = v_u4.Parent
		v_u1.SmallWeaponModel = v_u3
		v_u1.LargeCharmModel = v7
		if v7 and v_u_charmmodel then
			v_u1.Janitor:Add(v_u_run.PostSimulation:Connect(function()
				-- upvalues: (copy) v_u1, (copy) v_u_charmmodel, (copy) v_u4, (copy) v_u3
				local v_largecharmmodel = v_u1.LargeCharmModel
				local v1 = v_u_charmmodel
				if v_largecharmmodel and v1 then
					if v_largecharmmodel.PrimaryPart and v1.PrimaryPart then
						local v_toobjectspace = v_u4:GetPivot():ToObjectSpace((v_largecharmmodel:GetPivot()))
						v1:PivotTo(v_u3:GetPivot() * (CFrame.new(v_toobjectspace.Position / 10) * CFrame.fromOrientation(v_toobjectspace:ToOrientation())))
					end
				else
					return
				end
			end))
		end
		v_u1.CharmModel.PrimaryPart.Anchored = true
		v_u1.Janitor:Add(function()
			-- upvalues: (copy) v_u_clone, (copy) v_u1
			if v_u_clone then
				v_u_clone:Destroy()
			end
			v_u1.LargeWeaponModel = nil
			v_u1.SmallWeaponModel = nil
			v_u1.LargeCharmModel = nil
		end)
		debug.profileend()
	end
	debug.profilebegin("Viewmodel.new.construct.Sound")
	v_u1.Sound = v_u4.new(arg2)
	v_u1.Animation = v_u7.new(v_u1, v_u1.Player, v_u1.Model, v_u1.Sound)
	v_u1.Bobble = v_u8.new(arg1, v_u1.Model)
	v_u1.Hidden = false
	v_u1.Janitor:Add(v_u1.Model)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.Animation then
			v_u1.Animation:destroy()
			v_u1.Animation = nil
		end
	end)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.Bobble then
			v_u1.Bobble:destroy()
			v_u1.Bobble = nil
		end
	end)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.Sound then
			v_u1.Sound:destroy()
			v_u1.Sound = nil
		end
	end)
	v_u1.Model.Parent = nil
	debug.profileend()
	return v_u1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.Animation then
			arg1.Animation:stopAnimations()
		end
		if arg1.Animation then
			arg1.Animation:destroy()
			arg1.Animation = nil
		end
		if arg1.Bobble then
			arg1.Bobble:destroy()
			arg1.Bobble = nil
		end
		if arg1.Sound then
			arg1.Sound:destroy()
			arg1.Sound = nil
		end
		if arg1.Model then
			arg1.Model.Parent = nil
			arg1.Model:Destroy()
			arg1.Model = nil
		end
		if arg1.Janitor then
			arg1.Janitor:Destroy()
			arg1.Janitor = nil
		end
		arg1.StatTrack = nil
		arg1.Stickers = nil
		arg1.NameTag = nil
		arg1.Player = nil
		arg1.Weapon = nil
		arg1.Float = nil
		arg1.Charm = nil
		arg1.Skin = nil
		arg1.Team = nil
		arg1.MuzzlePartWeld = nil
		arg1.MuzzlePartL = nil
		arg1.MuzzlePartR = nil
		arg1.MuzzlePart = nil
		arg1.OriginalC0 = nil
		arg1.CharmModel = nil
		arg1.ScaledCollisionModel = nil
		arg1.LargeCharmModel = nil
		arg1.LargeWeaponModel = nil
	end
end
return v_u1