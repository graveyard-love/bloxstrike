local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(v1.Database.Custom.Constants)
local v_u_4 = require(v1.Database.Security.Router)
local v_u_5 = v2:IsServer()
local v51 = {
    ["+ 400 Credits"] = {
        ["DevProductId"] = 3543515479,
        ["OnPurchased"] = function(p6)
            local v7 = v_u_5
            assert(v7, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p6, 400)
        end
    },
    ["+ 950 Credits"] = {
        ["DevProductId"] = 3543515926,
        ["OnPurchased"] = function(p8)
            local v9 = v_u_5
            assert(v9, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p8, 950)
        end
    },
    ["+ 3,100 Credits"] = {
        ["DevProductId"] = 3543516192,
        ["OnPurchased"] = function(p10)
            local v11 = v_u_5
            assert(v11, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p10, 3100)
        end
    },
    ["+ 6,500 Credits"] = {
        ["DevProductId"] = 3543516540,
        ["OnPurchased"] = function(p12)
            local v13 = v_u_5
            assert(v13, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p12, 6500)
        end
    },
    ["+ 13,250 Credits"] = {
        ["DevProductId"] = 3543516770,
        ["OnPurchased"] = function(p14)
            local v15 = v_u_5
            assert(v15, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p14, 13250)
        end
    },
    ["+ 27,000 Credits"] = {
        ["DevProductId"] = 3543517001,
        ["OnPurchased"] = function(p16)
            local v17 = v_u_5
            assert(v17, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p16, 27000)
        end
    },
    ["+ 67,500 Credits"] = {
        ["DevProductId"] = 3543517199,
        ["OnPurchased"] = function(p18)
            local v19 = v_u_5
            assert(v19, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Credits Purchased", p18, 67500)
        end
    },
    ["Gift + 400 Credits"] = {
        ["DevProductId"] = 3543518894,
        ["OnPurchased"] = function(p20)
            local v21 = v_u_5
            assert(v21, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p20, 400)
        end
    },
    ["Gift + 950 Credits"] = {
        ["DevProductId"] = 3543519307,
        ["OnPurchased"] = function(p22)
            local v23 = v_u_5
            assert(v23, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p22, 950)
        end
    },
    ["Gift + 3,100 Credits"] = {
        ["DevProductId"] = 3543519553,
        ["OnPurchased"] = function(p24)
            local v25 = v_u_5
            assert(v25, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p24, 3100)
        end
    },
    ["Gift + 6,500 Credits"] = {
        ["DevProductId"] = 3543519769,
        ["OnPurchased"] = function(p26)
            local v27 = v_u_5
            assert(v27, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p26, 6500)
        end
    },
    ["Gift + 13,250 Credits"] = {
        ["DevProductId"] = 3543520414,
        ["OnPurchased"] = function(p28)
            local v29 = v_u_5
            assert(v29, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p28, 13250)
        end
    },
    ["Gift + 27,000 Credits"] = {
        ["DevProductId"] = 3543520614,
        ["OnPurchased"] = function(p30)
            local v31 = v_u_5
            assert(v31, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Credits", p30, 27000)
        end
    },
    ["Gift + 67,500 Credits"] = {
        ["DevProductId"] = 3543520837,
        ["OnPurchased"] = function(p32)
            local v33 = v_u_5
            assert(v33, "This function should only be called in studio.")
            local v34 = (require(game:GetService("ServerScriptService").Services.DataService).Get(p32, "Statistics.RobuxSpent") or 0) >= v_u_3.MINIMUM_CREDITS_FOR_SPECIAL_CREDITS_OPTION
            assert(v34, "Player has not met the minimum spending requirement.")
            return v_u_4.broadcastRouter("Gift Credits", p32, 67500)
        end
    },
    ["Purchase Featured Bundle"] = {
        ["DevProductId"] = 3535992020,
        ["OnPurchased"] = function(p35)
            local v36 = v_u_5
            assert(v36, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Bundle", p35)
        end
    },
    ["AWP | High Octane"] = {
        ["DevProductId"] = 3535995013,
        ["OnPurchased"] = function(p37)
            local v38 = v_u_5
            assert(v38, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p37, "AWP | High Octane")
        end
    },
    ["Desert Eagle | High Octane"] = {
        ["DevProductId"] = 3535993503,
        ["OnPurchased"] = function(p39)
            local v40 = v_u_5
            assert(v40, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p39, "Desert Eagle | High Octane")
        end
    },
    ["MP9 | High Octane"] = {
        ["DevProductId"] = 3535993672,
        ["OnPurchased"] = function(p41)
            local v42 = v_u_5
            assert(v42, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Purchase Featured Package", p41, "MP9 | High Octane")
        end
    },
    ["Gift Featured Bundle"] = {
        ["DevProductId"] = 3535995856,
        ["OnPurchased"] = function(p43)
            local v44 = v_u_5
            assert(v44, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Bundle", p43)
        end
    },
    ["Gift AWP | High Octane"] = {
        ["DevProductId"] = 3535995438,
        ["OnPurchased"] = function(p45)
            local v46 = v_u_5
            assert(v46, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p45, "AWP | High Octane")
        end
    },
    ["Gift Desert Eagle | High Octane"] = {
        ["DevProductId"] = 3535995262,
        ["OnPurchased"] = function(p47)
            local v48 = v_u_5
            assert(v48, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p47, "Desert Eagle | High Octane")
        end
    },
    ["Gift MP9 | High Octane"] = {
        ["DevProductId"] = 3535995640,
        ["OnPurchased"] = function(p49)
            local v50 = v_u_5
            assert(v50, "This function should only be called in studio.")
            return v_u_4.broadcastRouter("Gift Featured Package", p49, "MP9 | High Octane")
        end
    }
}
return table.freeze(v51)