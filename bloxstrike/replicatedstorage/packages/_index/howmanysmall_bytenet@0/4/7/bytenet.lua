-- Decompiled with Bunni.lol Decompiler

local v_run = game:GetService("RunService")
local v1 = require(script.dataTypes.array)
local v2 = require(script.dataTypes.bool)
local v3 = require(script.dataTypes.buff)
local v4 = require(script.dataTypes.cframe)
local v5 = require(script.process.client)
local v6 = require(script.packets.definePacket)
local v7 = require(script.dataTypes.float32)
local v8 = require(script.dataTypes.float64)
local v9 = require(script.dataTypes.inst)
local v10 = require(script.dataTypes.int16)
local v11 = require(script.dataTypes.int32)
local v12 = require(script.dataTypes.int8)
local v13 = require(script.dataTypes.map)
local v14 = require(script.namespaces.namespace)
local v15 = require(script.dataTypes.nothing)
local v16 = require(script.dataTypes.optional)
local v17 = require(script.process.server)
local v18 = require(script.dataTypes.string)
local v19 = require(script.dataTypes.struct)
require(script.types)
local v20 = require(script.dataTypes.uint16)
local v21 = require(script.dataTypes.uint32)
local v22 = require(script.dataTypes.uint8)
local v23 = require(script.dataTypes.unknown)
local v24 = require(script.replicated.values)
local v25 = require(script.dataTypes.vec2)
local v26 = require(script.dataTypes.vec3)
v24.start()
if v_run:IsServer() then
	v17.start()
else
	v5.start()
end
local v27 = v2()
local v28 = v3()
local v29 = v9()
local v30 = v15()
local v31 = v25()
local v32 = v26()
return table.freeze({
	["DefinePacket"] = v6,
	["DefineNamespace"] = v14,
	["Array"] = v1,
	["Bool"] = v27,
	["Buff"] = v28,
	["CFrame"] = v4(),
	["Float32"] = v7(),
	["Float64"] = v8(),
	["Inst"] = v29,
	["Int16"] = v10(),
	["Int32"] = v11(),
	["Int8"] = v12(),
	["Map"] = v13,
	["Nothing"] = v30,
	["Optional"] = v16,
	["String"] = v18(),
	["Struct"] = v19,
	["Uint16"] = v20(),
	["Uint32"] = v21(),
	["Uint8"] = v22(),
	["Unknown"] = v23(),
	["Vec2"] = v31,
	["Vec3"] = v32,
	["Boolean"] = v27,
	["Buffer"] = v28,
	["Instance"] = v29,
	["Nil"] = v30,
	["Vector2"] = v31,
	["Vector3"] = v32
})