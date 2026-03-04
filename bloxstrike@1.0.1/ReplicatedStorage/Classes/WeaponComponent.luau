local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Database.Components.Libraries.Skins)
local v_u_4 = require(v2.Components.Common.GetWeaponProperties)
local v_u_5 = require(v2.Shared.Janitor)
local v_u_6 = require(script.Classes.CharacterAnimator)
local v_u_7 = require(script.Classes.Viewmodel)
function v1.new(p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19)
    local v_u_20 = {
        ["Janitor"] = v_u_5.new(),
        ["IsDestroyed"] = false,
        ["OriginalOwner"] = p17,
        ["Identifier"] = p9,
        ["StatTrack"] = p15,
        ["Stickers"] = p19,
        ["NameTag"] = p16,
        ["Player"] = p8,
        ["Float"] = p14,
        ["Name"] = p12,
        ["Charm"] = p18,
        ["Skin"] = p13,
        ["Slot"] = p11,
        ["_id"] = p10,
        ["Properties"] = v_u_4(p12)
    }
    v_u_20.CharacterAnimator = v_u_6.new(v_u_20.Player, p12)
    debug.profilebegin("WeaponComponent.new.Viewmodel")
    v_u_20.Viewmodel = v_u_7.new(v_u_20, p12, p13)
    debug.profileend()
    v_u_20.Janitor:Add(function()
        if v_u_20.CharacterAnimator then
            v_u_20.CharacterAnimator:destroy()
            v_u_20.CharacterAnimator = nil
        end
    end)
    v_u_20.Janitor:Add(function()
        if v_u_20.Viewmodel then
            v_u_20.Viewmodel:destroy()
            v_u_20.Viewmodel = nil
        end
    end)
    function v_u_20.updateStatTrackCounter(p21, p22)
        p21.StatTrack = p22
        local v23 = p21.StatTrack and p21.Viewmodel.Model:FindFirstChild("KillTrak", true)
        if v23 then
            v23.Screen.SurfaceGui.TextLabel.Text = v_u_3.GetKillTrackValue(p22, p21.Name)
        end
    end
    return v_u_20
end
function v1.destroy(p24)
    if p24.CharacterAnimator then
        p24.CharacterAnimator:destroy()
        p24.CharacterAnimator = nil
    end
    if p24.Viewmodel then
        p24.Viewmodel:destroy()
        p24.Viewmodel = nil
    end
    if p24.Janitor then
        p24.Janitor:Destroy()
        p24.Janitor = nil
    end
    p24.updateStatTrackCounter = nil
    p24.OriginalOwner = nil
    p24.Properties = nil
    p24.Identifier = nil
    p24.StatTrack = nil
    p24.Stickers = nil
    p24.NameTag = nil
    p24.Player = nil
    p24.Float = nil
    p24.Name = nil
    p24.Charm = nil
    p24.Skin = nil
    p24.Slot = nil
    p24._id = nil
end
return v1