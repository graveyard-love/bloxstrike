-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	["nil"] = 0,
	["EnumItem"] = 4,
	["boolean"] = 1,
	["number"] = 8,
	["UDim"] = 8,
	["UDim2"] = 16,
	["Ray"] = 24,
	["Faces"] = 6,
	["Axes"] = 6,
	["BrickColor"] = 4,
	["Color3"] = 12,
	["Vector2"] = 8,
	["Vector3"] = 12,
	["Instance"] = 4,
	["Vector2int16"] = 4,
	["Vector3int16"] = 6,
	["NumberSequenceKeypoint"] = 12,
	["ColorSequenceKeypoint"] = 16,
	["NumberRange"] = 8,
	["Rect"] = 16,
	["PhysicalProperties"] = 20,
	["Color3uint8"] = 3
}
local v_u2 = {
	[CFrame.Angles(0, 0, 0)] = true,
	[CFrame.Angles(0, 3.141592653589793, 0)] = true,
	[CFrame.Angles(1.5707963267948966, 0, 0)] = true,
	[CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0)] = true,
	[CFrame.Angles(0, 3.141592653589793, 3.141592653589793)] = true,
	[CFrame.Angles(0, 0, 3.141592653589793)] = true,
	[CFrame.Angles(-1.5707963267948966, 0, 0)] = true,
	[CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)] = true,
	[CFrame.Angles(0, 3.141592653589793, 1.5707963267948966)] = true,
	[CFrame.Angles(0, 0, -1.5707963267948966)] = true,
	[CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)] = true,
	[CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966)] = true,
	[CFrame.Angles(0, 0, 1.5707963267948966)] = true,
	[CFrame.Angles(0, -3.141592653589793, -1.5707963267948966)] = true,
	[CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)] = true,
	[CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966)] = true,
	[CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0)] = true,
	[CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)] = true,
	[CFrame.Angles(0, -1.5707963267948966, 0)] = true,
	[CFrame.Angles(0, 1.5707963267948966, 0)] = true,
	[CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)] = true,
	[CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)] = true,
	[CFrame.Angles(0, 1.5707963267948966, 3.141592653589793)] = true,
	[CFrame.Angles(0, -1.5707963267948966, 3.141592653589793)] = true
}
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u2
	local v1 = typeof(arg1)
	if v_u1[v1] then
		return v_u1[v1]
	end
	if v1 == "string" then
		return #arg1 + 2
	end
	if v1 == "table" then
		if arg2[arg1] then
			return 0
		end
		arg2[arg1] = true
		local v2 = 1
		local v3 = 0
		local v4 = 0
		local v5 = true
		for v6, v7 in next, arg1 do
			if v6 == v2 then
				v2 = v2 + 1
			else
				v5 = false
			end
			v3 = v3 + (v_u3(v6, arg2) + 1)
			v4 = v4 + (v_u3(v7, arg2) + 1)
		end
		return 1 + (v5 and #arg1 + v4 or v3 + v4)
	end
	if v1 ~= "CFrame" then
		if v1 ~= "NumberSequence" and v1 ~= "ColorSequence" then
			warn("Unsupported data type: " .. v1)
			return 0
		end
		local v8 = 4
		for _, v9 in next, arg1.Keypoints do
			v8 = v8 + v_u3(v9, arg2)
		end
		return v8
	end
	local v10 = false
	for v11 in next, v_u2 do
		if v11 == arg1.Rotation then
			v10 = true
			break
		end
	end
	return v10 and 13 or 21
end
local v4 = {
	["RemoteOverhead"] = 9,
	["TypeOverhead"] = 1,
	["GetPacketSize"] = function(arg1)
		-- upvalues: (copy) v_u3
		local v1 = arg1.IgnoreRemoteOffset and 0 or 9
		local v2 = {}
		for _, v3 in ipairs(arg1.PacketData) do
			v1 = v1 + (v_u3(v3, v2) + 1)
		end
		return v1
	end,
	["GetDataByteSize"] = function(arg1)
		-- upvalues: (copy) v_u3
		return v_u3(arg1, {})
	end
}
table.freeze(v4)
return v4