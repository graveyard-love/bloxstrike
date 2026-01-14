-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_startergui = game:GetService("StarterGui")
local v_u_playergui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local v_u3 = require(v_replicatedstorage.Database.Security.Router)
local v_u4 = require(v_replicatedstorage.Shared.Promise)
local v_u5 = require(script.MenuState)
local v_u_screens = script:WaitForChild("Screens")
local v_u_maingui = v_replicatedstorage.Assets.UI.MainGui
v_u_maingui.Parent = v_u_playergui
local function v_u6(self)
	-- upvalues: (copy) v_u4
	debug.setmemorycategory((("%*"):format(self.Name)))
	return v_u4.try(function()
		-- upvalues: (copy) self
		return require(self)
	end):catch(warn)
end
local function v_u7(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u6, (copy) v_u4, (copy) v_u_maingui
	if arg2 then
		for _, v1 in ipairs(arg1:GetChildren()) do
			local v_u2 = arg2:FindFirstChild(v1.Name)
			if v1:IsA("Folder") then
				if v_u2 then
					v_u7(v1, v_u2)
				else
					warn((("Missing corresponding interface folder : \"%*\""):format((string.lower(v1:GetFullName())))))
				end
			elseif v1:IsA("ModuleScript") then
				if v_u2 then
					v_u6(v1):andThen(function(arg1)
						-- upvalues: (ref) v_u4, (ref) v_u_maingui, (copy) v_u2
						v_u4.try(arg1.Initialize, v_u_maingui, v_u2):andThen(arg1.Start):catch(warn)
					end)
				else
					warn((("Missing corresponding interface module for : \"%*\""):format((string.lower(v1:GetFullName())))))
				end
			end
		end
	else
		warn((("Pointer: \"%*\" is not apart of interface."):format(arg1.Name)))
	end
end
function v_u1.guarantee(arg1)
	for _ = 1, 15 do
		if pcall(arg1) then
			break
		end
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u5, (copy) v_u_maingui, (copy) v_u1, (copy) v_u_startergui, (copy) v_u3, (copy) v_u2, (copy) v_u_playergui
	v_u5.Initialize(v_u_maingui)
	v_u1.guarantee(function()
		-- upvalues: (ref) v_u_startergui
		v_u_startergui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		v_u_startergui:SetCore("ResetButtonCallback", false)
	end)
	v_u3.observerRouter("RunInterfaceSound", function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u_playergui
		v_u2.new("Interface"):playOneTime({
			["Parent"] = v_u_playergui,
			["Name"] = arg1
		})
	end)
	v_u3.observerRouter("RunStoreSound", function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u_playergui
		v_u2.new("Store"):playOneTime({
			["Parent"] = v_u_playergui,
			["Name"] = arg1
		})
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u7, (copy) v_u_screens, (copy) v_u_maingui
	v_u7(v_u_screens, v_u_maingui)
end
return v_u1