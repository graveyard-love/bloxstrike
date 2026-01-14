-- Decompiled with Bunni.lol Decompiler

local v1 = {
	["Images"] = { "rbxassetid://88027686092020" },
	["Properties"] = {
		["Color3"] = Color3.fromRGB(56, 56, 56),
		["Transparency"] = function()
			return math.random(0, 4) / 10
		end,
		["Rotation"] = function()
			return math.random(-20, 20)
		end,
		["SizeRange"] = function()
			return math.random(10, 12) / 10
		end
	}
}
return table.freeze(v1)