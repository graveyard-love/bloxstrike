local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Database.Security.Router)
local v_u_4 = require(v2.Shared.CloseButtonRegistry)
local v_u_5 = require(v2.Database.Security.Remotes)
local v_u_6 = nil
function v_u_1.CreateNotification(p7, p8)
    v_u_3.broadcastRouter("RunInterfaceSound", "Notification " .. p7)
    v_u_6.TextLabel.Text = p8
    v_u_6.Visible = true
end
function v_u_1.CloseNotification()
    v_u_6.Visible = false
end
function v_u_1.Initialize(_, p9)
    v_u_6 = p9
    v_u_4.Add(v_u_6, v_u_6.Footer.Close, function()
        v_u_1.CloseNotification()
    end)
    v_u_3.observerRouter("CreateMenuNotification", function(p10, p11)
        v_u_1.CreateNotification(p10, p11)
        return nil
    end)
    v_u_5.UI.CreateMenuNotification.Listen(function(p12, _)
        v_u_1.CreateNotification(p12.notificationType, p12.text)
    end)
end
return v_u_1