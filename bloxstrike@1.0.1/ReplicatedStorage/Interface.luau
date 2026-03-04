local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("StarterGui")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v_u_2.Classes.Sound)
local v_u_7 = require(v_u_2.Database.Security.Router)
local v_u_8 = require(v_u_2.Shared.Promise)
local v_u_9 = require(v_u_2.Controllers.DataController)
local v_u_10 = require(script.MenuState)
local v_u_11 = script:WaitForChild("Screens")
local v_u_12 = v_u_2.Assets.UI.MainGui
v_u_12.Parent = v_u_5
local function v_u_14(p_u_13)
    debug.setmemorycategory((("%*"):format(p_u_13.Name)))
    return v_u_8.try(function()
        return require(p_u_13)
    end):catch(warn)
end
local function v_u_26(p15, p_u_16)
    if p_u_16 then
        local function v_u_20(p17)
            local v18 = p_u_16
            for v19 in string.gmatch(p17, "[^/]+") do
                if not v18 then
                    return nil
                end
                v18 = v18:FindFirstChild(v19)
            end
            return v18
        end
        for _, v_u_21 in ipairs(p15:GetChildren()) do
            local v_u_22 = p_u_16:FindFirstChild(v_u_21.Name)
            if v_u_21:IsA("Folder") then
                if v_u_22 then
                    v_u_26(v_u_21, v_u_22)
                else
                    warn((("Missing corresponding interface folder : \"%*\""):format((string.lower(v_u_21:GetFullName())))))
                end
            elseif v_u_21:IsA("ModuleScript") then
                v_u_14(v_u_21):andThen(function(p23)
                    if p23 then
                        local v24 = v_u_22
                        local v25 = p23.PointerPath
                        if typeof(v25) == "string" and v25 ~= "" then
                            v24 = v_u_20(v25)
                        end
                        if v24 then
                            v_u_8.try(p23.Initialize, v_u_12, v24):andThen(p23.Start):catch(warn)
                        else
                            warn((("Missing corresponding interface module for : \"%*\""):format((string.lower(v_u_21:GetFullName())))))
                        end
                    else
                        return
                    end
                end)
            end
        end
    else
        warn((("Pointer: \"%*\" is not apart of interface."):format(p15.Name)))
    end
end
function v_u_1.guarantee(p27)
    for _ = 1, 15 do
        if pcall(p27) then
            break
        end
    end
end
function v_u_1.Initialize()
    v_u_10.Initialize(v_u_12)
    v_u_1.guarantee(function()
        v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        v_u_3:SetCore("ResetButtonCallback", false)
    end)
    local v_u_28 = v_u_12:WaitForChild("Gameplay"):WaitForChild("Bottom")
    local v_u_29 = nil
    local v_u_30 = nil
    local v_u_31 = nil
    local v_u_32 = nil
    local v_u_33 = nil
    local function v_u_37(p34)
        local v35 = require(v_u_2.Components.Common.GetUserPlatform)
        local v36 = table.find(v35(), "Mobile") and 1 or p34
        if v_u_29 then
            v_u_29.Scale = v36
        end
        if v_u_30 then
            v_u_30.Scale = v36
        end
        if v_u_31 then
            v_u_31.Scale = v36
        end
        if v_u_32 then
            v_u_32.Scale = v36
        end
        if v_u_33 then
            v_u_33.Scale = v36
        end
    end
    task.spawn(function()
        task.wait(0.1)
        local v38 = v_u_28:FindFirstChild("Ammo")
        if v38 then
            local v39 = v38:FindFirstChild("UIScale")
            if v39 then
                v_u_29 = v39
            else
                local v40 = Instance.new("UIScale")
                v40.Name = "HUDScale"
                v40.Parent = v38
                v_u_29 = v40
            end
        end
        local v41 = v_u_28:FindFirstChild("Armor")
        if v41 then
            local v42 = v41:FindFirstChild("UIScale")
            if v42 then
                v_u_30 = v42
            else
                local v43 = Instance.new("UIScale")
                v43.Name = "HUDScale"
                v43.Parent = v41
                v_u_30 = v43
            end
        end
        local v44 = v_u_28:FindFirstChild("Health")
        if v44 then
            local v45 = v44:FindFirstChild("UIScale")
            if v45 then
                v_u_31 = v45
            else
                local v46 = Instance.new("UIScale")
                v46.Name = "HUDScale"
                v46.Parent = v44
                v_u_31 = v46
            end
        end
        local v47 = v_u_28:FindFirstChild("Inventory")
        if v47 then
            local v48 = v47:FindFirstChild("UIScale")
            if v48 then
                v_u_32 = v48
            else
                local v49 = Instance.new("UIScale")
                v49.Name = "HUDScale"
                v49.Parent = v47
                v_u_32 = v49
            end
        end
        local v50 = v_u_28:FindFirstChild("Money")
        if v50 then
            local v51 = v50:FindFirstChild("UIScale")
            if v51 then
                v_u_33 = v51
            else
                local v52 = Instance.new("UIScale")
                v52.Name = "HUDScale"
                v52.Parent = v50
                v_u_33 = v52
            end
        end
        v_u_37(v_u_9.Get(v_u_4, "Settings.Game.HUD.Scale") or 1)
    end)
    v_u_9.CreateListener(v_u_4, "Settings.Game.HUD.Scale", function(p53)
        if v_u_29 and (v_u_30 and (v_u_31 and (v_u_32 and v_u_33))) then
            v_u_37(p53 or 1)
        end
    end)
    v_u_7.observerRouter("RunInterfaceSound", function(p54)
        local v55 = (v_u_9.Get(v_u_4, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
        local v56 = {
            ["Parent"] = v_u_5,
            ["Name"] = p54
        }
        v_u_6.new("Interface"):playOneTime(v56, v55)
    end)
    v_u_7.observerRouter("RunStoreSound", function(p57)
        local v58 = (v_u_9.Get(v_u_4, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
        local v59 = {
            ["Parent"] = v_u_5,
            ["Name"] = p57
        }
        v_u_6.new("Store"):playOneTime(v59, v58)
    end)
end
function v_u_1.Start()
    v_u_26(v_u_11, v_u_12)
end
return v_u_1