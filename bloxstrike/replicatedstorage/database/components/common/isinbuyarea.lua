-- Decompiled with Bunni.lol Decompiler

local v_u_collection = game:GetService("CollectionService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
return function(arg1)
	-- upvalues: (copy) v_u_collection
	local v_team = arg1:GetAttribute("Team")
	local v_character = arg1.Character
	if v_character and v_character:IsDescendantOf(workspace) then
		local v_buyarea = v_u_collection:GetTagged("BuyArea")
		for _, v1 in ipairs(v_buyarea) do
			if not v_character.PrimaryPart then
				return false
			end
			if v1:GetAttribute("Team") == v_team and v1:IsDescendantOf(workspace) then
				local v_size = v1.Size
				local v_pointtoobjectspace = v1.CFrame:PointToObjectSpace(UNNAMED_1728997158856.Position)
				local v2
				if math.abs(v_pointtoobjectspace.X) <= v_size.X / 2 and math.abs(v_pointtoobjectspace.Y) <= v_size.Y / 2 then
					v2 = math.abs(v_pointtoobjectspace.Z) <= v_size.Z / 2
				else
					v2 = false
				end
				if v2 then
					return true
				end
			end
		end
	end
	return workspace:GetAttribute("Gamemode") == "Deathmatch"
end