-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.CameraShakeInstance)
local v_u2 = {
	["Bump"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(2.5, 4, 0.1, 0.75)
		v_new.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		v_new.RotationInfluence = Vector3.new(1, 1, 1)
		return v_new
	end,
	["Landed"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(2, 3, 0.1, 0.5)
		v_new.PositionInfluence = Vector3.new(0, 0, 0)
		v_new.RotationInfluence = Vector3.new(1, 0, 0.15)
		return v_new
	end,
	["Shoot"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(0.3, 5, 0.1, 0.2)
		v_new.PositionInfluence = Vector3.new(0, 0, 0.5)
		v_new.RotationInfluence = Vector3.new(0.5, 0.5, 0.5)
		return v_new
	end,
	["Explosion"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(5, 10, 0, 1.5)
		v_new.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v_new.RotationInfluence = Vector3.new(4, 1, 1)
		return v_new
	end,
	["Earthquake"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(0.6, 3.5, 2, 10)
		v_new.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v_new.RotationInfluence = Vector3.new(1, 1, 4)
		return v_new
	end,
	["BadTrip"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(10, 0.15, 5, 10)
		v_new.PositionInfluence = Vector3.new(0, 0, 0.15)
		v_new.RotationInfluence = Vector3.new(2, 1, 4)
		return v_new
	end,
	["HandheldCamera"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(1, 0.25, 5, 10)
		v_new.PositionInfluence = Vector3.new(0, 0, 0)
		v_new.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return v_new
	end,
	["Vibration"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(0.4, 20, 2, 2)
		v_new.PositionInfluence = Vector3.new(0, 0.15, 0)
		v_new.RotationInfluence = Vector3.new(1.25, 0, 4)
		return v_new
	end,
	["RoughDriving"] = function()
		-- upvalues: (copy) v_u1
		local v_new = v_u1.new(1, 2, 1, 1)
		v_new.PositionInfluence = Vector3.new(0, 0, 0)
		v_new.RotationInfluence = Vector3.new(1, 1, 1)
		return v_new
	end
}
return setmetatable({}, {
	["__index"] = function(_, arg2)
		-- upvalues: (copy) v_u2
		local v1 = v_u2[arg2]
		if type(v1) == "function" then
			return v1()
		end
		error("No preset found with index \"" .. arg2 .. "\"")
	end
})