-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_debris = game:GetService("Debris")
local v_u_tracers = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("Tracers")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = {
	["StudsPerSecond"] = 1000,
	["FadeInDistance"] = 50,
	["SpawnDistance"] = 5,
	["Width"] = 0.2
}
return function(_, arg2, arg3)
	-- upvalues: (copy) v_u_tracers, (copy) v_u1, (copy) v_u_debris, (copy) v_u_tween, (copy) v_u_debris
	if arg2 then
		local v_default = v_u_tracers:FindFirstChild("Default")
		assert(v_default, "Default is not apart of Assets.Miscellaneous")
		local v_clone = v_default:Clone()
		v_clone.CollisionGroup = "Debris"
		v_clone.CanCollide = false
		v_clone.CanQuery = false
		v_clone.CanTouch = false
		v_clone.Anchored = true
		v_clone.CFrame = CFrame.new(arg2 + arg3 * v_u1.SpawnDistance)
		v_clone.Parent = v_u_debris
		local v_u_create = v_u_tween:Create(v_clone, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			["CFrame"] = CFrame.new(arg2 + arg3 * v_u1.StudsPerSecond)
		})
		task.defer(function()
			-- upvalues: (copy) v_u_create
			v_u_create:Play()
		end)
		local v_new = TweenInfo.new(v_u1.FadeInDistance / v_u1.StudsPerSecond, Enum.EasingStyle.Linear)
		v_clone.BottomAttachment.Position = Vector3.new(0, 0, 0)
		v_clone.RightAttachment.Position = Vector3.new(0, 0, 0)
		v_clone.LeftAttachment.Position = Vector3.new(0, 0, 0)
		v_clone.TopAttachment.Position = Vector3.new(0, 0, 0)
		local v1 = {
			["Position"] = Vector3.new(0, v_u1.Width / 2, 0)
		}
		v_u_tween:Create(v_clone.TopAttachment, v_new, v1):Play()
		local v2 = {
			["Position"] = Vector3.new(0, -v_u1.Width / 2, 0)
		}
		v_u_tween:Create(v_clone.BottomAttachment, v_new, v2):Play()
		local v3 = {
			["Position"] = Vector3.new(-v_u1.Width / 2, 0, 0)
		}
		v_u_tween:Create(v_clone.LeftAttachment, v_new, v3):Play()
		local v4 = {
			["Position"] = Vector3.new(v_u1.Width / 2, 0, 0)
		}
		v_u_tween:Create(v_clone.RightAttachment, v_new, v4):Play()
		v_u_debris:AddItem(v_clone, 2)
	end
end