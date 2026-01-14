-- Decompiled with Bunni.lol Decompiler

local v_isstudio = game:GetService("RunService"):IsStudio()
return table.freeze({
	["Decoy Grenade"] = v_isstudio and 99 or 1,
	["Smoke Grenade"] = v_isstudio and 99 or 1,
	["HE Grenade"] = v_isstudio and 99 or 1,
	["Flashbang"] = v_isstudio and 99 or 2,
	["Molotov"] = v_isstudio and 99 or 1
})