local v_u_1 = table.freeze({
    ["Lebron James"] = "LeGoat",
    ["Medal.tv"] = "Medal"
})
return function(p2)
    return v_u_1[p2] or p2
end