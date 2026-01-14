-- Decompiled with Bunni.lol Decompiler

game:GetService("Players")
game:GetService("UserInputService")
UserSettings():GetService("UserGameSettings")
local v_u1 = require(script.Parent:WaitForChild("CameraInput"))
local v_u2 = require(script.Parent:WaitForChild("CameraUI"))
local v_u3 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u4 = false
local v_u5 = tick()
local v_u6 = false
local v_u7 = false
local v_u8 = false
v_u2.setCameraModeToastEnabled(false)
return function(arg1)
	-- upvalues: (copy) v_u1, (ref) v_u4, (ref) v_u6, (ref) v_u5, (copy) v_u2, (ref) v_u8, (ref) v_u7, (copy) v_u3
	local v_gettogglepan = v_u1.getTogglePan()
	if arg1 and v_gettogglepan ~= v_u4 then
		v_u6 = true
	end
	if v_u4 ~= v_gettogglepan or tick() - v_u5 > 3 then
		local v1
		if v_gettogglepan then
			v1 = tick() - v_u5 < 3
		else
			v1 = v_gettogglepan
		end
		v_u2.setCameraModeToastOpen(v1)
		if v_gettogglepan then
			v_u6 = false
		end
		v_u5 = tick()
		v_u4 = v_gettogglepan
	end
	if arg1 ~= v_u8 then
		if arg1 then
			v_u7 = v_u1.getTogglePan()
			v_u1.setTogglePan(true)
		elseif not v_u6 then
			v_u1.setTogglePan(v_u7)
		end
	end
	if arg1 then
		if v_u1.getTogglePan() then
			v_u3.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
			v_u3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			v_u3.setRotationTypeOverride(Enum.RotationType.CameraRelative)
		else
			v_u3.restoreMouseIcon()
			v_u3.restoreMouseBehavior()
			v_u3.setRotationTypeOverride(Enum.RotationType.CameraRelative)
		end
	elseif v_u1.getTogglePan() then
		v_u3.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
		v_u3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
		v_u3.setRotationTypeOverride(Enum.RotationType.MovementRelative)
	elseif v_u1.getHoldPan() then
		v_u3.restoreMouseIcon()
		v_u3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
		v_u3.setRotationTypeOverride(Enum.RotationType.MovementRelative)
	else
		v_u3.restoreMouseIcon()
		v_u3.restoreMouseBehavior()
		v_u3.restoreRotationType()
	end
	v_u8 = arg1
end