-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = require(v_replicatedstorage.Classes.Sound)
local v_u2 = require(v_replicatedstorage.Shared.DebugFlags)
local v_u3 = require(v_replicatedstorage.Components.Common.VFXLibary.FlashEffect)
local v_u4 = require(script.Components.Materials)
local v_u_impacts = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("Impacts")
local v_u_debris = workspace:WaitForChild("Debris")
return function(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (copy) v_u_impacts, (copy) v_u4, (copy) v_u_players, (copy) v_u_http, (copy) v_u3, (copy) v_u2, (copy) v_u1, (copy) v_u_debris, (copy) v_u_debris
	local v1 = v_u_impacts:FindFirstChild(v_u4[arg2] or arg2)
	if v1 then
		if arg1 then
			local v_name = v1.Name
			if arg1.Name == "Head" and arg2 == "Blood Splatter" then
				local v_parent = arg1.Parent
				if v_parent and (v_parent:FindFirstChild("Humanoid") and v_parent:IsDescendantOf(workspace)) then
					local v_getplayerfromcharacter = v_u_players:GetPlayerFromCharacter(v_parent)
					if v_getplayerfromcharacter and v_getplayerfromcharacter:IsDescendantOf(v_u_players) then
						local v_armor = v_getplayerfromcharacter:GetAttribute("Armor")
						if v_armor then
							v_armor = v_u_http:JSONDecode(v_armor)
						end
						if arg6 or (not v_armor or v_armor.Type ~= "Kevlar + Helmet") then
							v_name = "Headshot"
						else
							v1 = v_u_impacts:FindFirstChild("Helmet Headshot")
							v_name = "Helmet Headshot"
						end
					end
				end
			end
			if arg5 then
				if v_u2.IsEnabled("WeaponFX") then
					warn(("[WeaponFX][Client][ImpactSound] skipped (exit shot) material=%s pos=%s"):format(tostring(arg2), (tostring(arg3))))
				end
			else
				local v_isflashed = v_u3.IsFlashed()
				local v2 = v_isflashed and 0 or 1
				if v_u2.IsEnabled("WeaponFX") then
					warn(("[WeaponFX][Client][ImpactSound] play material=%s sound=%s pos=%s flashed=%s exit=%s melee=%s volumeMult=%s"):format(tostring(arg2), tostring(v_name), tostring(arg3), tostring(v_isflashed), tostring(arg5), tostring(arg6), (tostring(v2))))
				end
				v_u1.new("Bullet"):PlaySoundAtPosition({
					["Position"] = arg3,
					["Class"] = "Bullet",
					["Name"] = v_name
				}, nil, v2)
			end
		end
		if arg2 == "Blood Splatter" or not arg6 then
			local v_getchildren = v1:GetChildren()
			local v_clone = v_getchildren[math.random(1, #v_getchildren)]:Clone()
			v_clone.CollisionGroup = "Debris"
			v_clone.CanCollide = false
			v_clone.CanQuery = false
			v_clone.CanTouch = false
			v_clone.Anchored = true
			v_clone.CFrame = CFrame.new(arg3, arg3 + arg4) + arg4 * 0.1
			v_clone.Parent = v_u_debris
			v_clone.Transparency = 1
			for _, v_u3 in ipairs(v_clone:GetDescendants()) do
				if v_u3:IsA("ParticleEmitter") then
					task.delay(v_u3:GetAttribute("EmitDelay") or 0, function()
						-- upvalues: (copy) v_u3
						v_u3:Emit(v_u3:GetAttribute("EmitCount") or 1)
					end)
				end
			end
			v_u_debris:AddItem(v_clone, 5)
		end
	end
end