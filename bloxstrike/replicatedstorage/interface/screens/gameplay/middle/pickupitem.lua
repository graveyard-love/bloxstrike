-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u3 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u4 = nil
local function v_u5(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer
	local v_character = v_u_localplayer.Character
	if v_character and v_character.PrimaryPart then
		local v_hoveringstate = arg1:GetAttribute("HoveringState")
		local v_hoveringstate = arg2:GetAttribute("HoveringState")
		if v_hoveringstate == "Hovering" then
			return true
		elseif v_hoveringstate == "Hovering" then
			return false
		else
			local v_canpickup = arg1:GetAttribute("CanPickup")
			local v_canpickup = arg2:GetAttribute("CanPickup")
			if v_canpickup == false then
				return false
			elseif v_canpickup == false then
				return true
			elseif arg1.PrimaryPart and arg2.PrimaryPart then
				return (v_character.PrimaryPart.Position - arg1.PrimaryPart.Position).Magnitude < (v_character.PrimaryPart.Position - arg2.PrimaryPart.Position).Magnitude
			else
				return false
			end
		end
	else
		return false
	end
end
function v_u1.Render(_)
	-- upvalues: (copy) v_u_collection, (copy) v_u5, (copy) v_u2, (copy) v_u3, (ref) v_u4
	local v_gettagged = v_u_collection:GetTagged("IsHoveringInteractable")
	table.sort(v_gettagged, v_u5)
	local v1 = v_gettagged[1]
	if v1 then
		local v_weapon = v1:GetAttribute("Weapon")
		local v_skin = v1:GetAttribute("Skin")
		local v_getskininformation = v_u2.GetSkinInformation(v_weapon, v_skin)
		assert(v_getskininformation, "Skin data not found for weapon: " .. v_weapon .. " and skin: " .. v_skin)
		local v2 = v_u3[v_getskininformation.rarity]
		local v_floor = math.floor(v2.Color.R * 255)
		local v_floor = math.floor(v2.Color.G * 255)
		local v_floor = math.floor(v2.Color.B * 255)
		v_u4.TextLabel.Text = ("[E] Swap for <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, v_weapon, v_skin)
		v_u4.Visible = true
	else
		v_u4.Visible = false
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u_run, (copy) v_u_localplayer, (copy) v_u1
	v_u4 = arg2
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1, (ref) v_u4
		if v_u_localplayer.Character then
			v_u1.Render(arg1)
		else
			v_u4.Visible = false
		end
	end)
end
return v_u1