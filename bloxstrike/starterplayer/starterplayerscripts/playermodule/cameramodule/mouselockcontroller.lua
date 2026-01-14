-- Decompiled with Bunni.lol Decompiler

local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
require(v_commonutils:WaitForChild("FlagUtil"))
local v_u_value = Enum.ContextActionPriority.Medium.Value
local v_u_players = game:GetService("Players")
local v_u_contextaction = game:GetService("ContextActionService")
local v_u_gamesettings = UserSettings().GameSettings
local v_u1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u2 = {}
v_u2.__index = v_u2
function v_u2.new()
	-- upvalues: (copy) v_u2, (copy) v_u_gamesettings, (copy) v_u_players
	local v_u1 = setmetatable({}, v_u2)
	v_u1.isMouseLocked = false
	v_u1.savedMouseCursor = nil
	v_u1.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
	v_u1.mouseLockToggledEvent = Instance.new("BindableEvent")
	local v_boundkeys = script:FindFirstChild("BoundKeys")
	if not (v_boundkeys and v_boundkeys:IsA("StringValue")) then
		if v_boundkeys then
			v_boundkeys:Destroy()
		end
		v_boundkeys = Instance.new("StringValue")
		assert(v_boundkeys, "")
		v_boundkeys.Name = "BoundKeys"
		v_boundkeys.Value = "LeftShift,RightShift"
		v_boundkeys.Parent = script
	end
	if v_boundkeys then
		v_boundkeys.Changed:Connect(function(arg1)
			-- upvalues: (copy) v_u1
			v_u1:OnBoundKeysObjectChanged(arg1)
		end)
		v_u1:OnBoundKeysObjectChanged(v_boundkeys.Value)
	end
	v_u_gamesettings.Changed:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		if arg1 == "ControlMode" or arg1 == "ComputerMovementMode" then
			v_u1:UpdateMouseLockAvailability()
		end
	end)
	v_u_players.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:UpdateMouseLockAvailability()
	end)
	v_u_players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:UpdateMouseLockAvailability()
	end)
	v_u1:UpdateMouseLockAvailability()
	return v_u1
end
function v_u2.GetIsMouseLocked(arg1)
	return arg1.isMouseLocked
end
function v_u2.GetBindableToggleEvent(arg1)
	return arg1.mouseLockToggledEvent.Event
end
function v_u2.GetMouseLockOffset(_)
	return Vector3.new(1.75, 0, 0)
end
function v_u2.UpdateMouseLockAvailability(arg1)
	-- upvalues: (copy) v_u_players, (copy) v_u_gamesettings
	local v1 = v_u_players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
	local v2 = v_u_players.LocalPlayer.DevEnableMouseLock and (v_u_gamesettings.ControlMode == Enum.ControlMode.MouseLockSwitch and v_u_gamesettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove)
	if v2 then
		v2 = not v1
	end
	if v2 ~= arg1.enabled then
		arg1:EnableMouseLock(v2)
	end
end
function v_u2.OnBoundKeysObjectChanged(arg1, arg2)
	arg1.boundKeys = {}
	for v1 in string.gmatch(arg2, "[^%s,]+") do
		for _, v2 in pairs(Enum.KeyCode:GetEnumItems()) do
			if v1 == v2.Name then
				arg1.boundKeys[#arg1.boundKeys + 1] = v2
				break
			end
		end
	end
	arg1:UnbindContextActions()
	arg1:BindContextActions()
end
function v_u2.OnMouseLockToggled(arg1)
	-- upvalues: (copy) v_u1
	arg1.isMouseLocked = not arg1.isMouseLocked
	if arg1.isMouseLocked then
		local v_cursorimage = script:FindFirstChild("CursorImage")
		if v_cursorimage and (v_cursorimage:IsA("StringValue") and v_cursorimage.Value) then
			v_u1.setMouseIconOverride(v_cursorimage.Value)
		else
			if v_cursorimage then
				v_cursorimage:Destroy()
			end
			local v_stringvalue = Instance.new("StringValue")
			assert(v_stringvalue, "")
			v_stringvalue.Name = "CursorImage"
			v_stringvalue.Value = "rbxasset://textures/MouseLockedCursor.png"
			v_stringvalue.Parent = script
			v_u1.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
		end
	else
		v_u1.restoreMouseIcon()
	end
	arg1.mouseLockToggledEvent:Fire()
end
function v_u2.DoMouseLockSwitch(arg1, _, arg3, _)
	if arg3 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	arg1:OnMouseLockToggled()
	return Enum.ContextActionResult.Sink
end
function v_u2.BindContextActions(self)
	-- upvalues: (copy) v_u_contextaction, (copy) v_u_value
	v_u_contextaction:BindActionAtPriority("MouseLockSwitchAction", function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		return self:DoMouseLockSwitch(arg1, arg2, arg3)
	end, false, v_u_value, unpack(self.boundKeys))
end
function v_u2.UnbindContextActions(_)
	-- upvalues: (copy) v_u_contextaction
	v_u_contextaction:UnbindAction("MouseLockSwitchAction")
end
function v_u2.IsMouseLocked(arg1)
	local v_enabled = arg1.enabled
	if v_enabled then
		v_enabled = arg1.isMouseLocked
	end
	return v_enabled
end
function v_u2.EnableMouseLock(arg1, arg2)
	-- upvalues: (copy) v_u1
	if arg2 ~= arg1.enabled then
		arg1.enabled = arg2
		if arg1.enabled then
			arg1:BindContextActions()
			return
		end
		v_u1.restoreMouseIcon()
		arg1:UnbindContextActions()
		if arg1.isMouseLocked then
			arg1.mouseLockToggledEvent:Fire()
		end
		arg1.isMouseLocked = false
	end
end
return v_u2