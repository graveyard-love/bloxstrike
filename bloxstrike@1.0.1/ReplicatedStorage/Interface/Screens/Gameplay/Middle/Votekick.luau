local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Players")
local v_u_6 = v_u_5.LocalPlayer
local v_u_7 = require(v2.Database.Security.Remotes)
local v_u_8 = require(v2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_9 = require(v2.Components.Common.GetUserPlatform)
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = false
function v_u_1.UpdateAmount(p13, p14, p15)
    v_u_10.Option[p13].Amount.Text = ("%*"):format(p14)
    if v_u_6.UserId == tonumber(p15) then
        local v16 = p13 == "Yes" and "rgb(90, 186, 55)" or "rgb(255,49,49)"
        v_u_10.Result.TextLabel.Text = ("You voted: <font color=\"%*\">%*</font>"):format(v16, (string.upper(p13)))
        v_u_10.Result.Visible = true
    end
end
function v_u_1.UpdateFrame(p17, p18)
    local v19 = v_u_5:GetPlayerByUserId(p17)
    local v20 = v_u_5:GetPlayerByUserId(p18)
    if v19 then
        v_u_10.Player.Text = ("Kick player: %*? "):format(v19.Name)
        v_u_10.Frame.Title.Text = ("Vote By: %*"):format(v20 and v20.Name or "Unknown")
        v_u_10.Option.Yes.Amount.Text = "0"
        v_u_10.Option.No.Amount.Text = "0"
    end
end
function v_u_1.OpenFrame(p21)
    v_u_10.Position = UDim2.fromScale(-0.08, 0.525)
    v_u_10:SetAttribute("IsVoteKickActive", true)
    v_u_10.Result.Visible = false
    v_u_11 = p21
    v_u_10.Visible = true
    v_u_12 = false
    if v_u_6.UserId == p21 then
        v_u_10.Result.TextLabel.Text = "You are being vote kicked."
        v_u_10.Result.Visible = true
    end
    v_u_4:Create(v_u_10, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.08, 0.525)
    }):Play()
end
function v_u_1.CloseFrame()
    v_u_10:SetAttribute("IsVoteKickActive", false)
    v_u_10.Result.Visible = false
    v_u_11 = nil
    v_u_12 = false
    local v22 = v_u_4:Create(v_u_10, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(-0.08, 0.525)
    })
    v22.Completed:Once(function()
        v_u_10.Visible = false
    end)
    v22:Play()
end
function v_u_1.CastVote(p23)
    if not v_u_11 or v_u_6.UserId ~= v_u_11 then
        if not v_u_12 then
            local v24 = p23 == "Yes" and v_u_7.VoteKick.VoteYes or v_u_7.VoteKick.VoteNo
            v_u_12 = true
            local v25 = v24.Send
            local v26 = {}
            local v27 = v_u_6.UserId
            v26.Voter = tostring(v27)
            v26.Amount = 0
            return v25(v26)
        end
    end
end
function v_u_1.Initialize(_, p28)
    v_u_10 = p28
    v_u_10:SetAttribute("IsVoteKickActive", false)
    local v29 = table.find(v_u_9(), "Mobile") ~= nil
    local v30 = v_u_10:FindFirstChild("Keybinds")
    local v31 = v_u_10:FindFirstChild("MobileNoButton")
    local v32 = v_u_10:FindFirstChild("MobileYesButton")
    if v30 then
        v30.Visible = not v29
    end
    if v31 then
        v31.Visible = v29
    end
    if v32 then
        v32.Visible = v29
    end
    v_u_7.VoteKick.VoteNoUpdate.Listen(function(p33)
        v_u_1.UpdateAmount("No", p33.Amount, p33.Voter)
    end)
    v_u_7.VoteKick.VoteYesUpdate.Listen(function(p34)
        v_u_1.UpdateAmount("Yes", p34.Amount, p34.Voter)
    end)
    v_u_7.VoteKick.StartVote.Listen(function(p35)
        local v36 = p35.TargetUserId
        local v37 = tonumber(v36)
        local v38 = p35.VoterUserId
        local v39 = tonumber(v38)
        v_u_1.UpdateFrame(v37, v39)
        v_u_1.OpenFrame(v37)
    end)
    v_u_7.VoteKick.EndVote.Listen(function()
        if v_u_10.Visible then
            v_u_1.CloseFrame()
        end
    end)
    if v29 and (v31 and v32) then
        v_u_8(v31)
        v_u_8(v32)
        v31.Activated:Connect(function()
            v_u_1.CastVote("No")
        end)
        v32.Activated:Connect(function()
            v_u_1.CastVote("Yes")
        end)
    end
    if not (v29 and (v31 and v32)) then
        v_u_3.InputBegan:Connect(function(p40, p41)
            if p41 then
                return
            elseif v_u_10.Visible then
                if v_u_3:GetFocusedTextBox() then
                    return
                elseif p40.UserInputType == Enum.UserInputType.Keyboard then
                    if p40.KeyCode == Enum.KeyCode.K then
                        v_u_1.CastVote("Yes")
                        return
                    elseif p40.KeyCode == Enum.KeyCode.L then
                        v_u_1.CastVote("No")
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
return v_u_1