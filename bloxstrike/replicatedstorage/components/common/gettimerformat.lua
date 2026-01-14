-- Decompiled with Bunni.lol Decompiler

game:GetService("ReplicatedStorage")
return function(arg1)
	local v_floor = math.floor(arg1 / 60)
	return string.format("%02i", v_floor) .. ":" .. string.format("%02i", arg1 % 60)
end