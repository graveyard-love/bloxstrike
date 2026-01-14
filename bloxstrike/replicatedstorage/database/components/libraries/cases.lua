-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u_new = require(v_u_replicatedstorage.Packages.Signal).new()
v_u1.OnCasesUpdated = v_u_new
local v_u_isstudio = v_run:IsStudio()
local v_u3 = {}
local function v_u4(arg1)
	-- upvalues: (copy) v_u_isstudio
	local v_unixtimestamp = DateTime.now().UnixTimestamp
	if v_u_isstudio then
		return true
	elseif arg1.status == "inactive" or not arg1.isEnabled then
		return false
	elseif arg1.releaseDate or arg1.discontinueDate then
		if arg1.releaseDate and v_unixtimestamp < DateTime.fromIsoDate(arg1.releaseDate).UnixTimestamp then
			return false
		else
			return (not arg1.discontinueDate or DateTime.fromIsoDate(arg1.discontinueDate).UnixTimestamp > v_unixtimestamp) and true or false
		end
	else
		return true
	end
end
function v_u1.IsCaseEnabled(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u4
	local v_getcase = v_u1.GetCase(arg1)
	if v_getcase then
		return v_u4(v_getcase)
	else
		return false
	end
end
function v_u1.GetCaseByName(arg1)
	-- upvalues: (ref) v_u3
	if not v_u3 then
		return nil
	end
	for _, v1 in ipairs(v_u3) do
		if v1.name == arg1 then
			return v1
		end
	end
	return nil
end
function v_u1.GetCase(arg1)
	-- upvalues: (ref) v_u3
	if not v_u3 then
		return nil
	end
	for _, v1 in ipairs(v_u3) do
		if v1.caseId == arg1 then
			return v1
		end
	end
	return nil
end
function v_u1.GetFeaturedCases(self)
	-- upvalues: (ref) v_u3, (copy) v_u4, (copy) v_u2
	local v1 = {}
	for _, v2 in ipairs(v_u3) do
		if v2.isFeatured and v_u4(v2) then
			table.insert(v1, v2)
		end
	end
	table.sort(v1, function(arg1, arg2)
		return arg1.displayOrder < arg2.displayOrder
	end)
	v_u2(v1, function(arg1, _)
		-- upvalues: (copy) self
		return self < arg1
	end)
	return v1
end
function v_u1.GetCases()
	-- upvalues: (ref) v_u3, (copy) v_u4
	local v1 = {}
	for _, v2 in ipairs(v_u3) do
		if v_u4(v2) then
			table.insert(v1, v2)
		end
	end
	table.sort(v1, function(arg1, arg2)
		return arg1.displayOrder < arg2.displayOrder
	end)
	return v1
end
function v_u1.ObserveAvailableCases(arg1)
	-- upvalues: (copy) v_u_new, (ref) v_u3
	local v_u_connection = v_u_new:Connect(arg1)
	if v_u3 then
		arg1(v_u3)
	end
	return function()
		-- upvalues: (copy) v_u_connection
		v_u_connection:Disconnect()
	end
end
if v_u_replicatedstorage:GetAttribute("AvaiableCases") then
	v_u3 = v_u_http:JSONDecode((v_u_replicatedstorage:GetAttribute("AvaiableCases")))
	if #v_u_new:GetConnections() > 0 then
		v_u_new:Fire(v_u3)
	end
end
v_u_replicatedstorage:GetAttributeChangedSignal("AvaiableCases"):Connect(function()
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u3, (copy) v_u_http, (copy) v_u_new
	local v_avaiablecases = v_u_replicatedstorage:GetAttribute("AvaiableCases")
	if v_avaiablecases then
		v_u3 = v_u_http:JSONDecode(v_avaiablecases)
		if #v_u_new:GetConnections() > 0 then
			v_u_new:Fire(v_u3)
		end
	else
		return
	end
end)
return v_u1