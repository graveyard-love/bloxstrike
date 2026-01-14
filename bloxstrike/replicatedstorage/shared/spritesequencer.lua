-- Decompiled with Bunni.lol Decompiler

local v_run = game:GetService("RunService")
local v_u1 = 60
local v_u2 = {}
local v_u3 = tick()
local v_u4 = 0
v_run[v_run:IsClient() and "RenderStepped" or "Heartbeat"]:Connect(function()
	-- upvalues: (ref) v_u4, (ref) v_u3, (ref) v_u1, (copy) v_u2
	v_u4 = v_u4 + 1
	local v1 = tick()
	if v1 - v_u3 >= 1 then
		v_u1 = math.floor(v_u4 / UNNAMED_1728994327880)
		v_u3 = v1
		v_u4 = 0
	end
	for v2, v3 in v_u2 do
		if v2 and v2.Parent then
			v3._nextFrame(v1)
		else
			v3.stop()
		end
	end
end)
local v_u5 = {
	["new"] = function(arg1, arg2)
		-- upvalues: (ref) v_u1, (copy) v_u2
		local v_u1 = {
			["looping"] = false,
			["cells"] = arg2,
			["framerate"] = v_u1,
			["play"] = function(arg1, arg2)
				-- upvalues: (ref) v_u1, (copy) v_u1, (ref) v_u2, (copy) arg1
				v_u1.looping = arg2 or false
				v_u1.framerate = arg1 or v_u1
				local v1 = v_u2[arg1.instance]
				if v1 then
					if v1 == v_u1 then
						return
					end
					v1.stop()
				end
				v_u2[arg1.instance] = v_u1
			end,
			["isPlaying"] = function()
				-- upvalues: (ref) v_u2, (copy) arg1, (copy) v_u1
				return v_u2[arg1.instance] == v_u1
			end
		}
		local v_u2 = 0
		local v_u3 = tick()
		function v_u1._nextFrame(arg1)
			-- upvalues: (ref) v_u3, (copy) v_u1, (ref) v_u2, (copy) arg1, (copy) arg2
			if arg1 - v_u3 >= 1 / v_u1.framerate then
				v_u3 = arg1
				v_u2 = v_u2 + 1
				arg1.display(arg2[v_u2])
				if v_u2 >= #arg2 then
					if v_u1.looping then
						v_u2 = 0
						return
					end
					v_u1.stop()
				end
			end
		end
		function v_u1.stop()
			-- upvalues: (ref) v_u2, (ref) v_u2, (copy) arg1, (copy) v_u1
			v_u2 = 0
			local v1 = v_u2[arg1.instance]
			if v1 then
				if v1 == v_u1 then
					v_u2[arg1.instance] = nil
				end
			else
				return
			end
		end
		return v_u1
	end,
	["fromRange"] = function(arg1, arg2, arg3)
		-- upvalues: (copy) v_u5
		assert(arg3 - arg2 > 0, ".fromRange only accepts positive ranges")
		local v1 = {}
		for v2 = arg2, arg3 do
			v1[#v1 + 1] = v2
		end
		return v_u5.new(arg1, v1)
	end
}
return v_u5