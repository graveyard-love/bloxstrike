-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local function v_u2(arg1)
	local v_screen = arg1:FindFirstChild("Screen")
	if v_screen then
		for _, v1 in ipairs(v_screen:GetChildren()) do
			if v1.Name == "Noise" then
				local v_random = math.random()
				v1.Transparency = math.clamp(v_random, 0.2, 0.7)
				v1.Color3 = Color3.fromRGB(192 + math.random(-10, 10), 216 + math.random(-10, 10), 255 + math.random(-10, 10))
			end
		end
	end
end
local function v_u3(arg1)
	-- upvalues: (copy) v_u_tween
	local v_screen = arg1:FindFirstChild("Screen")
	if v_screen then
		v_u_tween:Create(v_screen, TweenInfo.new(2.15), {
			["Color"] = Color3.fromRGB(0, 0, 0)
		}):Play()
		local v_pointlight = v_screen.ScreenLight.PointLight
		for _ = 1, 8 do
			v_pointlight.Enabled = not v_pointlight.Enabled
			task.wait(math.random(1, 4) / 10)
		end
		v_pointlight.Enabled = false
		for _, v1 in ipairs(v_screen:GetChildren()) do
			if v1.Name == "Noise" then
				v1.Transparency = 1
			end
		end
	end
end
return v_u1.observeTag("Television", function(self)
	-- upvalues: (copy) v_u_run, (copy) v_u2, (copy) v_u1, (copy) v_u3
	local v_u1 = 0
	if self:IsDescendantOf(workspace) then
		local v_u_connection = v_u_run.Heartbeat:Connect(function(arg1)
			-- upvalues: (ref) v_u1, (copy) self, (ref) v_u2
			if v_u1 + arg1 >= 0.016666666666666666 then
				v_u1 = v_u1 - 0.016666666666666666
				if self and self:IsDescendantOf(workspace) then
					v_u2(self)
				end
			end
		end)
		local v_u_observeattribute = v_u1.observeAttribute(self, "Broken", function(_)
			-- upvalues: (ref) v_u3, (copy) self, (copy) v_u_connection
			v_u3(self)
			if v_u_connection and v_u_connection.Connected then
				v_u_connection:Disconnect()
			end
		end)
		return function()
			-- upvalues: (copy) v_u_observeattribute, (copy) v_u_connection
			v_u_observeattribute()
			if v_u_connection and v_u_connection.Connected then
				v_u_connection:Disconnect()
			end
		end
	end
end)