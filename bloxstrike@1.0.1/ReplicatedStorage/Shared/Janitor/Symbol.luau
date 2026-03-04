return function(p_u_1)
    local v2 = newproxy(true)
    getmetatable(v2).__tostring = function()
        return p_u_1
    end
    return v2
end