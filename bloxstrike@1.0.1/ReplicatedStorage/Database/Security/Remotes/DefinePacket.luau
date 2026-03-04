local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Shared.DebugFlags)
local v_u_6 = v_u_3:IsClient()
local v_u_7 = require(v2.Shared.Janitor)
local v_u_8 = {}
local v_u_9 = {}
local function v_u_15(p10, p11)
    local v12 = {}
    for _, v13 in pairs(v_u_1:GetPlayers()) do
        if v13.Character and v13.Character:FindFirstChild("HumanoidRootPart") then
            local v14 = v13.Character:FindFirstChild("HumanoidRootPart")
            if v14 and (v14.Position - p10).Magnitude <= p11 then
                table.insert(v12, v13)
            end
        end
    end
    return v12
end
local function v_u_25(p_u_16, p17, p18)
    local v19 = tick()
    local v20 = v_u_8[p_u_16]
    if not v20 then
        v20 = {}
        v_u_8[p_u_16] = v20
        local v21 = v_u_7.new()
        v_u_9[p_u_16] = v21
        v21:Add(v_u_1.PlayerRemoving:Connect(function(p22)
            if p22 == p_u_16 then
                local v23 = p_u_16
                v_u_8[v23] = nil
                if v_u_9[v23] then
                    v_u_9[v23]:Destroy()
                    v_u_9[v23] = nil
                end
            end
        end))
    end
    local v24 = v20[p17]
    if v24 then
        if v19 - v24.lastRequest >= 1 then
            v24.lastRequest = v19
            v24.requestCount = 1
            return false
        else
            if p18 <= v24.requestCount then
                return true
            end
            v24.requestCount = v24.requestCount + 1
            return false
        end
    else
        v20[p17] = {
            ["lastRequest"] = v19,
            ["requestCount"] = 1
        }
        return false
    end
