local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
require(script.Parent.Types)
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v2.Controllers.DataController)
local v_u_6 = require(v2.Database.Security.Remotes)
local v_u_7 = require(v2.Database.Security.Router)
local v_u_8 = require(v2.Interface.MenuState)
local v_u_9 = nil
local v_u_10 = nil
v_u_1.ActionType = "AttachCharm"
local function v_u_15(p11, _)
    if p11.Type ~= "Weapon" then
        return false
    end
    local v12
    if p11.Charm == nil or p11.Charm == false then
        v12 = false
    else
        local v13 = p11.Charm
        if type(v13) == "string" or p11.Charm == true then
            v12 = true
        else
            local v14 = p11.Charm
            v12 = type(v14) == "table"
        end
    end
    return not v12
end
local function v_u_22(p16, _)
    if p16.Type ~= "Charm" then
        return false
    end
    local v17 = v_u_5.Get(v_u_4, "Inventory")
    if v17 then
        for _, v18 in ipairs(v17) do
            if v18.Charm then
                local v19 = v18.Charm
                local v20 = type(v19) == "table" and v18.Charm._id
                if not v20 then
                    local v21 = v18.Charm
                    if type(v21) == "string" then
                        v20 = v18.Charm
                    else
                        v20 = false
                    end
                end
                if v20 == p16._id then
                    return false
                end
            end
        end
    end
    return true
end
function v_u_1.GetFilter(p23)
    if p23.Type == "Weapon" then
        return v_u_22
    else
        return p23.Type ~= "Charm" and function()
            return false
        end or v_u_15
    end
end
function v_u_1.GetContext(p24)
    local v25 = p24.Type == "Charm" and "Select Weapon" or "Select Charm"
    return {
        ["ActionType"] = v_u_1.ActionType,
        ["SourceItem"] = p24,
        ["Title"] = v25
    }
end
function v_u_1.OnItemSelected(p26, p27)
    if p27.SourceItem then
        local v28 = p27.SourceItem
        local v29, v30
        if v28.Type == "Weapon" then
            v29 = v28._id
            v30 = p26._id
            p26 = v28
        else
            if v28.Type ~= "Charm" then
                return
            end
            v29 = p26._id
            v30 = v28._id
        end
        v_u_9 = {
            ["WeaponId"] = v29,
            ["CharmId"] = v30,
            ["WeaponItem"] = p26
        }
        v_u_7.broadcastRouter("WeaponInspect", p26.Name, p26.Skin, p26.Float, p26.StatTrack, p26.NameTag, {
            ["_id"] = v30,
            ["Position"] = "1"
        }, p26.Stickers, p26.Type, p26.Pattern, p26._id, p26.Serial, p26.IsTradeable)
    end
end
function v_u_1.OnCancelled(_)
    v_u_9 = nil
end
function v_u_1.ConfirmAttachment()
    if not v_u_9 then
        return false
    end
    local v31 = v_u_7.broadcastRouter("GetCurrentCharmPosition") or 1
    v_u_6.Inventory.UpdateWeaponCharm.Send({
        ["WeaponId"] = v_u_9.WeaponId,
        ["CharmId"] = v_u_9.CharmId,
        ["Position"] = tostring(v31)
    })
    v_u_9 = nil
    v_u_7.broadcastRouter("WeaponInspectClose")
    return true
end
function v_u_1.CancelAttachment()
    if not v_u_9 then
        return false
    end
    v_u_9 = nil
    v_u_7.broadcastRouter("WeaponInspectClose")
    return true
end
function v_u_1.HasPendingAttachment()
    return v_u_9 ~= nil
end
function v_u_1.Initialize()
    v_u_10 = v_u_8.OnInspectStateChanged:Connect(function(p32)
        if not p32 and v_u_9 then
            v_u_9 = nil
        end
    end)
    v_u_7.observerRouter("ConfirmCharmAttachment", function()
        return v_u_1.ConfirmAttachment()
    end)
    v_u_7.observerRouter("HasPendingCharmAttachment", function()
        return v_u_1.HasPendingAttachment()
    end)
    v_u_7.observerRouter("CancelCharmAttachment", function()
        return v_u_1.CancelAttachment()
    end)
end
function v_u_1.Destroy()
    if v_u_10 then
        v_u_10:Disconnect()
        v_u_10 = nil
    end
    v_u_9 = nil
end
return v_u_1