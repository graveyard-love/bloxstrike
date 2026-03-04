local v1 = {
    ["GAMEPLAY_MOBILE_BUTTONS"] = {
        "Shoot",
        "Shop",
        "Reload",
        "Jump",
        "Crouch",
        "Aim",
        "Drop",
        "Interact",
        "Inspect",
        "SwapTeam",
        "Menu",
        "Ping"
    },
    ["SPECTATE_MOBILE_BUTTONS"] = { "SwapTeam", "Menu" },
    ["BUTTONS_WITH_EXPLICIT_INPUT_ENDED"] = {
        ["SwapTeam"] = true,
        ["Inspect"] = true,
        ["Crouch"] = true,
        ["Reload"] = true,
        ["Shop"] = true,
        ["Menu"] = true,
        ["Drop"] = true,
        ["Ping"] = true
    },
    ["BUTTONS_EXCLUDED_FROM_CLEARING"] = {
        ["SwapTeam"] = true,
        ["Interact"] = true,
        ["Inspect"] = true,
        ["Crouch"] = true,
        ["Reload"] = true,
        ["Menu"] = true,
        ["Shop"] = true,
        ["Ping"] = true
    },
    ["BUTTONS_WITH_EXPLICIT_HANDLERS"] = {
        ["SwapTeam"] = true,
        ["Inspect"] = true,
        ["Crouch"] = true,
        ["Reload"] = true,
        ["Jump"] = true,
        ["Shop"] = true,
        ["Menu"] = true,
        ["Ping"] = true
    }
}
return v1