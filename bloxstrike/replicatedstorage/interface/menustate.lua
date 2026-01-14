-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_lighting = game:GetService("Lighting")
local v_u_playergui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v2 = require(v_replicatedstorage.Packages.Signal)
v_u1.OnScreenChanged = v2.new()
v_u1.OnInspectStateChanged = v2.new()
v_u1.OnCaseSceneStateChanged = v2.new()
local v_u3 = nil
local v_u4 = nil
local v_u5 = false
local v_u6 = false
local v_u7 = nil
local v_u8 = nil
local v_u9 = nil
local v_u10 = nil
function v_u1.Initialize(arg1)
	-- upvalues: (ref) v_u9, (ref) v_u10, (copy) v_u_lighting
	v_u9 = arg1
	local v1
	if v_u10 then
		v1 = v_u10
	else
		v_u10 = v_u_lighting:FindFirstChild("Menu")
		v1 = v_u10
	end
	v_u10 = v1
end
function v_u1.GetCurrentScreen()
	-- upvalues: (ref) v_u3
	return v_u3
end
function v_u1.GetPreviousScreen()
	-- upvalues: (ref) v_u4
	return v_u4
end
function v_u1.IsInspectActive()
	-- upvalues: (ref) v_u5
	return v_u5
end
function v_u1.SetScreen(arg1)
	-- upvalues: (ref) v_u3, (ref) v_u4, (copy) v_u1
	if arg1 ~= v_u3 then
		local v1 = v_u3
		v_u4 = v1
		v_u3 = arg1
		v_u1.OnScreenChanged:Fire(v1, arg1)
	end
end
function v_u1.EnterInspect()
	-- upvalues: (ref) v_u5, (ref) v_u7, (ref) v_u3, (copy) v_u1
	if not v_u5 then
		v_u7 = v_u3
		v_u5 = true
		v_u1.OnInspectStateChanged:Fire(true)
	end
end
function v_u1.ExitInspect()
	-- upvalues: (ref) v_u5, (copy) v_u1, (ref) v_u7
	if v_u5 then
		v_u5 = false
		v_u1.OnInspectStateChanged:Fire(false)
		v_u7 = nil
	end
end
function v_u1.GetScreenBeforeInspect()
	-- upvalues: (ref) v_u7
	return v_u7
end
function v_u1.IsCaseSceneActive()
	-- upvalues: (ref) v_u6
	return v_u6
end
function v_u1.EnterCaseScene()
	-- upvalues: (ref) v_u6, (ref) v_u8, (ref) v_u3, (copy) v_u1
	if not v_u6 then
		v_u8 = v_u3
		v_u6 = true
		v_u1.OnCaseSceneStateChanged:Fire(true)
	end
end
function v_u1.ExitCaseScene()
	-- upvalues: (ref) v_u6, (copy) v_u1, (ref) v_u8
	if v_u6 then
		v_u6 = false
		v_u1.OnCaseSceneStateChanged:Fire(false)
		v_u8 = nil
	end
end
function v_u1.GetScreenBeforeCaseScene()
	-- upvalues: (ref) v_u8
	return v_u8
end
function v_u1.SetBlurEnabled(arg1)
	-- upvalues: (ref) v_u10, (copy) v_u_lighting
	local v1
	if v_u10 then
		v1 = v_u10
	else
		v_u10 = v_u_lighting:FindFirstChild("Menu")
		v1 = v_u10
	end
	if v1 then
		v1.Enabled = arg1
	end
end
function v_u1.IsBlurEnabled()
	-- upvalues: (ref) v_u10, (copy) v_u_lighting
	local v1
	if v_u10 then
		v1 = v_u10
	else
		v_u10 = v_u_lighting:FindFirstChild("Menu")
		v1 = v_u10
	end
	return v1 and v1.Enabled or false
end
function v_u1.GetMenuFrame()
	-- upvalues: (ref) v_u9, (copy) v_u_playergui
	if not v_u9 then
		v_u9 = v_u_playergui:FindFirstChild("MainGui")
	end
	if v_u9 then
		return v_u9:FindFirstChild("Menu")
	else
		return nil
	end
end
function v_u1.GetMainGui()
	-- upvalues: (ref) v_u9, (copy) v_u_playergui
	if not v_u9 then
		v_u9 = v_u_playergui:FindFirstChild("MainGui")
	end
	return v_u9
end
return v_u1