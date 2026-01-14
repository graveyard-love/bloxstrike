-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Components.Common.InterfaceAnimations.ActivateButton)
local v_u3 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u5 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u6 = nil
local v_u7 = nil
local function v_u8(arg1)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1:IsA("Frame") then
			v1:Destroy()
		end
	end
end
function v_u1.PlayerAdded(self)
	-- upvalues: (ref) v_u7, (copy) v_u_replicatedstorage, (copy) v_u4, (copy) v_u3
	if not v_u7.Menu.VoteKick.Container:FindFirstChild((tostring(self.UserId))) then
		local v_clone = v_u_replicatedstorage.Assets.UI.VoteKick.PlayerTemplate:Clone()
		v_clone.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(self.UserId)
		v_clone.Player.Username.Text = "@" .. self.DisplayName
		v_clone.Parent = v_u7.Menu.VoteKick.Container
		v_clone.Name = tostring(self.UserId)
		v_clone.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u4, (ref) v_u3, (copy) self, (ref) v_u7
			v_u4.broadcastRouter("RunInterfaceSound", "UI Click")
			v_u3.VoteKick.CallVote.Send((tostring(self.UserId)))
			v_u7.Menu.VoteKick.Visible = false
		end)
	end
end
function v_u1.OpenChooseTeam()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u5
	local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
	local v_team = v_u_localplayer:GetAttribute("Team")
	if (v_team == "Counter-Terrorists" or v_team == "Terrorists") and true or v_isspectating == true then
		if v_isspectating then
			v_u5.openFrame()
			return
		elseif v_u_localplayer.Character then
			v_u5.ToggleTeamSelection()
		end
	else
		return
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u7, (ref) v_u6, (copy) v_u8, (copy) v_u_players, (copy) v_u_localplayer, (copy) v_u1
	v_u6 = arg2
	v_u8(arg1.Menu.VoteKick.Container)
	for _, v1 in ipairs(v_u_players:GetPlayers()) do
		if v_u_localplayer ~= v1 then
			v_u1.PlayerAdded(v1)
		end
	end
	v_u_players.PlayerAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer ~= arg1 then
			v_u1.PlayerAdded(arg1)
		end
	end)
	v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u7
		local v1 = v_u7.Menu.VoteKick.Container:FindFirstChild((tostring(arg1.UserId)))
		if v1 then
			v1:Destroy()
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u2, (ref) v_u7, (copy) v_u4, (ref) v_u6, (copy) v_u1
	v_u2(v_u7.Menu.VoteKick.Close)
	v_u7.Menu.VoteKick.Close.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u4, (ref) v_u7
		v_u4.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u7.Menu.VoteKick.Visible = false
	end)
	v_u6.Container.ChooseTeam.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.OpenChooseTeam()
	end)
	v_u6.Container.VoteKick.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u4, (ref) v_u7
		v_u4.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u7.Menu.VoteKick.Visible = true
	end)
end
return v_u1