return {
    ["parse"] = function(p1)
        local v_u_2 = string.split(p1, ".")
        if p1 == "" or #v_u_2 ~= 3 then
            return nil
        end
        local v3, v4 = pcall(function()
            if v_u_2[2] == "KeyCode" then
                return Enum.KeyCode[v_u_2[3]]
            elseif v_u_2[2] == "UserInputType" then
                return Enum.UserInputType[v_u_2[3]]
            elseif v_u_2[2] == "CustomInputType" and (v_u_2[3] == "ScrollWheelUp" or v_u_2[3] == "ScrollWheelDown") then
                return v_u_2[3]
            else
                return nil
            end
        end)
        return v3 and v4 and v4 or nil
    end
}