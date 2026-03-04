local v_u_1 = game:GetService("TextChatService")
return function(p_u_2)
    local v3, v4 = pcall(function()
        return v_u_1:CanUserChatAsync(p_u_2.UserId)
    end)
    if v3 then
        return v4
    end
    warn("[CanUserUseChat] Failed to check if user can use chat", v4)
    return false
end