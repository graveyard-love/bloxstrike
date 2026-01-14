-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u4 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u5 = require(v_u_replicatedstorage.Classes.Spectate)
local v_u6 = require(v_u_replicatedstorage.Classes.Freecam)
local v_u7 = require(v_u_replicatedstorage.Packages.Observers)
local v_u8 = require(v_u_replicatedstorage.Shared.Promise)
local v9 = require(v_u_replicatedstorage.Packages.Signal)
local v_u10 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u11 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = v9.new()
v_u1.ListenToSpectate = v_u_new
local v_u12 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u13 = "First-Person"
local v_u14 = {}
local v_u15 = false
local v_u16 = 0
local v_u17 = 1
local v_u18 = 1
local v_u19 = 0
local v_u20 = { "First-Person", "Third-Person", "Free-Cam" }
local v_u21 = nil
local v_u22 = nil
local function v_u23(arg1)
	-- upvalues: (copy) v_u_localplayer, (ref) v_u15
	if arg1 == v_u_localplayer then
		if v_u15 then
			return false
		end
		if v_u_localplayer:GetAttribute("IsSpectating") then
			return false
		end
	end
	local v_character = arg1.Character
	if v_character and v_character:IsDescendantOf(workspace) then
		if v_character:GetAttribute("Dead") then
			return false
		end
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		if v_humanoid and v_humanoid.Health > 0 then
			return true
		end
	end
	return false
end
local function v_u24()
	-- upvalues: (copy) v_u4, (copy) v_u23, (copy) v_u_localplayer, (copy) v_u_replicatedstorage
	if v_u4.IsCaseSceneActive() then
		return false
	end
	if v_u23(v_u_localplayer) then
		return false
	end
	local v_team = v_u_localplayer:GetAttribute("Team")
	if v_team ~= "Counter-Terrorists" and v_team ~= "Terrorists" then
		return false
	end
	local v_getstate = require(v_u_replicatedstorage.Database.Components.GameState).GetState()
	return v_getstate ~= "Game Ending" and v_getstate ~= "Map Voting"
end
local function v_u25()
	-- upvalues: (copy) v_u24, (ref) v_u21, (ref) v_u22, (copy) v_u3, (copy) v_u12, (copy) v_u_localplayer, (copy) v_u_players, (copy) v_u23, (copy) v_u1
	if v_u24() then
		if v_u21 or v_u22 then
			return
		else
			v_u3.updateCameraFOV(v_u12.DEFAULT_CAMERA_FOV)
			v_u3.setPerspective(true, false)
			local v_lastkiller = v_u_localplayer:GetAttribute("LastKiller")
			local v1
			if v_lastkiller then
				v_u_localplayer:SetAttribute("LastKiller", nil)
				v1 = v_u_players:FindFirstChild(v_lastkiller)
				if not (v1 and v_u23(v1)) then
					v1 = nil
				end
			else
				v1 = nil
			end
			if v1 then
				v_u1.SetNextPlayer(v1)
			else
				v_u1.Next()
			end
		end
	else
		return
	end
end
local function v_u26()
	-- upvalues: (copy) v_u14, (copy) v_u_players, (copy) v_u_localplayer, (copy) v_u23
	table.clear(v_u14)
	for _, v1 in ipairs(v_u_players:GetPlayers()) do
		if v1 ~= v_u_localplayer and v_u23(v1) then
			table.insert(v_u14, v1)
		end
	end
end
function v_u1.GetCurrentSpectateInstance()
	-- upvalues: (ref) v_u21
	return v_u21
end
function v_u1.IsLocalPlayerDead()
	-- upvalues: (ref) v_u15
	return v_u15
end
function v_u1.GetPlayer()
	-- upvalues: (copy) v_u23, (copy) v_u_localplayer, (copy) v_u1
	if v_u23(v_u_localplayer) then
		return v_u_localplayer
	else
		local v_getcurrentspectateinstance = v_u1.GetCurrentSpectateInstance()
		if v_getcurrentspectateinstance then
			return v_getcurrentspectateinstance.Player
		else
			return nil
		end
	end
