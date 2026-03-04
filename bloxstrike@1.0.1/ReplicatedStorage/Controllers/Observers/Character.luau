local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
require(v_u_1.Database.Custom.Types)
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v_u_1.Controllers.SpectateController)
local v_u_8 = require(v_u_1.Controllers.CameraController)
local v_u_9 = require(v_u_1.Controllers.InputController)
local v_u_10 = require(v_u_1.Packages.Observers)
local v_u_11 = require(v_u_1.Shared.Janitor)
local v_u_12 = require(v_u_1.Classes.CharacterHighlight)
local v_u_13 = require(v_u_1.Components.Common.GetWeaponProperties)
local v_u_14 = require(script.Components.CharacterKinematics)
local v_u_15 = require(script.Components.Defuser)
local v_u_16 = {
    ["Counter-Terrorists"] = Color3.fromRGB(25, 80, 170),
    ["Terrorists"] = Color3.fromRGB(255, 215, 70)
}
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = nil
local function v_u_26(p21, p22)
    local v23 = p21:FindFirstChildOfClass("Humanoid")
    if v23 then
        return v23
    end
    local v24 = tick()
    while p21.Parent do
        task.wait(0.1)
        local v25 = p21:FindFirstChildOfClass("Humanoid")
        if v25 then
            return v25
        end
        if p22 and p22 <= tick() - v24 then
            return nil
        end
    end
    return nil
end
local function v_u_30(p27, p28)
    for _, v29 in ipairs(p27:GetDescendants()) do
        if v29:IsA("TextLabel") then
            v29.TextColor3 = p28
        elseif v29:IsA("TextButton") then
            v29.TextColor3 = p28
        elseif v29:IsA("TextBox") then
            v29.TextColor3 = p28
        end
    end
end
local function v_u_58(p_u_31, p_u_32, p_u_33)
    local v_u_34 = v_u_16[p_u_33]
    if not v_u_34 then
        return nil
    end
    local v_u_35 = v_u_26(p_u_32)
    if not v_u_35 then
        return nil
    end
    local v36 = p_u_32:WaitForChild("Head")
    if not (v36 and (v_u_35 and p_u_32:IsDescendantOf(workspace))) then
        return nil
    end
    if v_u_18[p_u_31] then
        v_u_18[p_u_31]:Destroy()
        v_u_18[p_u_31] = nil
        if v_u_20 then
            v_u_20()
        end
    end
    local v37 = v_u_11.new()
    local v_u_38 = v37:Add(v_u_1.Assets.Other.Character.Arrow:Clone())
    local v39
    if p_u_32 then
        v39 = p_u_32:GetAttribute("CompetitivePlayerColor") or v_u_34
    else
        v39 = v_u_34
    end
    v_u_38.Arrow.ImageColor3 = v39
    v_u_38.Adornee = v36
    v_u_38.Parent = v_u_6
    local v_u_40 = v37:Add(v_u_1.Assets.Other.Character.NameTag:Clone())
    v_u_40.Info.PlayerName.Text = ("%*"):format(p_u_31.DisplayName)
    v_u_40.Info.Weapons.Bomb.Visible = false
    v_u_40.Adornee = v36
    v_u_40.Parent = v_u_6
    local v41 = v_u_40.Info.Health
    local v42 = v_u_35.Health / v_u_35.MaxHealth * 100
    v41.Text = ("%*%%"):format((math.ceil(v42)))
    v_u_30(v_u_40, v39)
    v37:Add(p_u_32:GetAttributeChangedSignal("CompetitivePlayerColor"):Connect(function()
        local v43 = p_u_32
        local v44 = v_u_34
        if v43 then
            v44 = v43:GetAttribute("CompetitivePlayerColor") or v44
        end
        if v_u_38.Parent and v_u_38:FindFirstChild("Arrow") then
            v_u_38.Arrow.ImageColor3 = v44
        end
        if v_u_40.Parent then
            v_u_30(v_u_40, v44)
        end
    end))
    v37:Add(v_u_35:GetPropertyChangedSignal("Health"):Connect(function()
        if v_u_40 and (v_u_40.Parent and v_u_40:FindFirstChild("Info")) then
            local v45 = v_u_40.Info.Health
            local v46 = v_u_35.Health / v_u_35.MaxHealth * 100
            v45.Text = ("%*%%"):format((math.ceil(v46)))
        end
    end))
    v37:Add(v_u_10.observeAttribute(p_u_31, "CurrentEquipped", function(p47)
        if not (v_u_40 and (v_u_40.Parent and v_u_40:FindFirstChild("Info"))) then
            return function() end
        end
        local v48 = v_u_2:JSONDecode(p47 or "[]")
        if v48 and v48.Name then
            local v49 = v_u_13(v48.Name)
            if v_u_40.Info and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Gun) then
                v_u_40.Info.Weapons.Gun.Image = v49 and (v49.Icon or "") or ""
                v_u_40.Info.Weapons.Gun.Visible = v49 or false
            end
        elseif v_u_40.Info and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Gun) then
            v_u_40.Info.Weapons.Gun.Visible = false
        end
        if v48 then
            v48 = v48.Name == "C4"
        end
        if v_u_40.Info and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Bomb) then
            local v50 = p_u_31:GetAttribute("Slot5")
            local v51
            if v50 then
                v51 = v_u_2:JSONDecode(v50)
                if v51 then
                    v51 = v51.Weapon == "C4"
                end
            else
                v51 = false
            end
            local v52 = v_u_40.Info.Weapons.Bomb
            if v51 then
                v51 = not v48
            end
            v52.Visible = v51
        end
        return function()
            if v_u_40 and (v_u_40:FindFirstChild("Info") and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Gun)) then
                v_u_40.Info.Weapons.Gun.Visible = false
            end
        end
    end))
    v37:Add(v_u_10.observeAttribute(p_u_31, "Slot5", function(p53)
        if not (v_u_40 and (v_u_40.Parent and v_u_40:FindFirstChild("Info"))) then
            return function() end
        end
        local v54 = v_u_2:JSONDecode(p53 or "[]")
        if v54 then
            v54 = v54.Weapon == "C4"
        end
        local v55 = p_u_31:GetAttribute("CurrentEquipped")
        local v56
        if v55 then
            v56 = v_u_2:JSONDecode(v55)
            if v56 then
                v56 = v56.Name == "C4"
            end
        else
            v56 = false
        end
        if v_u_40.Info and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Bomb) then
            local v57 = v_u_40.Info.Weapons.Bomb
            if v54 then
                v54 = not v56
            end
            v57.Visible = v54
        end
        return function()
            if v_u_40 and (v_u_40:FindFirstChild("Info") and (v_u_40.Info.Weapons and v_u_40.Info.Weapons.Bomb)) then
                v_u_40.Info.Weapons.Bomb.Visible = false
            end
        end
    end))
    v_u_18[p_u_31] = v37
    v_u_19[p_u_31] = {
        ["Arrow"] = v_u_38,
        ["NameTag"] = v_u_40
    }
    v37:Add(function()
        v_u_19[p_u_31] = nil
    end)
    if v_u_20 then
        v_u_20()
    end
    return v37
