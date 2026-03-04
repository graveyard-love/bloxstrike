local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v1.Shared.Janitor)
local function v_u_45(p6, p7, p8)
    if p7 then
        if p6.Visible then
            if p6:IsDescendantOf(game) then
                local v9 = p8 or 1
                local v10 = p7.Alpha
                local v11 = 1
                if v10 and (type(v10) == "table" and v10.Enabled) then
                    local v12 = v10.Value
                    if type(v12) == "number" then
                        v11 = v10.Value / 255
                    end
                end
                local v13 = p7.Red or 0
                local v14 = p7.Green or 255
                local v15 = p7.Blue or 0
                local v16 = Color3.fromRGB(tonumber(v13) or 0, tonumber(v14) or 255, tonumber(v15) or 0)
                local v17 = p7["Crosshair Style"]
                local v18 = v17 == "Image"
                local v19 = v17 == "Classic"
                local v20 = p6:FindFirstChild("Ticks")
                local v21 = p6:FindFirstChild("Dot")
                local v22 = p6:FindFirstChild("Crosshair")
                if v20 and (v21 and v22) then
                    v20.Visible = not v18
                    local v23 = not v18
                    if v23 then
                        v23 = p7["Center Dot"] == true
                    end
                    v21.Visible = v23
                    v22.Visible = v18
                    if v18 then
                        local v24 = p7["Crosshair Image"]
                        local v25 = "rbxassetid://" .. tostring(v24)
                        v22.Image = type(v25) == "string" and v25 and v25 or "rbxassetid://00000000"
                        v22.ImageColor3 = v16
                        v22.ImageTransparency = 1 - v11
                    else
                        local v26 = p7.Outline
                        local v27, v28
                        if v26 and type(v26) == "table" then
                            v27 = v26.Enabled == true
                            local v29 = v26.Value
                            v28 = tonumber(v29) or 1
                        else
                            v27 = false
                            v28 = 1
                        end
                        for _, v30 in ipairs({
                            "Up",
                            "Down",
                            "Left",
                            "Right"
                        }) do
                            local v31 = v20:FindFirstChild(v30)
                            if v31 then
                                v31.BackgroundColor3 = v16
                                v31.BackgroundTransparency = 1 - v11
                                v31.Visible = true
                                local v32 = p7.Length
                                local v33 = tonumber(v32) or 5
                                local v34 = p7.Thickness
                                local v35 = tonumber(v34) or 1
                                local v36 = 15 * (v33 / 5)
                                local v37 = 2 * (v35 / 1)
                                if v30 == "Up" or v30 == "Down" then
                                    v31.Size = UDim2.new(0, v37, 0, v36)
                                else
                                    v31.Size = UDim2.new(0, v36, 0, v37)
                                end
                                if v27 then
                                    v31.BorderSizePixel = v28
                                    v31.BorderColor3 = Color3.new(0, 0, 0)
                                else
                                    v31.BorderSizePixel = 0
                                end
                            end
                        end
                        local v38 = v20:FindFirstChild("Up")
                        if v38 then
                            v38.Visible = p7["T Style"] ~= true
                        end
                        if v21 and p7["Center Dot"] == true then
                            v21.BackgroundColor3 = v16
                            v21.BackgroundTransparency = 1 - v11
                            if v27 then
                                v21.BorderSizePixel = v28
                                v21.BorderColor3 = Color3.new(0, 0, 0)
                            else
                                v21.BorderSizePixel = 0
                            end
                        end
                        local v39 = p7.Gap
                        local v40 = 5 + (tonumber(v39) or -1) * 5 / 5
                        if v19 then
                            v40 = v40 * v9
                        end
                        local v41 = v20:FindFirstChild("Right")
                        local v42 = v20:FindFirstChild("Down")
                        local v43 = v20:FindFirstChild("Left")
                        local v44 = v20:FindFirstChild("Up")
                        if v41 then
                            v41.Position = UDim2.new(0.5, v40, 0.5, 0)
                        end
                        if v42 then
                            v42.Position = UDim2.new(0.5, 0, 0.5, v40)
                        end
                        if v43 then
                            v43.Position = UDim2.new(0.5, -v40, 0.5, 0)
                        end
                        if v44 then
                            v44.Position = UDim2.new(0.5, 0, 0.5, -v40)
                        end
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
return function(p46, p47, p_u_48, _, p_u_49, _, _, _)
    p_u_48.LayoutOrder = p47
    local v_u_50 = v_u_5.new()
    v_u_50:Add(p_u_48, "Destroy")
    local v_u_51 = p_u_48.Crosshair
    local v_u_52 = 0
    v_u_50:Add(v_u_2.Stepped:Connect(function(_, p53)
        local v54 = p_u_48:FindFirstAncestorOfClass("ScrollingFrame")
        local v55 = v54 and v54.Visible
        if v55 then
            v55 = v54:IsDescendantOf(v_u_4.PlayerGui)
        end
        if v55 then
            local v56 = p_u_49()
            if v56 then
                local v57
                if v56["Crosshair Style"] == "Classic" then
                    v_u_52 = v_u_52 + p53
                    local v58 = v_u_52 * 3.141592653589793 * 2 * 0.25
                    local v59 = math.sin(v58) * 2 + 1
                    v57 = math.max(v59, 0.75)
                else
                    v_u_52 = 0
                    v57 = 1
                end
                v_u_45(v_u_51, v56, v57)
            end
        else
            return
        end
    end), "Disconnect")
    p_u_48.Parent = p46
    return function()
        v_u_50:Cleanup()
    end
end