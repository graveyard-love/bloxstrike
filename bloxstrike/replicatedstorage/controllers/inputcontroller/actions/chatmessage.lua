-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u1 = nil
return table.freeze({
	["Name"] = "Chat Message",
	["Group"] = "Default",
	["Category"] = "Communication Options",
	["Callback"] = function(arg1, _)
		-- upvalues: (ref) v_u1, (copy) v_u_replicatedstorage
		if arg1 == Enum.UserInputState.Begin then
			if not v_u1 then
				v_u1 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.Chat)
			end
			v_u1.OpenChat(1)
		end
	end
})