end
v_u_20 = function()
    for v59, v60 in pairs(v_u_19) do
        local v61 = v59:GetAttribute("Team")
        local v62
        if v61 then
            v62 = v_u_16[v61] or nil
        else
            v62 = nil
        end
        if v61 and v62 then
            local v63 = v59.Character
            if v63 then
                v62 = v63:GetAttribute("CompetitivePlayerColor") or v62
            end
            if v60.Arrow and v60.Arrow.Parent then
                v60.Arrow.Arrow.ImageColor3 = v62
            end
            if v60.NameTag and v60.NameTag.Parent then
                v_u_30(v60.NameTag, v62)
            end
        end
    end
end
workspace:GetAttributeChangedSignal("ServerGamemode"):Connect(function()
    if v_u_20 then
        v_u_20()
    end
end)
local function v_u_70(_, p64, p65)
    local v66 = p64:FindFirstChildOfClass("Humanoid")
    if not v66 then
        local v67 = tick()
        repeat
            task.wait(0.1)
            v66 = p64:FindFirstChildOfClass("Humanoid")
        until v66 or tick() - v67 > 5
    end
    if v66 then
        v_u_8.setPerspective(true, false)
        p65:Add(function()
            v_u_8.setPerspective(false, true)
        end)
        v_u_9.enableGroup("Gameplay")
        p65:Add(function()
            v_u_9.disableGroup("Gameplay")
        end)
        p65:Add(v66.StateChanged:Connect(function(p68, p69)
            v_u_8.StateChanged(p68, p69)
        end))
    end
end
local function v_u_73(p71)
    for _, v72 in pairs(v_u_19) do
        if v72.Arrow then
            v72.Arrow.Enabled = p71
        end
        if v72.NameTag then
            v72.NameTag.Enabled = p71
        end
    end
