-- Decompiled with Bunni.lol Decompiler

local v1 = {
	["add"] = require(script.add),
	["copy"] = require(script.copy),
	["count"] = require(script.count),
	["delete"] = require(script.delete),
	["difference"] = require(script.difference),
	["differenceSymmetric"] = require(script.differenceSymmetric),
	["filter"] = require(script.filter),
	["fromArray"] = require(script.fromArray),
	["has"] = require(script.has),
	["intersection"] = require(script.intersection),
	["isSubset"] = require(script.isSubset),
	["isSuperset"] = require(script.isSuperset),
	["map"] = require(script.map),
	["merge"] = require(script.merge),
	["toArray"] = require(script.toArray)
}
v1.fromList = v1.fromArray
v1.join = v1.merge
v1.subtract = v1.delete
v1.union = v1.merge
return v1