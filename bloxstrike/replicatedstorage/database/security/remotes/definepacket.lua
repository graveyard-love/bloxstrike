-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
local v_u2 = {}
local v_u3 = {}
local function v_u4(arg1, arg2)
	-- upvalues: (copy) v_u_players
	local v1 = {}
	for _, v2 in pairs(v_u_players:GetPlayers()) do
		if v2.Character and v2.Character:FindFirstChild("HumanoidRootPart") then
			local v_humanoidrootpart = v2.Character:FindFirstChild("HumanoidRootPart")
			if v_humanoidrootpart and (v_humanoidrootpart.Position - arg1).Magnitude <= arg2 then
				table.insert(v1, v2)
			end
		end
	end
	return v1
end
local function v_u5(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2, (copy) v_u1, (copy) v_u3, (copy) v_u_players
	local v1 = tick()
	local v2 = v_u2[arg1]
	if not v2 then
		v2 = {}
		v_u2[arg1] = v2
		local v_new = v_u1.new()
		v_u3[arg1] = v_new
		v_new:Add(v_u_players.PlayerRemoving:Connect(function(arg1)
			-- upvalues: (copy) arg1, (ref) v_u2, (ref) v_u3
			if arg1 == arg1 then
				local v1 = arg1
				v_u2[v1] = nil
				if v_u3[v1] then
					v_u3[v1]:Destroy()
					v_u3[v1] = nil
				end
			end
		end))
	end
	local v3 = v2[arg2]
	if v3 then
		if v1 - v3.lastRequest >= 1 then
			v3.lastRequest = v1
			v3.requestCount = 1
			return false
		else
			if arg3 <= v3.requestCount then
				return true
			end
			v3.requestCount = v3.requestCount + 1
			return false
		end
	else
		v2[arg2] = {
			["lastRequest"] = v1,
			["requestCount"] = 1
		}
		return false
	end
end
local function v_u6(arg1, arg2, arg3)
	-- upvalues: (copy) v_u5, (copy) v_u_players, (copy) v_u4
	local v1 = {}
	for v_u2, v3 in pairs(arg1) do
		if type(v3) == "function" then
			if v_u2 == "Send" or (v_u2 == "SendTo" or (v_u2 == "SendToAll" or (v_u2 == "SendToAllExcept" or v_u2 == "SendToList"))) then
				v1[v_u2] = function(arg1, ...)
					-- upvalues: (copy) v_u2, (copy) arg2, (copy) arg3, (ref) v_u5, (copy) arg1, (ref) v_u_players
					if v_u2 == "SendToList" then
						local v1 = select(1, ...)
						if v1 and #v1 ~= 0 then
							local v2 = {}
							for _, v3 in ipairs(v1) do
								local v4 = arg2
								local v5 = arg3
								local v6
								if v4.middleware and not v4.middleware(arg1, v3) then
									v6 = false
								else
									local v7 = v4.maximum_requests_per_second or 10
									v6 = (v7 <= 0 or not v_u5(v3, v5, v7)) and true or false
								end
								if v6 then
									table.insert(v2, v3)
								end
							end
							if #v2 > 0 then
								return arg1[v_u2](arg1, v2)
							end
						end
					else
						local v8 = nil
						if v_u2 == "Send" then
							v8 = v_u_players.LocalPlayer
						elseif v_u2 == "SendTo" then
							v8 = select(1, ...)
						end
						if v8 then
							local v9 = arg2
							local v10 = arg3
							local v11
							if v9.middleware and not v9.middleware(arg1, v8) then
								v11 = false
							else
								local v12 = v9.maximum_requests_per_second or 10
								v11 = (v12 <= 0 or not v_u5(v8, v10, v12)) and true or false
							end
							if not v11 then
								return
							end
						end
						return arg1[v_u2](arg1, ...)
					end
				end
			else
				v1[v_u2] = v3
			end
		else
			v1[v_u2] = v3
		end
	end
	function v1.SendToProximity(arg1, arg2)
		-- upvalues: (ref) v_u4, (copy) arg2, (copy) arg3, (ref) v_u5, (copy) arg1
		local v_position = arg2.position
		local v1 = arg2.range or 60
		if not v_position then
			error("SendToProximity requires position in options")
		end
		local v2 = v_u4(v_position, v1)
		for _, v3 in pairs(v2) do
			local v4 = arg2
			local v5 = arg3
			local v6
			if v4.middleware and not v4.middleware(arg1, v3) then
				v6 = false
			else
				local v7 = v4.maximum_requests_per_second or 10
				v6 = (v7 <= 0 or not v_u5(v3, v5, v7)) and true or false
			end
			if v6 and arg1.SendTo then
				arg1.SendTo(arg1, v3)
			end
		end
	end
	return v1
end
return function(arg1, arg2)
	-- upvalues: (copy) v_u6
	local v_u_gsub = tostring(arg1):gsub("table: ", "")
	local v_u1 = arg2 or {}
	return function(arg1)
		-- upvalues: (copy) arg1, (ref) v_u6, (copy) v_u1, (copy) v_u_gsub
		return v_u6(arg1(arg1), v_u1, v_u_gsub)
	end
end