end
v_u_7.ListenToSpectate:Connect(function(p74)
    v_u_73(p74 == nil)
end)
return v_u_10.observeCharacter(function(p_u_75, p_u_76)
    if v_u_17[p_u_75] then
        v_u_17[p_u_75]:Destroy()
        v_u_17[p_u_75] = nil
    end
    local v_u_77 = v_u_11.new()
    v_u_17[p_u_75] = v_u_77
    if v_u_18[p_u_75] then
        v_u_18[p_u_75]:Destroy()
        v_u_18[p_u_75] = nil
        if v_u_20 then
            v_u_20()
        end
    end
    if v_u_5 == p_u_75 then
        v_u_70(p_u_75, p_u_76, v_u_77)
        for v78, _ in pairs(v_u_18) do
            if v_u_18[v78] then
                v_u_18[v78]:Destroy()
                v_u_18[v78] = nil
                if v_u_20 then
                    v_u_20()
                end
            end
        end
        for _, v_u_79 in ipairs(v_u_4:GetPlayers()) do
            if v_u_79 ~= v_u_5 then
                local v80 = v_u_79.Character
                if v80 and v80:IsDescendantOf(workspace) then
                    local v81 = v_u_5:GetAttribute("Team")
                    local v82 = v_u_79:GetAttribute("Team")
                    if v81 == v82 and (v82 == "Terrorists" or v82 == "Counter-Terrorists") and workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                        v_u_58(v_u_79, v80, v82)
                        if v_u_17[v_u_79] then
                            v_u_17[v_u_79]:Add(function()
                                local v83 = v_u_79
                                if v_u_18[v83] then
                                    v_u_18[v83]:Destroy()
                                    v_u_18[v83] = nil
                                    if v_u_20 then
                                        v_u_20()
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    else
        local v84 = p_u_75:GetAttribute("Team")
        local v85 = v84 == "Counter-Terrorists" and Color3.fromRGB(0, 75, 200) or (v84 == "Terrorists" and Color3.fromRGB(255, 220, 50) or Color3.fromRGB(255, 255, 255))
        v_u_77:Add(function()
            v_u_14.cleanup(p_u_75)
        end)
        local v_u_86 = v_u_15.new(p_u_75, p_u_76)
        v_u_77:Add(function()
            v_u_86:Destroy()
        end)
        local v87 = workspace:GetAttribute("Gamemode")
        local v88 = v84 == "Terrorists" and true or v84 == "Counter-Terrorists"
        local v89
        if v88 then
            v89 = v87 ~= "Deathmatch"
        else
            v89 = v88
        end
        local v90 = v_u_5:GetAttribute("Team") == v84
        if v88 then
            local v91
            if v87 == "Deathmatch" then
                v91 = Enum.HighlightDepthMode.Occluded
            else
                v91 = Enum.HighlightDepthMode.AlwaysOnTop
            end
            local v_u_92 = v_u_77:Add(v_u_12.new(p_u_76, {
                ["DepthMode"] = v91,
                ["FillColor"] = Color3.fromRGB(255, 255, 255),
                ["OutlineColor"] = v85,
                ["OutlineTransparency"] = 0.4,
                ["FillTransparency"] = 0.7
            }))
            local function v_u_107()
                if p_u_76 and p_u_76.Parent then
                    local v93 = workspace:GetAttribute("Gamemode")
                    local v94 = p_u_75:GetAttribute("Team")
                    local v95 = p_u_76:GetAttribute("Invincible") == true
                    local v96 = v_u_5:GetAttribute("IsSpectating") == true
                    local v97 = v_u_7.GetPlayer()
                    local v98
                    if v97 then
                        v98 = v97:GetAttribute("Team")
                    else
                        v98 = v97
                    end
                    local v99 = v_u_7.GetCurrentSpectateInstance()
                    local v100
                    if v99 == nil then
                        v100 = false
                    else
                        v100 = v99.PerspectiveState == "First-Person"
                    end
                    local v101 = v97 == p_u_75
                    local v102 = v_u_5:GetAttribute("Team") == v94
                    if v96 then
                        if not v100 then
                            v101 = v100
                        end
                    else
                        v101 = v96
                    end
                    local v103
                    if v93 == "Deathmatch" then
                        v103 = false
                    elseif v96 then
                        if v98 == v94 then
                            v103 = not v101
                        else
                            v103 = false
                        end
                    else
                        v103 = v96
                    end
                    if v102 then
                        v96 = v102
                    elseif v96 then
                        v96 = v98 == v94
                    end
                    local v104 = v95 and not v101
                    if v104 then
                        v104 = v93 == "Deathmatch" and true or v96
                    end
                    local v105 = v_u_92
                    local v106
                    if v103 then
                        v106 = not v104
                    else
                        v106 = v103
                    end
                    v105.OutlineOnly = v106
                    v_u_92:UpdateState(v104 or v103)
                end
            end
            v_u_77:Add(v_u_10.observeAttribute(p_u_76, "Invincible", function(_)
                v_u_107()
                return function()
                    v_u_92:UpdateState(false)
                end
            end))
            v_u_77:Add(v_u_10.observeAttribute(v_u_5, "IsSpectating", function()
                v_u_107()
                return function() end
            end))
            v_u_77:Add(v_u_7.ListenToSpectate:Connect(function()
                v_u_107()
            end))
            local v_u_108 = 0
            v_u_92.Janitor:Add(v_u_3.Heartbeat:Connect(function(p109)
                v_u_108 = v_u_108 + p109
                if v_u_108 >= 0.2 then
                    v_u_108 = 0
                    if v_u_5:GetAttribute("IsSpectating") == true or p_u_76:GetAttribute("Invincible") == true then
                        v_u_107()
                    end
                end
            end))
            v_u_107()
        end
        if v90 and v89 then
            v_u_58(p_u_75, p_u_76, v84)
            v_u_77:Add(function()
                local v110 = p_u_75
                if v_u_18[v110] then
                    v_u_18[v110]:Destroy()
                    v_u_18[v110] = nil
                    if v_u_20 then
                        v_u_20()
                    end
                end
            end)
        end
        if v_u_5:GetAttribute("IsSpectating") and not v_u_7.GetCurrentSpectateInstance() then
            v_u_7.Next()
        end
    end
    return function()
        v_u_77:Destroy()
    end
end)