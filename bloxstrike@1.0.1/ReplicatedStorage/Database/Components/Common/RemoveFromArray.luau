game:GetService("ReplicatedStorage")
return function(p1, p2)
    local v3 = {}
    for v4 = 1, #p1 do
        if p2(v4, p1[v4]) then
            table.insert(v3, v4)
        end
    end
    table.sort(v3, function(p5, p6)
        return p6 < p5
    end)
    for _, v7 in ipairs(v3) do
        table.remove(p1, v7)
    end
    return p1
end