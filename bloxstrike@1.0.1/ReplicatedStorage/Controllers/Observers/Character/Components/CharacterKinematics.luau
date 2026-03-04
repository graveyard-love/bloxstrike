local v1 = {}
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Workspace")
local v_u_6 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local function v_u_16(p12)
    local v13 = p12:FindFirstChild("RightShoulder", true)
    local v14 = p12:FindFirstChild("LeftShoulder", true)
    local v15 = p12:FindFirstChild("RootJoint", true)
    return v13, v14, p12:FindFirstChild("Waist", true), p12:FindFirstChild("Neck", true), v15
end
local function v_u_25(p17, p18)
    local v19, v20, v21, v22, v23 = v_u_16(p18)
    if not (v19 and (v20 and v21)) then
        v_u_11[p17] = nil
        return nil
    end
    local v24 = {
        ["Character"] = p18,
        ["RightShoulder"] = v19,
        ["LeftShoulder"] = v20,
        ["Waist"] = v21,
        ["Neck"] = v22,
        ["RootJoint"] = v23,
        ["BaseC0"] = {
            v19.C0,
            v20.C0,
            v21.C0,
            v22 and v22.C0 or nil,
            v23 and v23.C0 or nil
        },
        ["LastAppliedRotation"] = nil,
        ["LastAppliedVerticalLook"] = nil
    }
    v_u_11[p17] = v24
    return v24
end
local function v_u_29(p26)
    local v27 = p26.Character
    if v27 then
        local v28 = v_u_11[p26]
        if v28 and (v28.Character == v27 and (v28.RightShoulder.Parent and (v28.LeftShoulder.Parent and (v28.Waist.Parent and (not v28.Neck or v28.Neck.Parent))))) then
            return v28
        else
            return v_u_25(p26, v27)
        end
    else
        v_u_11[p26] = nil
        return nil
    end
end
function v1.updateKinematics(p30, p31, p32)
    local v33 = v_u_29(p30)
    if v33 and v33.Character == p31 then
        local v34 = v33.BaseC0
        v_u_2:Create(v33.RightShoulder, v_u_6, {
            ["C0"] = v34[1] * CFrame.Angles(1.0471975511965976 * p32.LookVector.Y * 0.5, 0, 0)
        }):Play()
        v_u_2:Create(v33.LeftShoulder, v_u_6, {
            ["C0"] = v34[2] * CFrame.Angles(1.0471975511965976 * p32.LookVector.Y * 0.5, 0, 0)
        }):Play()
        v_u_2:Create(v33.Waist, v_u_6, {
            ["C0"] = v34[3] * CFrame.Angles(1.0471975511965976 * p32.LookVector.Y * 0.6, 0, 0)
        }):Play()
        if v33.Neck and v34[4] then
            v_u_2:Create(v33.Neck, v_u_6, {
                ["C0"] = v34[4] * CFrame.Angles(1.0471975511965976 * p32.LookVector.Y, 0, 0)
            }):Play()
        end
    end
end
function v1.setTargetRotation(p35, p36)
    v_u_7[p35] = p36
    if v_u_8[p35] == nil then
        v_u_8[p35] = p36
    end
    v_u_29(p35)
end
function v1.setVerticalLook(p37, p38)
    v_u_9[p37] = p38
    if v_u_10[p37] == nil then
        v_u_10[p37] = p38
    end
end
function v1.cleanup(p39)
    local v40 = v_u_11[p39]
    v_u_11[p39] = nil
    v_u_7[p39] = nil
    v_u_8[p39] = nil
    v_u_9[p39] = nil
    v_u_10[p39] = nil
    if v40 and (v40.Character and v40.Character:IsDescendantOf(v_u_5)) then
        if not v40.RightShoulder.Parent or (not v40.LeftShoulder.Parent or (not v40.Waist.Parent or v40.Neck and not v40.Neck.Parent)) then
            return
        end
        v_u_2:Create(v40.RightShoulder, v_u_6, {
            ["C0"] = v40.BaseC0[1]
        }):Play()
        v_u_2:Create(v40.LeftShoulder, v_u_6, {
            ["C0"] = v40.BaseC0[2]
        }):Play()
        v_u_2:Create(v40.Waist, v_u_6, {
            ["C0"] = v40.BaseC0[3]
        }):Play()
        if v40.Neck and v40.BaseC0[4] then
            v_u_2:Create(v40.Neck, v_u_6, {
                ["C0"] = v40.BaseC0[4]
            }):Play()
        end
        if v40.RootJoint and v40.BaseC0[5] then
            v40.RootJoint.C0 = v40.BaseC0[5]
        end
    end
end
v3.RenderStepped:Connect(function(p41)
    local v42 = p41 * 15
    local v43 = math.min(1, v42)
    for v44, v45 in pairs(v_u_7) do
        local v46 = v_u_29(v44)
        if v46 then
            local v47
            if v_u_8[v44] == nil then
                v47 = v45
            else
                v47 = v_u_8[v44]
            end
            local v48 = v45 - v47
            while v48 > 3.141592653589793 do
                v48 = v48 - 6.283185307179586
            end
            while v48 < -3.141592653589793 do
                v48 = v48 + 6.283185307179586
            end
            local v49 = v47 + v48 * v43
            v_u_8[v44] = v49
            local v50 = v46.BaseC0
            local v51 = v50[5]
            if v46.RootJoint and v51 then
                if not v46.LastAppliedRotation then
                    ::l16::
                    v46.RootJoint.C0 = CFrame.new(v51.Position) * CFrame.Angles(0, v49, 0)
                    v46.LastAppliedRotation = v49
                    goto l13
                end
                local v52 = v49 - v46.LastAppliedRotation
                if math.abs(v52) >= 0.0001 then
                    goto l16
                end
            end
            ::l13::
            local v53 = v_u_9[v44]
            if v53 ~= nil then
                local v54
                if v_u_10[v44] == nil then
                    v54 = v53
                else
                    v54 = v_u_10[v44]
                end
                local v55 = v54 + (v53 - v54) * v43
                v_u_10[v44] = v55
                if v46.LastAppliedVerticalLook then
                    local v56 = v55 - v46.LastAppliedVerticalLook
                    if math.abs(v56) >= 0.0001 then
                        goto l22
                    end
                else
                    ::l22::
                    v46.RightShoulder.C0 = v50[1] * CFrame.Angles(v55 * 1.0471975511965976 * 0.5, 0, 0)
                    v46.LeftShoulder.C0 = v50[2] * CFrame.Angles(v55 * 1.0471975511965976 * 0.5, 0, 0)
                    v46.Waist.C0 = v50[3] * CFrame.Angles(v55 * 1.0471975511965976 * 0.6, 0, 0)
                    if v46.Neck and v50[4] then
                        v46.Neck.C0 = v50[4] * CFrame.Angles(v55 * 1.0471975511965976, 0, 0)
                    end
                    v46.LastAppliedVerticalLook = v55
                end
            end
        end
    end
end)
v4.PlayerRemoving:Connect(function(p57)
    v_u_11[p57] = nil
    v_u_7[p57] = nil
    v_u_8[p57] = nil
    v_u_9[p57] = nil
    v_u_10[p57] = nil
end)
return v1