local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Workspace")
local v4 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_5 = require(v2.Database.Security.Remotes)
local v_u_6 = require(v2.Controllers.DataController)
local v_u_7 = v4.LocalPlayer
local v_u_8 = v3.CurrentCamera
local v_u_9 = 0
local v_u_10 = RaycastParams.new()
v_u_10.FilterType = Enum.RaycastFilterType.Exclude
v_u_10.IgnoreWater = false
local function v_u_14(p11)
    while p11 do
        if v_u_1:HasTag(p11, "WeaponDropped") then
            local v12 = p11:GetAttribute("Weapon")
            local v13 = p11:GetAttribute("Skin")
            if v12 and v13 then
                return v12, v13, p11.Name
            end
            break
        end
        p11 = p11.Parent
    end
    return nil, nil, nil
end
local function v_u_18(...)
    local v15 = { v_u_8, ... }
    v_u_10.FilterDescendantsInstances = v15
    local v16 = workspace:Raycast(v_u_8.CFrame.Position, v_u_8.CFrame.LookVector * 1000, v_u_10)
    while v16 and v16.Instance do
        local v17 = v16.Instance
        if not v17:IsA("BasePart") or v17.Transparency <= 0.98 then
            break
        end
        table.insert(v15, v17)
        v_u_10.FilterDescendantsInstances = v15
        v16 = workspace:Raycast(v16.Position, v_u_8.CFrame.LookVector.Unit * (1000 - v16.Distance), v_u_10)
    end
    return v16 or nil
end
local v28 = {
    ["Name"] = "Ping",
    ["Group"] = "Gameplay",
    ["Category"] = "UI Keys",
    ["Callback"] = function(p19)
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            return
        elseif v_u_6.Get(v_u_7, "Settings.Game.HUD.Player Pings") == "Disabled" then
            return
        else
            local v20 = v_u_7.Character
            local v21
            if v20 and v20:IsDescendantOf(workspace) then
                local v22 = v20:FindFirstChildOfClass("Humanoid")
                v21 = v22 and v22.Health > 0 and true or false
            else
                v21 = false
            end
            local v23 = v21 and (p19 == Enum.UserInputState.Begin and v_u_18(v_u_7.Character))
            if v23 then
                local v24, v25, v26 = v_u_14(v23.Instance)
                local v27
                if v24 then
                    if v25 then
                        v27 = v26
                    else
                        v27 = v25
                    end
                else
                    v27 = v24
                end
                if v27 then
                    v_u_5.Ping.CreatePlayerPositionPing.Send({
                        ["Position"] = v23.Position,
                        ["WeaponIdentity"] = v26,
                        ["WeaponName"] = v24,
                        ["WeaponSkin"] = v25,
                        ["IsDanger"] = false
                    })
                else
                    v_u_5.Ping.CreatePlayerPositionPing.Send({
                        ["IsDanger"] = tick() - v_u_9 < 0.5,
                        ["Position"] = v23.Position
                    })
                end
                v_u_9 = tick()
            end
        end
    end
}
return table.freeze(v28)