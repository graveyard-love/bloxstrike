-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["Stock"] = {
		["Color"] = Color3.fromRGB(195, 195, 195),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(195, 195, 195)), ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 195, 195)) })
	},
	["Blue"] = {
		["Color"] = Color3.fromRGB(75, 106, 255),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 106, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 106, 255)) })
	},
	["Purple"] = {
		["Color"] = Color3.fromRGB(136, 71, 255),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 71, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 71, 255)) })
	},
	["Pink"] = {
		["Color"] = Color3.fromRGB(211, 44, 230),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(211, 44, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 44, 230)) })
	},
	["Red"] = {
		["Color"] = Color3.fromRGB(235, 75, 75),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 75, 75)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 75, 75)) })
	},
	["Special"] = {
		["Color"] = Color3.fromRGB(255, 215, 0),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0)) })
	},
	["Forbidden"] = {
		["Color"] = Color3.fromRGB(65, 15, 18),
		["ColorSequence"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 15, 18)), ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 6, 7)) })
	}
}
return table.freeze(v1)