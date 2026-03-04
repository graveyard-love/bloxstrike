local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v5 = require(v2.Packages.Signal)
v_u_1.OnScreenChanged = v5.new()
v_u_1.OnInspectStateChanged = v5.new()
v_u_1.OnCaseSceneStateChanged = v5.new()
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = false
local v_u_9 = false
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
function v_u_1.Initialize(p14)
    v_u_12 = p14
    local v15
    if v_u_13 then
        v15 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v15 = v_u_13
    end
    v_u_13 = v15
end
function v_u_1.GetCurrentScreen()
    return v_u_6
end
function v_u_1.GetPreviousScreen()
    return v_u_7
end
function v_u_1.IsInspectActive()
    return v_u_8
end
function v_u_1.SetScreen(p16)
    if p16 ~= v_u_6 then
        local v17 = v_u_6
        v_u_7 = v17
        v_u_6 = p16
        v_u_1.OnScreenChanged:Fire(v17, p16)
    end
end
function v_u_1.EnterInspect()
    if not v_u_8 then
        v_u_10 = v_u_6
        v_u_8 = true
        v_u_1.OnInspectStateChanged:Fire(true)
    end
end
function v_u_1.ExitInspect()
    if v_u_8 then
        v_u_8 = false
        v_u_1.OnInspectStateChanged:Fire(false)
        v_u_10 = nil
    end
end
function v_u_1.GetScreenBeforeInspect()
    return v_u_10
end
function v_u_1.IsCaseSceneActive()
    return v_u_9
end
function v_u_1.EnterCaseScene()
    if not v_u_9 then
        v_u_11 = v_u_6
        v_u_9 = true
        v_u_1.OnCaseSceneStateChanged:Fire(true)
    end
end
function v_u_1.ExitCaseScene()
    if v_u_9 then
        v_u_9 = false
        v_u_1.OnCaseSceneStateChanged:Fire(false)
        v_u_11 = nil
    end
end
function v_u_1.GetScreenBeforeCaseScene()
    return v_u_11
end
function v_u_1.SetBlurEnabled(p18)
    local v19
    if v_u_13 then
        v19 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v19 = v_u_13
    end
    if v19 then
        v19.Enabled = p18
    end
end
function v_u_1.IsBlurEnabled()
    local v20
    if v_u_13 then
        v20 = v_u_13
    else
        v_u_13 = v_u_3:FindFirstChild("Menu")
        v20 = v_u_13
    end
    return v20 and v20.Enabled or false
end
function v_u_1.GetMenuFrame()
    if not v_u_12 then
        v_u_12 = v_u_4:FindFirstChild("MainGui")
    end
    if v_u_12 then
        return v_u_12:FindFirstChild("Menu")
    else
        return nil
    end
end
function v_u_1.GetMainGui()
    if not v_u_12 then
        v_u_12 = v_u_4:FindFirstChild("MainGui")
    end
    return v_u_12
end
return v_u_1