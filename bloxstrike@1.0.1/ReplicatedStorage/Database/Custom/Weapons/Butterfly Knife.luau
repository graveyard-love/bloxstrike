local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["Droppable"] = false,
    ["Automatic"] = true,
    ["Team"] = "Both",
    ["Type"] = "Equipment",
    ["Class"] = "Melee",
    ["Slot"] = "Melee",
    ["ReverseIcon"] = "rbxassetid://119105180712017",
    ["Icon"] = "rbxassetid://78088217065173",
    ["FireRate"] = 0.36,
    ["Range"] = 3,
    ["ArmorPenetration"] = 0.9,
    ["WalkSpeed"] = 20.2,
    ["RagdollMultiplier"] = 35,
    ["DamagePerPart"] = {
        ["Torso"] = 41,
        ["Head"] = 48,
        ["Arms"] = 31,
        ["Legs"] = 28
    },
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Butterfly Knife"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Butterfly Knife"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v2(v3)