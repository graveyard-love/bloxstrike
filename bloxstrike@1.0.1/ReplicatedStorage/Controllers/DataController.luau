local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = require(v2.Database.Components.Libraries.Stock)
local v_u_6 = require(v2.Database.Security.Remotes)
local v_u_7 = require(v2.Shared.Promise)
local v_u_8 = {}
local v_u_9 = {}
local function v_u_15(p10)
    local v11 = {}
    local v12 = ""
    for v13, v14 in ipairs(p10) do
        if v13 <= 1 then
            v12 = v14
        elseif v13 > 1 then
            v12 = ("%*.%*"):format(v12, v14)
        end
        table.insert(v11, v12)
    end
    return v11
end
local function v_u_24(p16, p17)
    local v18 = v_u_15(p17)
    for _, v19 in ipairs(v18) do
        local v20 = v_u_9[p16]
        if v20 then
            local v21 = v20[v19]
            if v21 then
                local v22 = v_u_1.Get(p16, v19)
                for _, v23 in pairs(v21) do
                    v_u_7.try(v23, v22)
                end
            end
        end
    end
end
local function v_u_38(p_u_25)
    local v26, v_u_27 = pcall(function()
        return v_u_3:JSONEncode(p_u_25)
    end)
    if not (v26 and v_u_27) then
        return p_u_25
    end
    local v28, v29 = pcall(function()
        return v_u_3:JSONDecode(v_u_27)
    end)
    if not (v28 and v29) then
        return p_u_25
    end
    for _, v30 in ipairs({ "Serial", "Pattern" }) do
        if v29[v30] ~= nil then
            local v31 = v29[v30]
            if typeof(v31) == "string" then
                local v32 = v29[v30]
                v29[v30] = tonumber(v32) or v29[v30]
            end
        end
    end
    if v29.MetaData then
        local v33 = v29.MetaData
        if typeof(v33) == "table" then
            for _, v34 in ipairs({
                "LastTradeAt",
                "CreatedAt",
                "OriginalOwner",
                "Owner"
            }) do
                if v29.MetaData[v34] ~= nil then
                    local v35 = v29.MetaData[v34]
                    if typeof(v35) == "string" then
                        local v36 = v29.MetaData
                        local v37 = v29.MetaData[v34]
                        v36[v34] = tonumber(v37) or v29.MetaData[v34]
                    end
                end
            end
        end
    end
    return v29
end
local function v_u_52(p39, p40, p41)
    local v42 = v_u_8[p39]
    if v42 and v42.Inventory then
        local v43 = false
        if p41 then
            local v44 = {}
            for _, v45 in ipairs(p41) do
                v44[v45] = true
            end
            for v46 = #v42.Inventory, 1, -1 do
                local v47 = v42.Inventory[v46]
                if v47 and (v47._id and v44[v47._id]) then
                    table.remove(v42.Inventory, v46)
                    v43 = true
                end
            end
        end
        local v48 = {}
        for _, v49 in ipairs(v42.Inventory) do
            if v49 and v49._id then
                v48[v49._id] = true
            end
        end
        for _, v50 in ipairs(p40) do
            if v50 and (v50._id and not v48[v50._id]) then
                local v51 = v42.Inventory
                table.insert(v51, v50)
                v48[v50._id] = true
                v43 = true
            end
        end
        if v43 then
            v_u_24(p39, { "Inventory" })
        end
    end
end
function v_u_1.WaitForDataLoaded(p53)
    local v54 = 0
    while not v_u_8[p53] do
        v54 = v54 + task.wait()
        if v54 >= 60 then
            error((("[DataController] Failed to load player profile for %* after 5 seconds"):format(p53.Name)))
        end
    end
    return v_u_8[p53]
end
function v_u_1.Get(p55, ...)
    local v56 = v_u_8[p55]
    if not v56 then
        return nil
    end
    local v57 = {}
    for _, v58 in table.pack(...) do
        local v59 = v56
        for _, v60 in string.split(v58, ".") do
            v56 = v56[v60]
            if not v56 then
                break
            end
        end
        table.insert(v57, v56)
        v56 = v59
    end
    return table.unpack(v57)
end
function v_u_1.ApplyInventoryDelta(p61, p62, p63)
    v_u_52(p61, p62, p63)
end
function v_u_1.RemoveListener(p64, p65, p66)
    if v_u_9[p64] and v_u_9[p64][p65] then
        v_u_9[p64][p65][p66] = nil
        if next(v_u_9[p64][p65]) == nil then
            v_u_9[p64][p65] = nil
        end
    end
end
function v_u_1.CreateListener(p67, p68, p69)
    local v70 = v_u_3:GenerateGUID(false)
    v_u_9[p67] = v_u_9[p67] or {}
    v_u_9[p67][p68] = v_u_9[p67][p68] or {}
    v_u_9[p67][p68][v70] = p69
    local v71 = v_u_1.Get(p67, p68)
    if v71 ~= nil then
        v_u_7.try(p69, v71)
    end
    return v70
end
function v_u_1.Initialize()
    v_u_6.PlayerData.PlayerDataEvent.Listen(function(p72)
        local v73 = v_u_9[p72.Player]
        if p72.Data and p72.Data.Inventory then
            v_u_5.InjectStockItems(p72.Data.Inventory)
        end
        v_u_8[p72.Player] = p72.Data
        if v73 then
            for v74, v75 in pairs(v73) do
                local v76 = v_u_1.Get(p72.Player, v74)
                for _, v77 in pairs(v75) do
                    v_u_7.try(v77, v76)
                end
            end
        end
    end)
    v_u_6.PlayerData.PlayerDataChanged.Listen(function(p78)
        local v79 = p78.Player
        local v80 = v_u_8[v79]
        if v80 then
            for v81, v82 in pairs(p78.Data) do
                local v83 = string.split(v81, ".")
                local v84 = v80
                for v85 = 1, #v83 - 1 do
                    local v86 = v83[v85]
                    local v87 = v80[v86]
                    if typeof(v87) ~= "table" then
                        v80[v86] = {}
                    end
                    v80 = v80[v86]
                end
                v80[v83[#v83]] = v82
                v_u_24(v79, v83)
                v80 = v84
            end
        else
            warn((("[DataController] Received data change for %* but profile not loaded yet. Requesting full profile."):format(v79.Name)))
        end
    end)
end
function v_u_1.Start()
    v_u_6.PlayerData.RetrieveAllPlayerData.Send()
    v_u_6.Store.NewInventoryItem.Listen(function(p88)
        local v89 = p88.Player
        local v90 = tonumber(v89)
        if v90 then
            local v91 = v_u_4:GetPlayerByUserId(v90)
            if v91 and v91:IsDescendantOf(v_u_4) then
                local v92 = {}
                for _, v93 in ipairs(p88.Items) do
                    local v94 = v_u_38(v93)
                    table.insert(v92, v94)
                end
                v_u_52(v91, v92, p88.DeletedItemIds)
            end
        else
            return
        end
    end)
    v_u_4.PlayerRemoving:Connect(function(p95)
        v_u_9[p95] = nil
        v_u_8[p95] = nil
    end)
end
return v_u_1