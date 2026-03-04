local v1 = {}
local v_u_2 = {}
local v3 = {
    ["AssetFolder"] = "CaseScene",
    ["InteractionType"] = "Click",
    ["Animations"] = {
        ["CaseFall"] = "rbxassetid://91366765923171",
        ["CloseIdle"] = "rbxassetid://96896409518629",
        ["CaseOpening"] = "rbxassetid://100000665946048",
        ["OpenIdle"] = "rbxassetid://127592440292292"
    },
    ["Sounds"] = {
        ["Drop"] = "Case Fall",
        ["Opening"] = "Case Opening"
    }
}
v_u_2.Default = v3
local v4 = {
    ["AssetFolder"] = "CharmScene",
    ["InteractionType"] = "Drag",
    ["Animations"] = {
        ["PackOpening"] = "rbxassetid://97837283629886"
    },
    ["DragSettings"] = {
        ["Threshold"] = 0.5,
        ["EndKeyframe"] = "DragEndPoint"
    },
    ["Sounds"] = {
        ["DragStart"] = "Charm Drag Start",
        ["DragLoop"] = "Charm Drag Loop"
    }
}
v_u_2.CharmCapsule = v4
local v5 = {
    ["AssetFolder"] = "PackageScene",
    ["InteractionType"] = "Click",
    ["Animations"] = {
        ["CaseFall"] = "rbxassetid://134599478765866",
        ["CloseIdle"] = "rbxassetid://119593507010060",
        ["CaseOpening"] = "rbxassetid://97681949800792"
    }
}
local v6 = {
    ["CaseFall"] = {
        ["Drop"] = "Package Drop"
    },
    ["CaseOpening"] = {
        ["RightTape"] = "Package Right Tape",
        ["LeftTape"] = "Package Left Tape",
        ["FrontLid"] = "Package Front Lid",
        ["FinalOpen"] = "Package Final Open"
    }
}
v5.AnimationKeyframeSounds = v6
v_u_2.Package = v5
local v_u_7 = {
    ["Case"] = "Default",
    ["Sticker Capsule"] = "Default",
    ["Charm Capsule"] = "CharmCapsule",
    ["Package"] = "Package"
}
function v1.GetSceneForCaseType(p8)
    return v_u_7[p8] or "Default"
end
function v1.GetConfig(p9)
    return v_u_2[p9]
end
function v1.GetAllSceneNames()
    local v10 = {}
    for v11 in v_u_2 do
        table.insert(v10, v11)
    end
    return v10
end
function v1.RegisterScene(p12, p13)
    v_u_2[p12] = p13
end
function v1.RegisterCaseTypeMapping(p14, p15)
    v_u_7[p14] = p15
end
return v1