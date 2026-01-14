-- Decompiled with Bunni.lol Decompiler

local v_u_startergui = game:GetService("StarterGui")
local v_u1 = false
local v_u2 = {
	["setCameraModeToastEnabled"] = function(arg1)
		-- upvalues: (ref) v_u1, (copy) v_u2
		if arg1 or v_u1 then
			if not v_u1 then
				v_u1 = true
			end
			if not arg1 then
				v_u2.setCameraModeToastOpen(false)
			end
		end
	end,
	["setCameraModeToastOpen"] = function(arg1)
		-- upvalues: (ref) v_u1, (copy) v_u_startergui
		assert(v_u1)
		if arg1 then
			v_u_startergui:SetCore("SendNotification", {
				["Title"] = "Camera Control Enabled",
				["Text"] = "Right click to toggle",
				["Duration"] = 3
			})
		end
	end
}
return v_u2