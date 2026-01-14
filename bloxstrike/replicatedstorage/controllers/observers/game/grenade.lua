-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local v_u3 = {}
for _, v4 in ipairs(script.Executions:GetChildren()) do
	v_u3[v4.Name] = require(v4)
end
return v1.observeTag("Grenade", function(self)
	-- upvalues: (copy) v_u3, (copy) v_u2
	local v_grenadename = self:GetAttribute("GrenadeName")
	if v_grenadename then
		local v_u1 = v_u3[v_grenadename]
		if v_u1 then
			local v_u_new = v_u2.new()
			v_u_new:Add(self:GetAttributeChangedSignal("SimulationFinished"):Connect(function()
				-- upvalues: (copy) self, (copy) v_u1, (copy) v_u_new
				local v_primarypart = self.PrimaryPart
				if v_primarypart and self:GetAttribute("SimulationFinished") then
					v_u1(v_u_new, v_primarypart.Position, self)
				end
			end))
			return function()
				-- upvalues: (copy) v_u_new
				v_u_new:Destroy()
			end
		end
	end
end)