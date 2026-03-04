local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_4 = v_u_3.LocalPlayer
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local function v_u_24(p8)
    local v9 = p8.Character
    if typeof(v9) == "Instance" and v9:IsA("Model") then
        return v9
    else
        local v10 = p8.Victim
        local v11 = tonumber(v10)
        if v11 then
            local v12 = v_u_3:GetPlayerByUserId(v11)
            if v12 then
                local v13 = workspace:FindFirstChild("Debris")
                if v13 then
                    v13 = v13:FindFirstChild(v12.Name)
                end
                local v14
                if v13 and v13:IsA("Model") then
                    if v13:GetAttribute("Dead") == true then
                        v14 = true
                    else
                        local v15 = v13:FindFirstChildOfClass("Humanoid")
                        if v15 == nil then
                            v14 = false
                        else
                            v14 = v15.Health <= 0
                        end
                    end
                else
                    v14 = false
                end
                if v14 then
                    return v13
                else
                    local v16 = workspace:FindFirstChild("Characters")
                    if v16 then
                        for _, v17 in ipairs(v16:GetChildren()) do
                            if v17:IsA("Folder") then
                                local v18 = v17:FindFirstChild(v12.Name)
                                local v19
                                if v18 and v18:IsA("Model") then
                                    if v18:GetAttribute("Dead") == true then
                                        v19 = true
                                    else
                                        local v20 = v18:FindFirstChildOfClass("Humanoid")
                                        if v20 == nil then
                                            v19 = false
                                        else
                                            v19 = v20.Health <= 0
                                        end
                                    end
                                else
                                    v19 = false
                                end
                                if v19 then
                                    return v18
                                end
                            end
                        end
                    end
                    local v21 = v12.Character
                    local v22
                    if v21 and v21:IsA("Model") then
                        if v21:GetAttribute("Dead") == true then
                            v22 = true
                        else
                            local v23 = v21:FindFirstChildOfClass("Humanoid")
                            if v23 == nil then
                                v22 = false
                            else
                                v22 = v23.Health <= 0
                            end
                        end
                    else
                        v22 = false
                    end
                    if v22 then
                        return v21
                    else
                        return nil
                    end
                end
            else
                return nil
            end
        else
            return nil
        end
    end
end
function v_u_1.IsFinisherValidForReplication(p25)
    local v26 = v_u_7[p25.Finisher]
    local v27 = ("\"%*\" is not a valid member of database.custom.finishers"):format(p25.Finisher)
    assert(v26, v27)
    local v28 = v_u_4.UserId
    local v29 = tostring(v28)
    return v26.Replication == "Killer" and p25.Killer == v29 and true or (v26.Replication == "Victim" and p25.Victim == v29 and true or (v26.Replication == "Both" and (p25.Killer == v29 or p25.Victim == v29) and true or v26.Replication == "All"))
end
function v_u_1.ExecuteFinisher(p_u_30)
    if v_u_1.IsFinisherValidForReplication(p_u_30) then
        local v_u_31 = v_u_7[p_u_30.Finisher]
        local v32 = ("\"%*\" is not a valid member of database.custom.finishers"):format(p_u_30.Finisher)
        assert(v_u_31, v32)
        local v41, v42 = pcall(function()
            local v33 = v_u_24(p_u_30)
            if v33 then
                v33.Archivable = true
                local v34 = v_u_6[v33.Name]
                if v34 then
                    v34.Destroy()
                end
                while #v_u_5 >= 8 do
                    local v35 = table.remove(v_u_5, 1)
                    if v35 then
                        v35.Destroy()
                    end
                end
                local v_u_36 = v_u_31.Finisher(v33, p_u_30)
                local v_u_37 = v33.Name
                local v_u_38 = {
                    ["Name"] = v_u_37,
                    ["Destroy"] = function()
                        v_u_6[v_u_37] = nil
                        v_u_36.Destroy()
                    end
                }
                v_u_6[v_u_37] = v_u_36
                local v39 = v_u_5
                table.insert(v39, v_u_38)
                v_u_36.OnDestroy:Once(function()
                    local v40 = table.find(v_u_5, v_u_38)
                    if v40 then
                        table.remove(v_u_5, v40)
                    end
                end)
            else
                warn((("Failed to execute finisher \"%*\": missing victim character \"%*\""):format(p_u_30.Finisher, p_u_30.Victim)))
            end
        end)
        if not v41 then
            warn((("Failed to execute finisher \"%*\": %*"):format(p_u_30.Finisher, v42)))
        end
    end
end
for _, v43 in ipairs(v2.Database.Custom.Finishers:GetChildren()) do
    if v43:IsA("ModuleScript") then
        v_u_7[v43.Name] = require(v43)
    end
end
return v_u_1