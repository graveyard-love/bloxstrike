local v_u_1 = {}
local v_u_2 = game:GetService("ContextActionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = require(v3.Controllers.DataController)
local v_u_7 = require(v3.Components.Common.GetUserPlatform)
local v_u_8 = require(v3.Database.Security.Router)
local v_u_9 = require(script:WaitForChild("KeybindParser"))
local v_u_10 = script:WaitForChild("Actions")
local v_u_11 = v5.LocalPlayer
local v_u_12 = v_u_11:GetMouse()
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = {}
local v_u_16 = {
    ["ScrollWheelUp"] = nil,
    ["ScrollWheelDown"] = nil
}
local function v_u_21(p17, p18, p19)
    local v20 = v_u_15[p17]
    if v20 then
        if v_u_14[v20.Group] then
            v20.IsActive = p18 == Enum.UserInputState.Begin
            task.spawn(v20.Callback, p18, p19)
        end
    end
end
local function v_u_27(p22, p23)
    if p22 then
        local v24 = Enum.UserInputState.Begin
        local v25 = {
            ["UserInputType"] = Enum.UserInputType.MouseWheel,
            ["Delta"] = Vector3.new(0, p23, 0)
        }
        local v26 = v_u_15[p22]
        if v26 and v_u_14[v26.Group] then
            v26.IsActive = v24 == Enum.UserInputState.Begin
            task.spawn(v26.Callback, v24, v25)
        end
        task.defer(v_u_21, p22, Enum.UserInputState.End, {
            ["UserInputType"] = Enum.UserInputType.MouseWheel,
            ["Delta"] = Vector3.new(0, p23, 0)
        })
    end
end
function v_u_1.registerAction(p28)
    v_u_15[p28.Name] = {
        ["Category"] = p28.Category,
        ["Callback"] = p28.Callback,
        ["Group"] = p28.Group,
        ["BindPriority"] = p28.BindPriority,
        ["Name"] = p28.Name,
        ["IsActive"] = false,
        ["Keybinds"] = {}
    }
end
function v_u_1.bindKeybinds(p_u_29, p30)
    local v31 = v_u_15[p_u_29]
    if v31 then
        v_u_2:UnbindAction(p_u_29)
        for _, v32 in ipairs(v31.Keybinds) do
            if typeof(v32) == "string" then
                if v32 == "ScrollWheelUp" then
                    v_u_16.ScrollWheelUp = nil
                elseif v32 == "ScrollWheelDown" then
                    v_u_16.ScrollWheelDown = nil
                end
            else
                v_u_13[v32] = nil
            end
        end
        local v33 = {}
        local v34 = {}
        for _, v35 in ipairs(p30) do
            if v35 then
                if typeof(v35) == "string" then
                    if v35 == "ScrollWheelUp" and not v_u_16.ScrollWheelUp then
                        table.insert(v33, v35)
                        v_u_16.ScrollWheelUp = p_u_29
                    elseif v35 == "ScrollWheelDown" and not v_u_16.ScrollWheelDown then
                        table.insert(v33, v35)
                        v_u_16.ScrollWheelDown = p_u_29
                    end
                elseif not v_u_13[v35] then
                    table.insert(v33, v35)
                    table.insert(v34, v35)
                    v_u_13[v35] = p_u_29
                end
            end
        end
        v31.Keybinds = v33
        if #v34 > 0 then
            local function v39(_, p36, p37)
                local v38 = v_u_15[p_u_29]
                if v38 then
                    if v_u_14[v38.Group] then
                        v38.IsActive = p36 == Enum.UserInputState.Begin
                        task.spawn(v38.Callback, p36, p37)
                    end
                end
            end
            if v31.BindPriority ~= nil then
                v_u_2:BindActionAtPriority(p_u_29, v39, false, v31.BindPriority, table.unpack(v34))
                return
            end
            v_u_2:BindAction(p_u_29, v39, false, table.unpack(v34))
        end
    end
end
function v_u_1.loadActionsFromDatabase(p40)
    for _, v41 in pairs(p40) do
        for v42, v43 in pairs(v41) do
            local v44 = {}
            if typeof(v43) == "table" then
                local v45 = v43.Computer and v43.Computer ~= "" and v_u_9.parse(v43.Computer)
                if v45 then
                    table.insert(v44, v45)
                end
                local v46 = v43.Console and v43.Console ~= "" and v_u_9.parse(v43.Console)
                if v46 then
                    table.insert(v44, v46)
                end
            end
            if #v44 > 0 then
                v_u_1.bindKeybinds(v42, v44)
            end
        end
    end
end
function v_u_1.isActionActive(p47)
    local v48 = v_u_15[p47]
    return v48 and v48.IsActive or false
end
function v_u_1.enableGroup(p49)
    v_u_14[p49] = true
end
function v_u_1.disableGroup(p50)
    v_u_14[p50] = nil
end
function v_u_1.GetActionKeybind(p51)
    local v52 = v_u_15[p51]
    if v52 and #v52.Keybinds ~= 0 then
        local v53 = v52.Keybinds[1]
        if typeof(v53) == "string" then
            return v53
        else
            return tostring(v53):match("%.(%w+)$") or tostring(v53)
        end
    else
        return nil
    end
end
function v_u_1.Initialize()
    for _, v54 in ipairs(v_u_10:GetChildren()) do
        if v54:IsA("ModuleScript") then
            v_u_1.registerAction((require(v54)))
        end
    end
    v_u_1.enableGroup("Default")
    v_u_11.CharacterAdded:Connect(function(_)
        v_u_2:UnbindAction("jumpAction")
    end)
    v_u_6.CreateListener(v_u_11, "Settings.Keyboard/Mouse", function(p55)
        if p55 then
            v_u_1.loadActionsFromDatabase(p55)
        end
    end)
    v_u_8.observerRouter("RebindKeybinds", function()
        local v56 = v_u_6.Get(v_u_11, "Settings.Keyboard/Mouse")
        if not v56 then
            return false
        end
        v_u_1.loadActionsFromDatabase(v56)
        return true
    end)
end
function v_u_1.getActionKeybinds(p57)
    local v58 = v_u_15[p57]
    if not v58 then
        return {}
    end
    local v59 = {}
    for _, v60 in ipairs(v58.Keybinds) do
        if typeof(v60) ~= "string" then
            table.insert(v59, v60)
        end
    end
    return v59
end
function v_u_1.isBindingPressed(p61)
    if typeof(p61) == "string" then
        return false
    elseif typeof(p61) == "EnumItem" then
        if p61.EnumType == Enum.KeyCode then
            if p61 ~= Enum.KeyCode.ButtonR2 and p61 ~= Enum.KeyCode.ButtonL2 or not table.find(v_u_7(), "Console") then
                return v_u_4:IsKeyDown(p61)
            end
            local v62 = v_u_4:GetGamepadState(Enum.UserInputType.Gamepad1)
            for _, v63 in pairs(v62) do
                if v63.KeyCode == p61 then
                    return v63.Position.Z > 0.3
                end
            end
            return false
        elseif p61.EnumType == Enum.UserInputType then
            return v_u_4:IsMouseButtonPressed(p61)
        else
            return false
        end
    else
        return false
    end
end
function v_u_1.isActionPressed(p64, p65)
    local v66 = v_u_1.getActionKeybinds(p64)
    if #v66 == 0 then
        if not p65 or #p65 <= 0 then
            return false
        end
    else
        p65 = v66
    end
    for _, v67 in ipairs(p65) do
        if v_u_1.isBindingPressed(v67) then
            return true
        end
    end
    return false
end
function v_u_1.Start()
    v_u_12.WheelBackward:Connect(function()
        v_u_27(v_u_16.ScrollWheelDown, -1)
    end)
    v_u_12.WheelForward:Connect(function()
        v_u_27(v_u_16.ScrollWheelUp, 1)
    end)
end
return v_u_1