end
function v_u1.SetNextPlayer(arg1)
	-- upvalues: (ref) v_u21, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u23, (copy) v_u5, (copy) v_u10
	local v1 = v_u21
	if v1 then
		v1 = v_u21.Player
	end
	if arg1 == v_u_localplayer then
		v_u1.Next()
	else
		local v_character = arg1.Character
		local v2 = v1 == arg1
		local v3 = v_u21
		if v3 then
			v3 = v_u21.Character == v_character
		end
		local v4 = v_u23(arg1)
		if not (v2 and (v3 and v4)) then
			v_u1.Stop(false, true)
			local v5 = v_character and (v4 and v_character:FindFirstChild("Humanoid"))
			if v5 then
				debug.profilebegin("SpectateController.SetNextPlayer")
				local v_new = v_u5.new(arg1, v_character, v5)
				v_u21 = v_new
				debug.profileend()
				v_u1.ListenToSpectate:Fire(arg1)
				v_new.StopSpectating:Once(function()
					-- upvalues: (ref) v_u1
					v_u1.Stop(false, true)
					v_u1.Next()
				end)
				v_u10.Spectate.SpectatePlayer.Send(arg1.Name)
				return
			end
			v_u1.Next()
		end
	end
end
function v_u1.Switch()
	-- upvalues: (ref) v_u17, (copy) v_u20, (ref) v_u13, (ref) v_u21
	local v1 = v_u17 + 1
	if #v_u20 < v1 then
		v_u13 = v_u20[1]
		v_u17 = 1
	elseif v1 <= #v_u20 then
		v_u13 = v_u20[v1]
		v_u17 = v1
	end
	if v_u21 then
		v_u21:Switch(v_u13)
	end
end
function v_u1.UpdateIndex(arg1)
	-- upvalues: (copy) v_u26, (copy) v_u14, (ref) v_u18, (copy) v_u8, (copy) v_u23, (copy) v_u1
	v_u26()
	if #v_u14 > 0 then
		if v_u18 + arg1 <= 0 then
			v_u18 = #v_u14
		elseif v_u18 > #v_u14 then
			v_u18 = 1
		end
	end
	return v_u8.new(function(arg1, arg2)
		-- upvalues: (ref) v_u14, (ref) v_u18, (ref) v_u23, (ref) v_u26, (ref) v_u1
		local v1 = v_u14[v_u18]
		if v1 and v_u23(v1) then
			arg1(v1)
			return
		else
			v_u26()
			if #v_u14 > 0 then
				v_u18 = 1
				arg1(v_u14[1])
			else
				v_u1.Stop(false, false)
				arg2("No players alive to spectate")
			end
		end
	end)
end
function v_u1.Next()
	-- upvalues: (copy) v_u1
	return v_u1.UpdateIndex(1):andThen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.SetNextPlayer(arg1)
	end)
end
function v_u1.Previous()
	-- upvalues: (copy) v_u1
	return v_u1.UpdateIndex(-1):andThen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.SetNextPlayer(arg1)
	end)
end
function v_u1.Stop(arg1, arg2)
	-- upvalues: (ref) v_u21, (copy) v_u10, (ref) v_u22, (copy) v_u_new
	if v_u21 then
		v_u21:Destroy()
		v_u21 = nil
		if arg1 then
			v_u10.Spectate.StopSpectating.Send()
		end
	end
	if arg2 and v_u22 then
		v_u22:Destroy()
		v_u22 = nil
	end
	v_u_new:Fire()
end
function v_u1.Broadcast()
	-- upvalues: (ref) v_u19, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u10, (copy) v_u_current_camera
	if v_u19 >= 0.016666666666666666 then
		local v_getcurrentequipped = v_u2.getCurrentEquipped()
		v_u19 = v_u19 - 0.016666666666666666
		if v_getcurrentequipped then
			local v_maingui = v_u_localplayer.PlayerGui:FindFirstChild("MainGui")
			if v_maingui then
				v_maingui = v_u_localplayer.PlayerGui.MainGui:FindFirstChild("Menu")
			end
			if v_maingui then
				v_maingui = v_maingui:FindFirstChild("Inspect")
			end
			if v_maingui and v_maingui.Visible then
				return
			elseif not v_u4.IsCaseSceneActive() then
				v_u10.Spectate.UpdateCameraCFrame.Send(v_u_current_camera.CFrame)
			end
		end
	end
