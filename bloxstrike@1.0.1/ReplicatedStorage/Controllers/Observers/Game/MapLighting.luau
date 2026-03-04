local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Lighting")
local v3 = game:GetService("Players")
local v_u_4 = v_u_1.Database.Custom.GameStats.Maps
local v_u_5 = require(v_u_1.Controllers.DataController)
local v_u_6 = v3.LocalPlayer
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local function v_u_18(p11)
    local v12 = v_u_4:FindFirstChild(p11)
    if v12 and v12:IsA("ModuleScript") then
        local v13 = require(v12)
        if v13.Lighting then
            local v14 = v13.Lighting.Properties
            if v14 then
                v_u_10 = v14.GlobalShadows
                v_u_2.Ambient = v14.Ambient
                v_u_2.Brightness = v14.Brightness
                v_u_2.ColorShift_Bottom = v14.ColorShift_Bottom
                v_u_2.ColorShift_Top = v14.ColorShift_Top
                v_u_2.EnvironmentDiffuseScale = v14.EnvironmentDiffuseScale
                v_u_2.EnvironmentSpecularScale = v14.EnvironmentSpecularScale
                v_u_2.GlobalShadows = v14.GlobalShadows
                v_u_2.OutdoorAmbient = v14.OutdoorAmbient
                v_u_2.ShadowSoftness = v14.ShadowSoftness
                v_u_2.ClockTime = v14.ClockTime
                v_u_2.GeographicLatitude = v14.GeographicLatitude
                v_u_2.ExposureCompensation = v14.ExposureCompensation
            end
            for _, v15 in ipairs(v_u_2:GetChildren()) do
                if v15.Name ~= "Menu" then
                    v15:Destroy()
                end
            end
            local v16 = v13.Lighting.Assets
            if v16 then
                for _, v17 in ipairs(v16:GetChildren()) do
                    v17:Clone().Parent = v_u_2
                end
            end
            if v_u_5.Get(v_u_6, "Settings.Video.Presets.Global Shadows") ~= false then
                if v_u_10 ~= nil then
                    v_u_2.GlobalShadows = v_u_10
                end
            else
                v_u_2.GlobalShadows = false
            end
        else
            warn((("[MapLighting]: Map \"%*\" has no lighting configuration"):format(p11)))
            return
        end
    else
        warn((("[MapLighting]: Map \"%*\" not found in database"):format(p11)))
        return
    end
end
local function v_u_20()
    if not v_u_7 then
        v_u_7 = require(v_u_1.Controllers.MenuSceneController)
    end
    if not v_u_8 then
        v_u_8 = require(v_u_1.Controllers.CaseSceneController)
    end
    if not v_u_9 then
        v_u_9 = require(v_u_1.Controllers.InspectController)
    end
    local v19 = not (v_u_7.IsActive() or v_u_8.IsActive())
    if v19 then
        v19 = not v_u_9.IsActive()
    end
    return v19
end
local function v_u_25(p_u_21)
    if v_u_20() then
        local v22 = p_u_21:GetAttribute("MapName")
        if not v22 or typeof(v22) ~= "string" then
            v22 = nil
        end
        if v22 then
            v_u_18(v22)
        else
            local v_u_23 = nil
            v_u_23 = p_u_21:GetAttributeChangedSignal("MapName"):Connect(function()
                if v_u_20() then
                    local v24 = p_u_21:GetAttribute("MapName")
                    if not v24 or typeof(v24) ~= "string" then
                        v24 = nil
                    end
                    if v24 then
                        v_u_23:Disconnect()
                        v_u_18(v24)
                    end
                else
                    v_u_23:Disconnect()
                end
            end)
        end
    else
        return
    end
end
v_u_5.CreateListener(v_u_6, "Settings.Video.Presets.Global Shadows", function()
    if v_u_5.Get(v_u_6, "Settings.Video.Presets.Global Shadows") ~= false then
        if v_u_10 ~= nil then
            v_u_2.GlobalShadows = v_u_10
        end
    else
        v_u_2.GlobalShadows = false
    end
end)
workspace.ChildAdded:Connect(function(p_u_26)
    if p_u_26.Name == "Map" then
        task.defer(function()
            v_u_25(p_u_26)
        end)
    end
end)
local v_u_27 = workspace:FindFirstChild("Map")
if v_u_27 then
    task.defer(function()
        v_u_25(v_u_27)
    end)
end
return nil