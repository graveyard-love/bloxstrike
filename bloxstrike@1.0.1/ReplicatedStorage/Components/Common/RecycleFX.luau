local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = workspace:WaitForChild("Debris")
local v_u_3 = require(v1.Shared.DebugFlags)
return function()
    local v4 = 0
    local v5 = 0
    for _, v6 in ipairs(v_u_2:GetChildren()) do
        if not v6:IsA("Folder") then
            local v7
            if v6:GetAttribute("PersistentDebris") == true then
                v7 = true
            else
                local v8 = v6.Name
                v7 = string.sub(v8, -7) == "_Weapon" and true or string.find(v6.Name, "_WeaponAttachments", 1, true) ~= nil
            end
            if v7 then
                v4 = v4 + 1
            else
                v5 = v5 + 1
                v6:Destroy()
            end
        end
    end
    if v_u_3.IsEnabled("DebrisCleanup") then
        warn(("[DebrisCleanup][Client] CleanupDebris received: destroyed=%d skipped=%d"):format(v5, v4))
    end
end