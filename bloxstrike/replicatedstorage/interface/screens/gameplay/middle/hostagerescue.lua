-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
local v_u2 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u_localplayer = v_players.LocalPlayer
local v_u3 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_u_replicatedstorage.Packages.Observers)
local v_u5 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u6 = {}
local v_u7 = nil
local function v_u8(arg1)
	-- upvalues: (copy) v_u6
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v_u6[v1] then
			v_u6[v1]:Destroy()
			v_u6[v1] = nil
		end
	end
end
local function v_u9()
	-- upvalues: (ref) v_u7
	local v1 = {}
	for _, v2 in ipairs(v_u7:GetChildren()) do
		if v2:IsA("Frame") then
			table.insert(v1, v2)
		end
	end
	for _, v3 in ipairs(v1) do
		v3.Size = UDim2.fromScale(1 / #v1, 1)
	end
end
function v_u1.CreateTemplate(_)
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u7, (copy) v_u9
	local v_clone = v_u_replicatedstorage.Assets.UI.HostageRescue.Template:Clone()
	v_clone.Parent = v_u7
	v_u9()
	return v_clone
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u_run, (copy) v_u2, (copy) v_u8, (copy) v_u4, (copy) v_u5, (copy) v_u9, (copy) v_u1, (copy) v_u6
	v_u7 = arg2
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Hud Size", function(arg1)
		-- upvalues: (ref) v_u7
		if v_u7 then
			v_u7.Position = UDim2.new(0.029, 0, 0, 240 - (200 - arg1 * 200) + 50)
		end
	end)
	local v1 = v_u3.Get(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Hud Size") or 1
	if v_u7 then
		v_u7.Position = UDim2.new(0.029, 0, 0, 240 - (200 - v1 * 200) + 50)
	end
	v_u_run.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u7
		v_u7.Visible = workspace:GetAttribute("Gamemode") == "Hostage Rescue"
	end)
	v_u2.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u8, (ref) v_u7
		if arg2 == "Buy Period" or arg2 == "Warmup" then
			v_u8(v_u7)
		end
	end)
	v_u4.observeTag("Hostage", function(self)
		-- upvalues: (ref) v_u5, (ref) v_u9, (ref) v_u1, (ref) v_u6
		local v_new = v_u5.new()
		v_new:Add(v_u9)
		local v_u_add = v_new:Add(v_u1.CreateTemplate(self))
		v_u6[v_u_add] = v_new
		local v1 = self:GetAttribute("State") or "Idle"
		v_u_add.Idle.Visible = v1 ~= "Carrying"
		v_u_add.Action.Visible = v1 == "Carrying"
		v_new:Add(self:GetAttributeChangedSignal("State"):Connect(function()
			-- upvalues: (copy) v_u_add, (copy) self
			local v1 = v_u_add
			local v2 = self:GetAttribute("State") or "Idle"
			v1.Idle.Visible = v2 ~= "Carrying"
			v1.Action.Visible = v2 == "Carrying"
		end))
		return function()
			-- upvalues: (ref) v_u6, (copy) v_u_add
			if v_u6[v_u_add] then
				v_u6[v_u_add]:Destroy()
				v_u6[v_u_add] = nil
			end
		end
	end)
end
return v_u1