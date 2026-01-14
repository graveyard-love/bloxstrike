-- Decompiled with Bunni.lol Decompiler

return table.freeze({
	["ToBase64"] = function(arg1)
		return (arg1:gsub(".", function(arg1)
			local v_byte = arg1:byte()
			local v1 = ""
			for v2 = 8, 1, -1 do
				v1 = v1 .. (v_byte % 2 ^ v2 - v_byte % 2 ^ (v2 - 1) > 0 and "1" or "0")
			end
			return v1
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg1)
			if #arg1 < 6 then
				return ""
			end
			local v1 = 0
			for v2 = 1, 6 do
				v1 = v1 + (arg1:sub(v2, v2) == "1" and (2 ^ (6 - v2) or 0) or 0)
			end
			return ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(v1 + 1, v1 + 1)
		end) .. ({ "", "==", "=" })[#arg1 % 3 + 1]
	end,
	["ToString"] = function(arg1)
		return string.gsub(arg1, "[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", ""):gsub(".", function(arg1)
			if arg1 == "=" then
				return ""
			end
			local v1 = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(arg1) - 1
			local v2 = ""
			for v3 = 6, 1, -1 do
				v2 = v2 .. (v1 % 2 ^ v3 - v1 % 2 ^ (v3 - 1) > 0 and "1" or "0")
			end
			return v2
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(arg1)
			if #arg1 ~= 8 then
				return ""
			end
			local v1 = 0
			for v2 = 1, 8 do
				v1 = v1 + (arg1:sub(v2, v2) == "1" and (2 ^ (8 - v2) or 0) or 0)
			end
			return string.char(v1)
		end)
	end
})