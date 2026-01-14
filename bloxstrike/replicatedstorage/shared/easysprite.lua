-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local function v_u2(arg1, arg2)
	local v_u1 = {
		["totalCells"] = #arg1,
		["instance"] = arg2,
		["_frames"] = arg1,
		["display"] = function(arg1)
			-- upvalues: (copy) arg1, (copy) arg2, (copy) v_u1
			if not arg1[arg1] then
				error((("index %* out of range in spritesheet"):format(arg1)))
			end
			local v1 = arg1[arg1]
			if arg2.Image ~= v1.url then
				arg2.Image = v1.url
			end
			local v_imagerectsize = arg2.ImageRectSize
			local v_size = v1.size
			local v2
			if v_imagerectsize.X ^ 2 == v_size.X ^ 2 then
				v2 = v_imagerectsize.Y ^ 2 == v_size.Y ^ 2
			else
				v2 = false
			end
			if not v2 then
				arg2.ImageRectSize = v1.size
			end
			local v3 = arg2
			local v_new = Vector2.new
			local v4
			if v_u1.isMirroredX() then
				v4 = v1.offset.X - arg2.ImageRectSize.X
			else
				v4 = v1.offset.X
			end
			local v5
			if v_u1.isMirroredY() then
				v5 = v1.offset.Y - arg2.ImageRectSize.Y
			else
				v5 = v1.offset.Y
			end
			v3.ImageRectOffset = v_new(v4, v5)
			v_u1.currentCell = arg1
		end,
		["flip"] = function()
			-- upvalues: (copy) v_u1
			v_u1.mirrorX()
		end,
		["mirrorX"] = function()
			-- upvalues: (copy) arg2, (copy) v_u1
			arg2.ImageRectSize = arg2.ImageRectSize * Vector2.new(-1, 1)
			v_u1.display(v_u1.currentCell)
		end,
		["mirrorY"] = function()
			-- upvalues: (copy) arg2, (copy) v_u1
			arg2.ImageRectSize = arg2.ImageRectSize * Vector2.new(1, -1)
			v_u1.display(v_u1.currentCell)
		end,
		["isFlipped"] = function()
			-- upvalues: (copy) v_u1
			v_u1.isMirroredX()
		end,
		["isMirroredX"] = function()
			-- upvalues: (copy) arg2
			return arg2.ImageRectSize.X < 0
		end,
		["isMirroredY"] = function()
			-- upvalues: (copy) arg2
			return arg2.ImageRectSize.Y < 0
		end,
		["extend"] = function(arg1)
			-- upvalues: (copy) arg1, (copy) v_u1
			for _, v1 in arg1._frames do
				arg1[#arg1 + 1] = v1
			end
			v_u1.totalCells = #arg1
		end,
		["length"] = function()
			-- upvalues: (copy) arg1
			return #arg1
		end
	}
	v_u1.display(1)
	return v_u1
end
function v1.new(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2
	local v_imagelabel = arg1:IsA("ImageLabel")
	assert(v_imagelabel, "Instance must be an ImageLabel")
	local v1 = arg3 / arg4
	local v_floor = math.floor(v1.X)
	local v_floor = math.floor(v1.Y)
	arg1.Image = arg2
	arg1.ImageRectSize = arg4
	arg1.ImageRectOffset = Vector2.zero
	local v2 = 0
	local v3 = {}
	while true do
		local v4 = 0
		repeat
			v3[v2 * v_floor + v4 + 1] = {
				["offset"] = Vector2.new(arg4.X * v4, arg4.Y * v2),
				["url"] = arg2,
				["size"] = arg4
			}
			v4 = v4 + 1
		until v_floor <= v4
		v2 = v2 + 1
		if v_floor <= v2 then
			return v_u2(v3, arg1)
		end
	end
end
return v1