local v1 = table.freeze
local v2 = {
    ["Images"] = { "http://www.roblox.com/asset/?id=4784881970", "http://www.roblox.com/asset/?id=4784905666" },
    ["Properties"] = {
        ["Color3"] = Color3.fromRGB(255, 255, 255),
        ["Transparency"] = function()
            return math.random(0, 2) / 10
        end,
        ["Rotation"] = function()
            return math.random(0, 360)
        end,
        ["SizeRange"] = function()
            return math.random(6, 8) / 10
        end
    }
}
return v1(v2)