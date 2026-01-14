-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_contextaction = game:GetService("ContextActionService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_replicatedstorage.Database.Security.Router)
local v_u4 = require(script:WaitForChild("KeybindParser"))
local v_u_actions = script:WaitForChild("Actions")
local v_u_localplayer = v_players.LocalPlayer
local v_u_getmouse = v_u_localplayer:GetMouse()
local v_u5 = {}
local v_u6 = {}
local v_u7 = {}
local v_u8 = {
	["ScrollWheelUp"] = nil,
	["ScrollWheelDown"] = nil
}
local function v_u9(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (copy) v_u6
	local v1 = v_u7[arg1]
	if v1 then
		if v_u6[v1.Group] then
			v1.IsActive = arg2 == Enum.UserInputState.Begin
			task.spawn(v1.Callback, arg2, arg3)
		end
	end
end
local function v_u10(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u6, (copy) v_u9
	if arg1 then
		local v_begin = Enum.UserInputState.Begin
		local v1 = {
			["UserInputType"] = Enum.UserInputType.MouseWheel,
			["Delta"] = Vector3.new(0, arg2, 0)
		}
		local v2 = v_u7[arg1]
		if v2 and v_u6[v2.Group] then
			v2.IsActive = v_begin == Enum.UserInputState.Begin
			task.spawn(v2.Callback, v_begin, v1)
		end
		task.defer(v_u9, arg1, Enum.UserInputState.End, {
			["UserInputType"] = Enum.UserInputType.MouseWheel,
			["Delta"] = Vector3.new(0, arg2, 0)
		})
	end
end
function v_u1.registerAction(arg1)
	-- upvalues: (copy) v_u7
	v_u7[arg1.Name] = {
		["Category"] = arg1.Category,
		["Callback"] = arg1.Callback,
		["Group"] = arg1.Group,
		["Name"] = arg1.Name,
		["IsActive"] = false,
		["Keybinds"] = {}
	}
end
function v_u1.bindKeybinds(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u_contextaction, (copy) v_u8, (copy) v_u5, (copy) v_u6
	local v1 = v_u7[arg1]
	if v1 then
		v_u_contextaction:UnbindAction(arg1)
		for _, v2 in ipairs(v1.Keybinds) do
			if typeof(v2) == "string" then
				if v2 == "ScrollWheelUp" then
					v_u8.ScrollWheelUp = nil
				elseif v2 == "ScrollWheelDown" then
					v_u8.ScrollWheelDown = nil
				end
			else
				v_u5[v2] = nil
			end
		end
		local v3 = {}
		local v4 = {}
		for _, v5 in ipairs(arg2) do
			if v5 then
				if typeof(v5) == "string" then
					if v5 == "ScrollWheelUp" and not v_u8.ScrollWheelUp then
						table.insert(v3, v5)
						v_u8.ScrollWheelUp = arg1
					elseif v5 == "ScrollWheelDown" and not v_u8.ScrollWheelDown then
						table.insert(v3, v5)
						v_u8.ScrollWheelDown = arg1
					end
				elseif not v_u5[v5] then
					table.insert(v3, v5)
					table.insert(v4, v5)
					v_u5[v5] = arg1
				end
			end
		end
		v1.Keybinds = v3
		if #v4 > 0 then
			v_u_contextaction:BindAction(arg1, function(_, arg2, arg3)
				-- upvalues: (copy) arg1, (ref) v_u7, (ref) v_u6
				local v1 = v_u7[arg1]
				if v1 then
					if v_u6[v1.Group] then
						v1.IsActive = arg2 == Enum.UserInputState.Begin
						task.spawn(v1.Callback, arg2, arg3)
					end
				end
			end, false, table.unpack(v4))
		end
	end
end
function v_u1.loadActionsFromDatabase(arg1)
	-- upvalues: (copy) v_u4, (copy) v_u1
	for _, v1 in pairs(arg1) do
		for v2, v3 in pairs(v1) do
			local v4 = {}
			if typeof(v3) == "table" then
				local v5 = v3.Computer and v3.Computer ~= "" and v_u4.parse(v3.Computer)
				if v5 then
					table.insert(v4, v5)
				end
				local v6 = v3.Console and v3.Console ~= "" and v_u4.parse(v3.Console)
				if v6 then
					table.insert(v4, v6)
				end
			end
			if #v4 > 0 then
				v_u1.bindKeybinds(v2, v4)
			end
		end
	end
end
function v_u1.isActionActive(arg1)
	-- upvalues: (copy) v_u7
	local v1 = v_u7[arg1]
	return v1 and v1.IsActive or false
end
function v_u1.enableGroup(arg1)
	-- upvalues: (copy) v_u6
	v_u6[arg1] = true
end
function v_u1.disableGroup(arg1)
	-- upvalues: (copy) v_u6
	v_u6[arg1] = nil
end
function v_u1.GetActionKeybind(arg1)
	-- upvalues: (copy) v_u7
	local v1 = v_u7[arg1]
	if v1 and #v1.Keybinds ~= 0 then
		local v2 = v1.Keybinds[1]
		if typeof(v2) == "string" then
			return v2
		else
			return tostring(v2):match("%.(%w+)$") or tostring(v2)
		end
	else
		return nil
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_actions, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u_contextaction, (copy) v_u2, (copy) v_u3
	for _, v1 in ipairs(v_u_actions:GetChildren()) do
		if v1:IsA("ModuleScript") then
			v_u1.registerAction((require(v1)))
		end
	end
	v_u1.enableGroup("Default")
	v_u_localplayer.CharacterAdded:Connect(function(_)
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("jumpAction")
	end)
	v_u2.CreateListener(v_u_localplayer, "Settings.Keyboard/Mouse", function(arg1)
		-- upvalues: (ref) v_u1
		if arg1 then
			v_u1.loadActionsFromDatabase(arg1)
		end
	end)
	v_u3.observerRouter("RebindKeybinds", function()
		-- upvalues: (ref) v_u2, (ref) v_u_localplayer, (ref) v_u1
		local v_get = v_u2.Get(v_u_localplayer, "Settings.Keyboard/Mouse")
		if not v_get then
			return false
		end
		v_u1.loadActionsFromDatabase(v_get)
		return true
	end)
end
function v_u1.getActionKeybinds(arg1)
	-- upvalues: (copy) v_u7
	local v1 = v_u7[arg1]
	if not v1 then
		return {}
	end
	local v2 = {}
	for _, v3 in ipairs(v1.Keybinds) do
		if typeof(v3) ~= "string" then
			table.insert(v2, v3)
		end
	end
	return v2
end
function v_u1.Start()
	-- upvalues: (copy) v_u_getmouse, (copy) v_u10, (copy) v_u8
	v_u_getmouse.WheelBackward:Connect(function()
		-- upvalues: (ref) v_u10, (ref) v_u8
		v_u10(v_u8.ScrollWheelDown, -1)
	end)
	v_u_getmouse.WheelForward:Connect(function()
		-- upvalues: (ref) v_u10, (ref) v_u8
		v_u10(v_u8.ScrollWheelUp, 1)
	end)
end
return v_u1