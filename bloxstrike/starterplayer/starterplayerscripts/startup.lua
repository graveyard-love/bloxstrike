-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(game.ReplicatedStorage.Shared.Promise)
local function v2(self)
	-- upvalues: (copy) v_u1
	debug.setmemorycategory((("%*"):format(self.Name)))
	return v_u1.try(function()
		-- upvalues: (copy) self
		return require(self)
	end):catch(warn)
end
for _, v3 in ipairs(v_replicatedstorage.Controllers:GetChildren()) do
	if v3:IsA("ModuleScript") then
		v2(v3):andThen(function(arg1)
			-- upvalues: (copy) v_u1
			local v1 = typeof(arg1) == "table" and arg1.Initialize
			if v1 then
				v_u1.try(v1):catch(warn):await()
			end
			local v2 = typeof(arg1) == "table" and arg1.Start
			if v2 then
				v_u1.try(v2):catch(warn)
			end
		end)
	end
end
for _, v4 in ipairs(v_replicatedstorage.Controllers.Observers:GetChildren()) do
	if v4:IsA("ModuleScript") then
		v2(v4)
	elseif v4:IsA("Folder") then
		for _, v5 in ipairs(v4:GetChildren()) do
			if v5:IsA("ModuleScript") then
				v2(v5)
			end
		end
	end
end
v2(v_replicatedstorage:WaitForChild("Interface")):andThen(function(arg1)
	-- upvalues: (copy) v_u1
	return v_u1.try(arg1.Initialize):andThen(arg1.Start):catch(warn)
end)