end
local function v_u_36(p26, p27, p_u_28, p29)
    if v_u_5.IsEnabled("ByteNetPackets") then
        local v30, v31 = pcall(function()
            return v_u_4:JSONEncode(p_u_28)
        end)
        local v32 = not v30 and "unknown" or string.format("%.3f KB", #v31 / 1024)
        local v33 = v_u_3:IsServer() and "[SERVER]" or "[CLIENT]"
        local v34 = p26 == "OUTGOING" and "\226\172\134\239\184\143" or "\226\172\135\239\184\143"
        local v35 = not p29 and "" or " | Player: " .. p29.Name
        print(string.format("%s %s %s %s | Size: %s%s | Data: %s", v33, v34, p26, p27, v32, v35, not v30 and "{}" or v31))
    end
end
local function v_u_39(p37)
    if not p37 or p37 == "" then
        return "unknown"
    end
    local v38 = string.gsub(string.gsub(p37, "^@", ""), "\\", "/")
    return v38:match("(ReplicatedStorage/.+)") or (v38:match("(StarterPlayer/.+)") or v38:match("(ReplicatedFirst/.+)") or (v38:match("(ServerScriptService/.+)") or v38))
end
local function v_u_45(p40)
    local v41 = v_u_39((debug.info(3, "s")))
    local v42 = debug.info(3, "l")
    if v42 then
        return ("%*:%*"):format(v41, v42)
    else
        local v43 = v_u_39((debug.info(p40, "s")))
        local v44 = debug.info(p40, "l")
        if v44 then
            return ("%*:%*"):format(v43, v44)
        elseif v41 == "unknown" then
            return v43
        else
            return v41
        end
    end
end
local function v_u_61(p46, p47, ...)
    local v48 = coroutine.create(p47)
    local v49 = table.pack(...)
    while true do
        debug.profilebegin(p46)
        local v50 = table.pack
        local v51 = coroutine.resume
        local v52 = v49.n
        local v53 = v50(v51(v48, table.unpack(v49, 1, v52)))
        debug.profileend()
        if not v53[1] then
            local v54 = error
            local v55 = debug.traceback
            local v56 = v53[2]
            v54(v55(v48, (tostring(v56))), 0)
        end
        if coroutine.status(v48) == "dead" then
            local v57 = v53.n
            return table.unpack(v53, 2, v57)
        end
        local v58 = table.pack
        local v59 = coroutine.yield
        local v60 = v53.n
        v49 = v58(v59(table.unpack(v53, 2, v60)))
    end
end
local function v_u_101(p_u_62, p_u_63, p_u_64)
    local v65 = {}
    for v_u_66, v67 in pairs(p_u_62) do
        if type(v67) == "function" then
            if v_u_66 == "Send" or (v_u_66 == "SendTo" or (v_u_66 == "SendToAll" or (v_u_66 == "SendToAllExcept" or v_u_66 == "SendToList"))) then
                v65[v_u_66] = function(p68, ...)
                    if v_u_66 == "SendToList" then
                        local v69 = select(1, ...)
                        if v69 and #v69 ~= 0 then
                            local v70 = {}
                            for _, v71 in ipairs(v69) do
                                local v72 = p_u_63
                                local v73 = p_u_64
                                local v74
                                if v72.middleware and not v72.middleware(p68, v71) then
                                    v74 = false
                                else
                                    local v75 = v72.maximum_requests_per_second or 10
                                    v74 = (v75 <= 0 or not v_u_25(v71, v73, v75)) and true or false
                                end
                                if v74 then
                                    table.insert(v70, v71)
                                end
                            end
                            if #v70 > 0 then
                                v_u_36("OUTGOING", p_u_64, p68)
                                return p_u_62[v_u_66](p68, v70)
                            end
                        end
                    else
                        local v76 = nil
                        if v_u_66 == "Send" then
                            v76 = v_u_1.LocalPlayer
                        elseif v_u_66 == "SendTo" then
                            v76 = select(1, ...)
                        end
                        if v76 then
                            local v77 = p_u_63
                            local v78 = p_u_64
                            local v79
                            if v77.middleware and not v77.middleware(p68, v76) then
                                v79 = false
                            else
                                local v80 = v77.maximum_requests_per_second or 10
                                v79 = (v80 <= 0 or not v_u_25(v76, v78, v80)) and true or false
                            end
                            if not v79 then
                                return
                            end
                        end
                        v_u_36("OUTGOING", p_u_64, p68, v76)
                        return p_u_62[v_u_66](p68, ...)
                    end
                end
            elseif v_u_66 == "Listen" or v_u_66 == "Connect" then
                v65[v_u_66] = function(p_u_81)
                    local v82 = v_u_45(p_u_81)
                    local v_u_83
                    if v_u_6 then
                        local v84 = p_u_64
                        if v84 == "" then
                            v84 = nil
                        elseif string.match(v84, "^function:%s*0x") or string.match(v84, "^table:%s*0x") then
                            v84 = nil
                        end
                        if v84 then
                            v_u_83 = ("ByteNet.Listen[%*] %*"):format(v84, v82)
                        else
                            v_u_83 = ("ByteNet.Listen %*"):format(v82)
                        end
                    else
                        v_u_83 = ""
                    end
                    local function v87(p85, p86)
                        v_u_36("INCOMING", p_u_64, p85, p86)
                        if v_u_6 then
                            return v_u_61(v_u_83, p_u_81, p85, p86)
                        else
                            return p_u_81(p85, p86)
                        end
                    end
                    return p_u_62[v_u_66](v87)
                end
            elseif v_u_66 == "Wait" then
                v65[v_u_66] = function()
                    local v88, v89 = p_u_62[v_u_66]()
                    v_u_36("INCOMING", p_u_64, v88, v89)
                    return v88, v89
                end
            else
                v65[v_u_66] = v67
            end
        else
            v65[v_u_66] = v67
        end
    end
    function v65.SendToProximity(p90, p91)
        local v92 = p91.position
        local v93 = p91.range or 60
        if not v92 then
            error("SendToProximity requires position in options")
        end
        local v94 = v_u_15(v92, v93)
        local v95 = false
        for _, v96 in pairs(v94) do
            local v97 = p_u_63
            local v98 = p_u_64
            local v99
            if v97.middleware and not v97.middleware(p90, v96) then
                v99 = false
            else
                local v100 = v97.maximum_requests_per_second or 10
                v99 = (v100 <= 0 or not v_u_25(v96, v98, v100)) and true or false
            end
            if v99 and p_u_62.SendTo then
                p_u_62.SendTo(p90, v96)
                v95 = true
            end
        end
        if v95 then
            v_u_36("OUTGOING", p_u_64, p90)
        end
    end
    return v65
end
return function(p_u_102, p103)
    local v_u_104 = p103 or {}
    local v_u_105 = v_u_104.name or tostring(p_u_102):gsub("table: ", "")
    return function(p106)
        return v_u_101(p_u_102(p106), v_u_104, v_u_105)
    end
end