-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u3 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u4 = nil
local v_u5 = nil
local v_u6 = false
function v_u1.UpdateAmount(arg1, arg2, arg3)
	-- upvalues: (ref) v_u4, (copy) v_u_localplayer
	v_u4.Option[arg1].Amount.Text = ("%*"):format(arg2)
	if v_u_localplayer.UserId == tonumber(arg3) then
		v_u4.Result.TextLabel.Text = ("You voted: <font color=\"%*\">%*</font>"):format(arg1 == "Yes" and "rgb(90, 186, 55)" or "rgb(255,49,49)", (string.upper(arg1)))
		v_u4.Result.Visible = true
	end
end
function v_u1.UpdateFrame(arg1, arg2)
	-- upvalues: (copy) v_u_players, (ref) v_u4
	local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(arg1)
	local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(arg2)
	if v_getplayerbyuserid then
		v_u4.Player.Text = ("Kick player: %*? "):format(v_getplayerbyuserid.Name)
		v_u4.Frame.Title.Text = ("Vote By: %*"):format(v_getplayerbyuserid and v_getplayerbyuserid.Name or "Unknown")
		v_u4.Option.Yes.Amount.Text = "0"
		v_u4.Option.No.Amount.Text = "0"
	end
end
function v_u1.OpenFrame(arg1)
	-- upvalues: (ref) v_u4, (ref) v_u5, (ref) v_u6, (copy) v_u_localplayer, (copy) v_u_tween
	v_u4.Position = UDim2.fromScale(-0.08, 0.525)
	v_u4:SetAttribute("IsVoteKickActive", true)
	v_u4.Result.Visible = false
	v_u5 = arg1
	v_u4.Visible = true
	v_u6 = false
	if v_u_localplayer.UserId == arg1 then
		v_u4.Result.TextLabel.Text = "You are being vote kicked."
		v_u4.Result.Visible = true
	end
	v_u_tween:Create(v_u4, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Position"] = UDim2.fromScale(0.08, 0.525)
	}):Play()
end
function v_u1.CloseFrame()
	-- upvalues: (ref) v_u4, (ref) v_u5, (ref) v_u6, (copy) v_u_tween
	v_u4:SetAttribute("IsVoteKickActive", false)
	v_u4.Result.Visible = false
	v_u5 = nil
	v_u6 = false
	local v_create = v_u_tween:Create(v_u4, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Position"] = UDim2.fromScale(-0.08, 0.525)
	})
	v_create.Completed:Once(function()
		-- upvalues: (ref) v_u4
		v_u4.Visible = false
	end)
	v_create:Play()
end
function v_u1.CastVote(arg1)
	-- upvalues: (ref) v_u5, (copy) v_u_localplayer, (ref) v_u6, (copy) v_u2
	if not v_u5 or v_u_localplayer.UserId ~= v_u5 then
		if not v_u6 then
			v_u6 = true
			return (arg1 == "Yes" and v_u2.VoteKick.VoteYes or v_u2.VoteKick.VoteNo).Send({
				["Voter"] = tostring(v_u_localplayer.UserId),
				["Amount"] = 0
			})
		end
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u3, (copy) v_u2, (copy) v_u1, (copy) v_u_userinput
	arg2:SetAttribute("IsVoteKickActive", false)
	if not table.find(v_u3(), "Mobile") then
		v_u2.VoteKick.VoteNo.Listen(function(arg1)
			-- upvalues: (ref) v_u1
			v_u1.UpdateAmount("No", arg1.Amount, arg1.Voter)
		end)
		v_u2.VoteKick.VoteYes.Listen(function(arg1)
			-- upvalues: (ref) v_u1
			v_u1.UpdateAmount("Yes", arg1.Amount, arg1.Voter)
		end)
		v_u2.VoteKick.StartVote.Listen(function(arg1)
			-- upvalues: (ref) v_u1
			local v1 = tonumber(arg1.TargetUserId)
			local v2 = tonumber(arg1.VoterUserId)
			v_u1.UpdateFrame(v1, v2)
			v_u1.OpenFrame(v1)
		end)
		v_u2.VoteKick.EndVote.Listen(function()
			-- upvalues: (ref) v_u4, (ref) v_u1
			if v_u4.Visible then
				v_u1.CloseFrame()
			end
		end)
		v_u_userinput.InputBegan:Connect(function(arg1, arg2)
			-- upvalues: (ref) v_u4, (ref) v_u_userinput, (ref) v_u1
			if arg2 then
				return
			elseif v_u4.Visible then
				if v_u_userinput:GetFocusedTextBox() then
					return
				elseif arg1.UserInputType == Enum.UserInputType.Keyboard then
					if arg1.KeyCode == Enum.KeyCode.K then
						v_u1.CastVote("Yes")
						return
					elseif arg1.KeyCode == Enum.KeyCode.L then
						v_u1.CastVote("No")
					end
				else
					return
				end
			else
				return
			end
		end)
	end
end
return v_u1