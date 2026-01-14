-- Decompiled with Bunni.lol Decompiler

return {
	["getUserFlag"] = function(self)
		local v1, v2 = pcall(function()
			-- upvalues: (copy) self
			return UserSettings():IsUserFeatureEnabled(self)
		end)
		return v1 and v2
	end
}