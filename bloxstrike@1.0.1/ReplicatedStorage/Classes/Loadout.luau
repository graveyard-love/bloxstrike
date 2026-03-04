local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetWeaponProperties)
local v_u_7 = require(v2.Database.Custom.GameStats.NumberSlots)
local v8 = require(v2.Components.Grenade)
local v9 = require(v2.Components.Weapon)
local v10 = require(v2.Components.Melee)
local v11 = require(v2.Components.C4)
local v_u_12 = require(v2.Shared.Janitor)
local v_u_13 = {
    ["Grenade"] = v8,
    ["Weapon"] = v9,
    ["Melee"] = v10,
    ["C4"] = v11
}
function v_u_1.setCurrentEquipped(p14, p15)
    p14.PreviousEquipped = p14.CurrentEquipped
    p14.CurrentEquipped = p15
end
function v_u_1.getNextInventorySlotFromPriority(p16)
    local v17 = -1
    local v18 = nil
    for v19, v20 in ipairs(p16.Inventory) do
        if #v20._items >= 1 then
            local v21 = v_u_7.Priorities[v19] or 0
            if v17 < v21 then
                v18 = v19
                v17 = v21
            end
        end
    end
    return v18
end
function v_u_1.getInventoryItemFromLoadout(p22, p23)
    local v24 = nil
    local v25 = nil
    local v26 = nil
    for v27, v28 in ipairs(p22.Inventory) do
        local v29 = v28._items
        for v30, v31 in ipairs(v29) do
            if v31.Identifier == p23 then
                v26 = v30
                v25 = v27
                v24 = v31
                break
            end
        end
    end
    return v24, v25, v26
end
function v_u_1.removeInventoryItem(p32, p33)
    local v34, v35, v36 = p32:getInventoryItemFromLoadout(p33)
    local v37 = v34 and p32.Inventory[v35]
    if v37 then
        table.remove(v37._items, v36)
        if p32.CurrentEquipped == v34 then
            p32:setCurrentEquipped(nil)
        end
        v34:destroy()
    end
end
function v_u_1.grantPlayerInventoryItem(p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50)
    local v51 = p38.Inventory[p39]
    local v52 = ("%* does not exist in player inventory"):format(p39)
    assert(v51, v52)
    local v53 = v_u_6(p42)
    local v54 = ("Client couldn\'t find weapon properties for \"%*\""):format(p42)
    assert(v53, v54)
    local v55 = v_u_13[v53.Class]
    local v56 = ("Client couldn\'t find weapon component for \"%*\""):format(p42)
    assert(v55, v56)
    local v_u_57 = v55.new(v_u_5, p40, p41, p39, p42, p43, p44, p45, p46, p47, p48, p49, p50)
    local v58 = v51._items
    table.insert(v58, v_u_57)
    p38.Janitor:Add(function()
        if v_u_57 then
            local v59 = v_u_57
            if getmetatable(v59) and not v_u_57.IsDestroyed then
                v_u_57:destroy()
            end
        end
    end)
end
function v_u_1.new(p60)
    local v61 = v_u_1
    local v_u_62 = setmetatable({}, v61)
    v_u_62.Janitor = v_u_12.new()
    v_u_62.IsDestroyed = false
    v_u_62.Inventory = p60
    v_u_62.PreviousEquipped = nil
    v_u_62.CurrentEquipped = nil
    v_u_62.Janitor:Add(v_u_3.RenderStepped:Connect(function(p63)
        if v_u_62.IsDestroyed then
            return
        else
            local v64 = v_u_5.Character
            if not (v64 and v64:GetAttribute("Dead")) then
                if v_u_62.CurrentEquipped then
                    v_u_62.CurrentEquipped.Viewmodel:render(p63)
                end
            end
        end
    end))
    return v_u_62
end
function v_u_1.destroy(p65)
    if not p65.IsDestroyed then
        p65.IsDestroyed = true
        if p65.CurrentEquipped then
            if p65.CurrentEquipped.unequip then
                p65.CurrentEquipped:unequip()
            end
            if p65.CurrentEquipped.destroy and not p65.CurrentEquipped.IsDestroyed then
                p65.CurrentEquipped:destroy()
            end
            p65.CurrentEquipped = nil
        end
        if p65.PreviousEquipped then
            if p65.PreviousEquipped.destroy and not p65.PreviousEquipped.IsDestroyed then
                p65.PreviousEquipped:destroy()
            end
            p65.PreviousEquipped = nil
        end
        if p65.Inventory then
            for _, v66 in ipairs(p65.Inventory) do
                if v66 and v66._items then
                    table.clear(v66._items)
                end
            end
        end
        p65.Janitor:Destroy()
        p65.Janitor = nil
        p65.Inventory = nil
    end
end
return v_u_1