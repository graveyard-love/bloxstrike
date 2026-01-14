-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.ConnectionUtil)
local v_u2 = {}
v_u2.__index = v_u2
function v_u2.new()
	-- upvalues: (copy) v_u1, (copy) v_u2
	return setmetatable({
		["_camera"] = game.Workspace.CurrentCamera,
		["_callbacks"] = {},
		["_connectionUtil"] = v_u1.new(),
		["_enabled"] = false
	}, v_u2)
end
function v_u2._connectCallbacks(arg1)
	arg1._camera = game.Workspace.CurrentCamera
	if arg1._camera then
		for v1, v2 in arg1._callbacks do
			arg1._connectionUtil:trackConnection(v1, arg1._camera:GetPropertyChangedSignal(v1):Connect(v2))
			v2()
		end
	end
end
function v_u2.Enable(self)
	if not self._enabled then
		self._enabled = true
		self._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			-- upvalues: (copy) self
			self:_connectCallbacks()
		end)
		self:_connectCallbacks()
	end
end
function v_u2.Disable(arg1)
	if arg1._enabled then
		arg1._enabled = false
		if arg1._cameraChangedConnection then
			arg1._cameraChangedConnection:Disconnect()
			arg1._cameraChangedConnection = nil
		end
		arg1._connectionUtil:disconnectAll()
	end
end
function v_u2.Connect(arg1, arg2, arg3)
	arg1._callbacks[arg2] = arg3
	if arg1._camera then
		arg1._connectionUtil:trackConnection(arg2, arg1._camera:GetPropertyChangedSignal(arg2):Connect(arg3))
	end
end
function v_u2.Disconnect(arg1, arg2)
	arg1._connectionUtil:disconnect(arg2)
	arg1._callbacks[arg2] = nil
end
function v_u2.getCamera(arg1)
	return arg1._camera
end
return v_u2