-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["Icon"] = "rbxassetid://137681093106042",
	["Gamemode"] = {
		["Deathmatch"] = "Deathmatch",
		["Competitive"] = false,
		["Casual"] = false
	},
	["Characters"] = {
		["Counter-Terrorists"] = "IDF",
		["Terrorists"] = "Anarchist"
	},
	["Lighting"] = {
		["Properties"] = require(script:WaitForChild("Properties")),
		["Assets"] = v_replicatedstorage.Assets.Lighting.Dizzy
	}
}
local v2 = {
	["Position"] = Vector3.new(0, 0, 0),
	["Terrain"] = nil,
	["Resolution"] = 0
}
local v3 = {
	["WaterColor"] = Color3.fromRGB(12, 84, 92),
	["WaterTransparency"] = 0.3,
	["WaterReflectance"] = 1,
	["WaterWaveSpeed"] = 10,
	["WaterWaveSize"] = 0.15,
	["Decoration"] = true,
	["MaterialColors"] = {
		["WoodPlanks"] = Color3.fromRGB(172, 148, 108),
		["Slate"] = Color3.fromRGB(88, 89, 86),
		["Concrete"] = Color3.fromRGB(152, 152, 152),
		["Brick"] = Color3.fromRGB(138, 97, 73),
		["Cobblestone"] = Color3.fromRGB(134, 134, 118),
		["Rock"] = Color3.fromRGB(99, 100, 102),
		["Sandstone"] = Color3.fromRGB(148, 124, 95),
		["Basalt"] = Color3.fromRGB(75, 74, 74),
		["CrackedLava"] = Color3.fromRGB(255, 24, 67),
		["Limestone"] = Color3.fromRGB(255, 243, 192),
		["Pavement"] = Color3.fromRGB(143, 144, 135),
		["Grass"] = Color3.fromRGB(111, 126, 62),
		["LeafyGrass"] = Color3.fromRGB(106, 134, 64),
		["Sand"] = Color3.fromRGB(207, 203, 167),
		["Snow"] = Color3.fromRGB(235, 253, 255),
		["Mud"] = Color3.fromRGB(121, 112, 98),
		["Ground"] = Color3.fromRGB(140, 130, 104),
		["Asphalt"] = Color3.fromRGB(80, 84, 84),
		["Salt"] = Color3.fromRGB(255, 255, 254),
		["Ice"] = Color3.fromRGB(204, 210, 223),
		["Glacier"] = Color3.fromRGB(221, 228, 229)
	}
}
v2.Properties = v3
v1.Terrain = v2
return table.freeze(v1)