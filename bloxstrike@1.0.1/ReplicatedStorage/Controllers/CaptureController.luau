local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CaptureService")
function v1.CaptureScreenshot(p_u_4)
    return require(v_u_2.Shared.Promise).new(function(p_u_5, p6)
        local v8, v9 = pcall(function()
            v_u_3:CaptureScreenshot(function(p7)
                if p_u_4 then
                    p_u_4(p7)
                end
                p_u_5(p7)
            end)
        end)
        if not v8 then
            p6(v9)
        end
    end)
end
return v1