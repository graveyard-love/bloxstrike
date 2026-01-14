-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
local function v_u2(arg1, arg2, arg3)
	if arg2 then
		if arg1.Visible then
			if arg1:IsDescendantOf(game) then
				local v1 = arg3 or 1
				local v_alpha = arg2.Alpha
				local v2 = (not v_alpha or (type(v_alpha) ~= "table" or (not v_alpha.Enabled or type(v_alpha.Value) ~= "number"))) and 1 or v_alpha.Value / 255
				local v_fromrgb = Color3.fromRGB(tonumber(arg2.Red or 0) or 0, tonumber(arg2.Green or 255) or 255, tonumber(arg2.Blue or 0) or 0)
				local v_crosshair style = arg2["Crosshair Style"]
				local v3 = v_crosshair style == "Image"
				local v4 = v_crosshair style == "Classic"
				local v_ticks = arg1:FindFirstChild("Ticks")
				local v_dot = arg1:FindFirstChild("Dot")
				local v_crosshair = arg1:FindFirstChild("Crosshair")
				if v_ticks and (v_dot and v_crosshair) then
					v_ticks.Visible = not v3
					local v5 = not v3
					if v5 then
						v5 = arg2["Center Dot"] == true
					end
					v_dot.Visible = v5
					v_crosshair.Visible = v3
					if v3 then
						local v6 = "rbxassetid://" .. tostring(arg2["Crosshair Image"])
						v_crosshair.Image = type(v6) == "string" and v6 and v6 or "rbxassetid://00000000"
						v_crosshair.ImageColor3 = v_fromrgb
						v_crosshair.ImageTransparency = 1 - v2
					else
						local v_outline = arg2.Outline
						local v7, v8
						if v_outline and type(v_outline) == "table" then
							v7 = v_outline.Enabled == true
							v8 = tonumber(v_outline.Value) or 1
						else
							v7 = false
							v8 = 1
						end
						for _, v9 in ipairs({
							"Up",
							"Down",
							"Left",
							"Right"
						}) do
							local v10 = v_ticks:FindFirstChild(v9)
							if v10 then
								v10.BackgroundColor3 = v_fromrgb
								v10.BackgroundTransparency = 1 - v2
								v10.Visible = true
								local v11 = 15 * ((tonumber(arg2.Length) or 5) / 5)
								local v12 = 2 * ((tonumber(arg2.Thickness) or 1) / 1)
								if v9 == "Up" or v9 == "Down" then
									v10.Size = UDim2.new(0, v12, 0, v11)
								else
									v10.Size = UDim2.new(0, v11, 0, v12)
								end
								if v7 then
									v10.BorderSizePixel = v8
									v10.BorderColor3 = Color3.new(0, 0, 0)
								else
									v10.BorderSizePixel = 0
								end
							end
						end
						local v_up = v_ticks:FindFirstChild("Up")
						if v_up then
							v_up.Visible = arg2["T Style"] ~= true
						end
						if v_dot and arg2["Center Dot"] == true then
							v_dot.BackgroundColor3 = v_fromrgb
							v_dot.BackgroundTransparency = 1 - v2
							if v7 then
								v_dot.BorderSizePixel = v8
								v_dot.BorderColor3 = Color3.new(0, 0, 0)
							else
								v_dot.BorderSizePixel = 0
							end
						end
						local v13 = 5 + (tonumber(arg2.Gap) or -1) * 5 / 5
						if v4 then
							v13 = v13 * v1
						end
						local v_right = v_ticks:FindFirstChild("Right")
						local v_down = v_ticks:FindFirstChild("Down")
						local v_left = v_ticks:FindFirstChild("Left")
						local v_up = v_ticks:FindFirstChild("Up")
						if v_right then
							v_right.Position = UDim2.new(0.5, v13, 0.5, 0)
						end
						if v_down then
							v_down.Position = UDim2.new(0.5, 0, 0.5, v13)
						end
						if v_left then
							v_left.Position = UDim2.new(0.5, -v13, 0.5, 0)
						end
						if v_up then
							v_up.Position = UDim2.new(0.5, 0, 0.5, -v13)
						end
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
return function(arg1, arg2, arg3, _, arg5, _, _, _)
	-- upvalues: (copy) v_u1, (copy) v_u_run, (copy) v_u_localplayer, (copy) v_u2
	arg3.LayoutOrder = arg2
	local v_u_new = v_u1.new()
	v_u_new:Add(arg3, "Destroy")
	local v_u_crosshair = arg3.Crosshair
	local v_u1 = 0
	v_u_new:Add(v_u_run.Stepped:Connect(function(_, arg2)
		-- upvalues: (copy) arg3, (ref) v_u_localplayer, (copy) arg5, (ref) v_u1, (ref) v_u2, (copy) v_u_crosshair
		local v_scrollingframe = arg3:FindFirstAncestorOfClass("ScrollingFrame")
		local v1 = v_scrollingframe and v_scrollingframe.Visible
		if v1 then
			v1 = v_scrollingframe:IsDescendantOf(v_u_localplayer.PlayerGui)
		end
		if v1 then
			local v2 = arg5()
			if v2 then
				local v3
				if v2["Crosshair Style"] == "Classic" then
					v3 = math.max(math.sin((v_u1 + arg2) * 3.141592653589793 * 2 * 0.25) * 2 + 1, 0.75)
				else
					v_u1 = 0
					v3 = 1
				end
				v_u2(v_u_crosshair, v2, v3)
			end
		else
			return
		end
	end), "Disconnect")
	arg3.Parent = arg1
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end