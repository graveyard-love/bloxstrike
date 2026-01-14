-- Decompiled with Bunni.lol Decompiler

local v_u_textchat = game:GetService("TextChatService")
return function(self)
	-- upvalues: (copy) v_u_textchat
	local v1, v2 = pcall(function()
		-- upvalues: (ref) v_u_textchat, (copy) self
		return v_u_textchat:CanUserChatAsync(self.UserId)
	end)
	if v1 then
		return v2
	end
	warn("[CanUserUseChat] Failed to check if user can use chat", v2)
	return false
end