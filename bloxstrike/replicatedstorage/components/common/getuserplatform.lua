-- Decompiled with Bunni.lol Decompiler

local v_u_userinput = game:GetService("UserInputService")
return function()
	-- upvalues: (copy) v_u_userinput
	local v1 = {}
	if v_u_userinput.GamepadEnabled then
		table.insert(v1, "Console")
	end
	if v_u_userinput.VREnabled then
		table.insert(v1, "VR")
	end
	if v_u_userinput.MouseEnabled or v_u_userinput.KeyboardEnabled then
		table.insert(v1, "PC")
	end
	if v_u_userinput.TouchEnabled and not table.find(v1, "PC") then
		table.insert(v1, "Mobile")
	end
	return v1
end