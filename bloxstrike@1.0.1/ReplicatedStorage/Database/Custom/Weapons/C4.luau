local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
return table.freeze({
    ["Droppable"] = true,
    ["Slot"] = "C4",
    ["Class"] = "C4",
    ["Team"] = "Terrorists",
    ["Type"] = "Miscellaneous",
    ["ReverseIcon"] = "rbxassetid://109858795365969",
    ["Icon"] = "rbxassetid://109858795365969",
    ["Range"] = 1200,
    ["WalkSpeed"] = 20.2,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.C4.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.C4.CameraAnimations,
    ["RagdollMultiplier"] = 35,
    ["ShowCrosshair"] = false
})