end
function v_u1.Render(arg1)
	-- upvalues: (ref) v_u19, (ref) v_u16, (copy) v_u23, (copy) v_u_localplayer, (copy) v_u1, (ref) v_u21, (ref) v_u22, (copy) v_u_current_camera, (copy) v_u3, (copy) v_u24, (copy) v_u4, (copy) v_u11, (copy) v_u26, (copy) v_u14, (ref) v_u18, (copy) v_u6
	v_u19 = v_u19 + arg1
	v_u16 = v_u16 + arg1
	if v_u23(v_u_localplayer) then
		v_u1.Broadcast()
		if v_u21 then
			v_u1.Stop(true, true)
		end
		if v_u22 then
			v_u22:Destroy()
			v_u22 = nil
		end
		if v_u23(v_u_localplayer) then
			local v_humanoid = v_u_localplayer.Character:FindFirstChild("Humanoid")
			if v_humanoid then
				v_u_current_camera.CameraType = Enum.CameraType.Custom
				v_u_current_camera.CameraSubject = v_humanoid
			end
			v_u3.setPerspective(true, false)
			return
		end
	elseif v_u24() or v_u_localplayer:GetAttribute("IsSpectating") then
		if v_u4.IsCaseSceneActive() then
			return
		end
		if v_u21 then
			if v_u11.broadcastRouter("IsInspectActive") then
				return
			end
			v_u21:Render(arg1)
			if v_u22 then
				v_u22:Destroy()
				v_u22 = nil
				return
			end
		else
			v_u26()
			if #v_u14 > 0 then
				if v_u18 + 1 <= 0 then
					v_u18 = #v_u14
				elseif v_u18 > #v_u14 then
					v_u18 = 1
				end
			end
			if v_u14[v_u18] then
				v_u1.Next()
				return
			end
			if not v_u22 and v_u6.new() then
				v_u22:Start()
				return
			end
		end
	elseif v_u21 then
		v_u1.Stop(false, true)
		return
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u7, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u1, (copy) v_u3, (copy) v_u12, (ref) v_u21, (copy) v_u_players, (copy) v_u23, (copy) v_u10, (ref) v_u15, (copy) v_u25, (copy) v_u_replicatedstorage, (copy) v_u_run
	v_u7.observeAttribute(v_u_localplayer, "IsSpectating", function(arg1)
		-- upvalues: (ref) v_u4, (ref) v_u1, (ref) v_u3, (ref) v_u12, (ref) v_u21, (ref) v_u_localplayer, (ref) v_u_players, (ref) v_u23
		if arg1 then
			if v_u4.IsCaseSceneActive() then
				return function()
					-- upvalues: (ref) v_u1
					v_u1.Stop(false, true)
				end
			end
			v_u3.updateCameraFOV(v_u12.DEFAULT_CAMERA_FOV)
			v_u3.setPerspective(true, false)
			if not v_u21 then
				local v_lastkiller = v_u_localplayer:GetAttribute("LastKiller")
				local v1
				if v_lastkiller then
					v_u_localplayer:SetAttribute("LastKiller", nil)
					v1 = v_u_players:FindFirstChild(v_lastkiller)
					if not (v1 and v_u23(v1)) then
						v1 = nil
					end
				else
					v1 = nil
				end
				if v1 then
					v_u1.SetNextPlayer(v1)
				else
					v_u1.Next()
				end
			end
		end
		return function()
			-- upvalues: (ref) v_u1
			v_u1.Stop(false, true)
		end
	end)
	v_u10.Character.CharacterDied.Listen(function()
		-- upvalues: (ref) v_u15, (ref) v_u25
		v_u15 = true
		v_u25()
	end)
	v_u_localplayer.CharacterAdded:Connect(function(self)
		-- upvalues: (ref) v_u15, (ref) v_u25
		v_u15 = false
		local v_u_connection = self:GetAttributeChangedSignal("Dead"):Connect(function()
			-- upvalues: (copy) self, (ref) v_u25
			if self:GetAttribute("Dead") then
				v_u25()
			end
		end)
		local v_u1 = nil
		v_u1 = self.AncestryChanged:Connect(function(_, arg2)
			-- upvalues: (ref) v_u_connection, (ref) v_u1
			if not arg2 then
				if v_u_connection then
					v_u_connection:Disconnect()
					v_u_connection = nil
				end
				if v_u1 then
					v_u1:Disconnect()
					v_u1 = nil
				end
			end
		end)
	end)
	require(v_u_replicatedstorage.Database.Components.GameState).ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u1
		if arg2 == "Game Ending" or arg2 == "Map Voting" then
			v_u1.Stop(false, true)
		end
	end)
	v_u_run.RenderStepped:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.Render(arg1)
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u10, (ref) v_u21, (copy) v_u_userinput, (copy) v_u_localplayer, (copy) v_u1
	v_u10.Spectate.ReplicateSpectateEvent.Listen(function(...)
		-- upvalues: (ref) v_u21
		if v_u21 then
			v_u21:AddSpectateEvent(...)
		end
	end)
	v_u_userinput.InputBegan:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer:GetAttribute("IsSpectating") and (arg1.KeyCode == Enum.KeyCode.Space and not v_u_localplayer:GetAttribute("IsPlayerChatting")) then
			v_u1.Switch()
		end
	end)
end
return v_u1