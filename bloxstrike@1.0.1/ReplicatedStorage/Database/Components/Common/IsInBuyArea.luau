local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
require(v2.Database.Custom.Types)
return function(p3)
    local v4 = p3:GetAttribute("Team")
    local v5 = p3.Character
    if v5 and v5:IsDescendantOf(workspace) then
        local v6 = v_u_1:GetTagged("BuyArea")
        for _, v7 in ipairs(v6) do
            local v8 = v5.PrimaryPart
            if not v8 then
                return false
            end
            if v7:GetAttribute("Team") == v4 and v7:IsDescendantOf(workspace) then
                local v9 = v8.Position
                local v10 = v7.CFrame
                local v11 = v7.Size
                local v12 = v10:PointToObjectSpace(v9)
                local v13 = v12.X
                local v14
                if math.abs(v13) <= v11.X / 2 then
                    local v15 = v12.Y
                    if math.abs(v15) <= v11.Y / 2 then
                        local v16 = v12.Z
                        v14 = math.abs(v16) <= v11.Z / 2
                    else
                        v14 = false
                    end
                else
                    v14 = false
                end
                if v14 then
                    return true
                end
            end
        end
    end
    return workspace:GetAttribute("Gamemode") == "Deathmatch"
end