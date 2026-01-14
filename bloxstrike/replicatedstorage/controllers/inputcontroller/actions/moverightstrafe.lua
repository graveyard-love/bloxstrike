-- Decompiled with Bunni.lol Decompiler

local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u_getcontrols = require(v_u_localplayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
return table.freeze({
	["Name"] = "Move Right (Strafe)",
	["Group"] = "Default",
	["Category"] = "Movement Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u_getcontrols
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		else
			local v_character = v_u_localplayer.Character
			local v1
			if v_character and v_character:IsDescendantOf(workspace) then
				local v_humanoid = v_character:WaitForChild("Humanoid")
				v1 = v_humanoid and v_humanoid.Health > 0 and true or false
			else
				v1 = false
			end
			if v1 then
				local v_activecontroller = v_u_getcontrols.activeController
				if v_activecontroller then
					if v_activecontroller.UpdateMovement then
						v_activecontroller.rightValue = arg1 == Enum.UserInputState.Begin and 1 or 0
						v_activecontroller:UpdateMovement(arg1)
					end
				else
					return
				end
			else
				return
			end
		end
	end
})