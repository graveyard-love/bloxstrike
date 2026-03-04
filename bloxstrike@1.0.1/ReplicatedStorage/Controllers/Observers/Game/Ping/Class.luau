local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
require(script.Parent.Types)
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_6 = require(v_u_2.Shared.Janitor)
local v_u_7 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
local v_u_8 = require(v_u_2.Database.Custom.GameStats.Rarities)
function v_u_1.UpdateVisibility(p9, p10)
    if (p10 or v_u_4:GetAttribute("Team")) == p9.CurrentTeam then
        if p9.Model.Parent == nil and p9.OriginalParent then
            p9.Model.Parent = p9.OriginalParent
        end
    else
        p9.Model.Parent = nil
    end
end
function v_u_1.new(p11, p12, p13)
    local v14 = {
        ["Weapon"] = p11:GetAttribute("Weapon"),
        ["Skin"] = p11:GetAttribute("Skin")
    }
    local v15 = v_u_1
    local v_u_16 = setmetatable(v14, v15)
    v_u_16.Janitor = v_u_6.new()
    v_u_16.Identifier = p12
    v_u_16.CurrentTeam = p11:GetAttribute("Team")
    v_u_16.IsDanger = p11:GetAttribute("IsDanger")
    v_u_16.OriginalParent = p11.Parent
    v_u_16.Model = p11
    v_u_16:UpdateVisibility(p13)
    task.delay(0.016666666666666666, function()
        local v17 = v_u_7["Team Color"][v_u_16.CurrentTeam]
        v_u_16.Model.Name = v_u_16.Identifier
        if v17 then
            local v18 = v_u_16.Model:FindFirstChildOfClass("BillboardGui")
            if v18 and v18:IsDescendantOf(workspace) then
                local v19 = v_u_16.Weapon
                local v20
                if typeof(v19) == "string" and v_u_16.Weapon ~= "" then
                    local v21 = v_u_16.Skin
                    if typeof(v21) == "string" then
                        v20 = v_u_16.Skin ~= ""
                    else
                        v20 = false
                    end
                else
                    v20 = false
                end
                local v22 = v18.Info
                local v23 = not v_u_16.IsDanger
                if v23 then
                    v23 = not v20
                end
                v22.Visible = v23
                local v24 = v18.Danger
                local v25 = v_u_16.IsDanger
                if v25 then
                    v25 = not v20
                end
                v24.Visible = v25
                v18.Weapon.Visible = v20
                if v18.Info.Visible then
                    v18.Info.ImageColor3 = v17
                    return
                end
                if v20 then
                    local v26 = v_u_16.Weapon
                    local v27 = v_u_16.Skin
                    local v28 = v_u_5.GetSkinInformation(v26, v27)
                    local v29 = v_u_2.Database.Custom.Weapons:FindFirstChild(v26)
                    local v30
                    if v29 and v29:IsA("ModuleScript") then
                        local v31, v32 = pcall(require, v29)
                        v30 = v31 and v32 and v32 or nil
                    else
                        v30 = nil
                    end
                    local v33
                    if v28 then
                        v33 = v_u_8[v28.rarity]
                    else
                        v33 = v28
                    end
                    if not (v28 and (v30 and v33)) then
                        v18.Weapon.Visible = false
                        v18.Info.Visible = not v_u_16.IsDanger
                        v18.Danger.Visible = v_u_16.IsDanger
                        if v18.Info.Visible then
                            v18.Info.ImageColor3 = v17
                        end
                        return
                    end
                    v18.Weapon.Icon.ImageColor3 = v33.Color
                    v18.Weapon.Icon.Image = v30.Icon
                end
            end
        end
    end)
    return v_u_16
end
function v_u_1.Destroy(p34)
    p34.Janitor:Destroy()
end
return v_u_1