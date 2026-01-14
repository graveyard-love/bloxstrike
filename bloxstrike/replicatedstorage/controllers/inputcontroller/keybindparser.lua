-- Decompiled with Bunni.lol Decompiler

return {
	["parse"] = function(arg1)
		local v_u_split = string.split(arg1, ".")
		if arg1 == "" or #v_u_split ~= 3 then
			return nil
		end
		local v1, v2 = pcall(function()
			-- upvalues: (copy) v_u_split
			if v_u_split[2] == "KeyCode" then
				return Enum.KeyCode[v_u_split[3]]
			elseif v_u_split[2] == "UserInputType" then
				return Enum.UserInputType[v_u_split[3]]
			elseif v_u_split[2] == "CustomInputType" and (v_u_split[3] == "ScrollWheelUp" or v_u_split[3] == "ScrollWheelDown") then
				return v_u_split[3]
			else
				return nil
			end
		end)
		return v1 and v2 and v2 or nil
	end
}