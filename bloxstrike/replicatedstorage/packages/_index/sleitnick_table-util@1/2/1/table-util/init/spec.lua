-- Decompiled with Bunni.lol Decompiler

return function()
	local v_u1 = require(script.Parent)
	describe("Copy (Deep)", function()
		-- upvalues: (copy) v_u1
		it("should create a deep table copy", function()
			-- upvalues: (ref) v_u1
			local v1 = {}
			local v2 = {}
			local v3 = {
				["c"] = {
					["d"] = 32
				}
			}
			v2.b = v3
			v1.a = v2
			local v_copy = v_u1.Copy(v1, true)
			expect(v1).never.to.equal(v_copy)
			expect(v1.a).never.to.equal(v_copy.a)
			expect(v_copy.a.b.c.d).to.equal(v1.a.b.c.d)
		end)
	end)
	describe("Copy (Shallow)", function()
		-- upvalues: (copy) v_u1
		it("should create a shallow dictionary copy", function()
			-- upvalues: (ref) v_u1
			local v1 = {}
			local v2 = {}
			local v3 = {
				["c"] = {
					["d"] = 32
				}
			}
			v2.b = v3
			v1.a = v2
			local v_copy = v_u1.Copy(v1)
			expect(v_copy).never.to.equal(v1)
			expect(v_copy.a).to.equal(v1.a)
			expect(v_copy.a.b.c.d).to.equal(v1.a.b.c.d)
		end)
		it("should create a shallow array copy", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				10,
				20,
				30,
				40
			}
			local v_copy = v_u1.Copy(v1)
			expect(v_copy).never.to.equal(v1)
			for v2, v3 in ipairs(v1) do
				expect(v_copy[v2]).to.equal(v3)
			end
		end)
	end)
	describe("Sync", function()
		-- upvalues: (copy) v_u1
		it("should sync tables", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["a"] = 32,
				["b"] = 64,
				["c"] = 128,
				["e"] = {
					["h"] = 1
				}
			}
			local v2 = {
				["a"] = 32,
				["b"] = 10,
				["d"] = 1,
				["e"] = {
					["h"] = 2,
					["n"] = 2
				},
				["f"] = {
					["x"] = 10
				}
			}
			local v_sync = v_u1.Sync(v2, v1)
			expect(v_sync.a).to.equal(v1.a)
			expect(v_sync.b).to.equal(10)
			expect(v_sync.c).to.equal(v1.c)
			expect(v_sync.d).never.to.be.ok()
			expect(v_sync.e.h).to.equal(2)
			expect(v_sync.e.n).never.to.be.ok()
			expect(v_sync.f).never.to.be.ok()
		end)
	end)
	describe("Reconcile", function()
		-- upvalues: (copy) v_u1
		it("should reconcile table", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["kills"] = 0,
				["deaths"] = 0,
				["xp"] = 10,
				["stuff"] = {},
				["stuff2"] = "abc",
				["stuff3"] = { "data" }
			}
			local v2 = {
				["kills"] = 10,
				["deaths"] = 4,
				["stuff"] = { "abc", "xyz" },
				["extra"] = 5,
				["stuff2"] = {
					["abc"] = 10
				},
				["stuff3"] = true
			}
			local v_reconcile = v_u1.Reconcile(v2, v1)
			expect(v_reconcile).never.to.equal(v2)
			expect(v_reconcile).never.to.equal(v1)
			expect(v_reconcile.kills).to.equal(10)
			expect(v_reconcile.deaths).to.equal(4)
			expect(v_reconcile.xp).to.equal(10)
			expect(v_reconcile.stuff[1]).to.equal("abc")
			expect(v_reconcile.stuff[2]).to.equal("xyz")
			expect(v_reconcile.extra).to.equal(5)
			expect((type(v_reconcile.stuff2))).to.equal("table")
			expect(v_reconcile.stuff2).never.to.equal(v2.stuff2)
			expect(v_reconcile.stuff2.abc).to.equal(10)
			expect((type(v_reconcile.stuff3))).to.equal("boolean")
			expect(v_reconcile.stuff3).to.equal(true)
		end)
	end)
	describe("SwapRemove", function()
		-- upvalues: (copy) v_u1
		it("should swap remove index", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				1,
				2,
				3,
				4,
				5
			}
			v_u1.SwapRemove(v1, 3)
			expect(#v1).to.equal(4)
			expect(v1[3]).to.equal(5)
		end)
	end)
	describe("SwapRemoveFirstValue", function()
		-- upvalues: (copy) v_u1
		it("should swap remove first value given", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				"hello",
				"world",
				"goodbye",
				"planet"
			}
			v_u1.SwapRemoveFirstValue(v1, "world")
			expect(#v1).to.equal(3)
			expect(v1[2]).to.equal("planet")
		end)
	end)
	describe("Map", function()
		-- upvalues: (copy) v_u1
		it("should map table", function()
			-- upvalues: (ref) v_u1
			local v_map = v_u1.Map({
				{
					["FirstName"] = "John",
					["LastName"] = "Doe"
				},
				{
					["FirstName"] = "Jane",
					["LastName"] = "Smith"
				}
			}, function(arg1)
				return arg1.FirstName .. " " .. arg1.LastName
			end)
			expect(v_map[1]).to.equal("John Doe")
			expect(v_map[2]).to.equal("Jane Smith")
		end)
	end)
	describe("Filter", function()
		-- upvalues: (copy) v_u1
		it("should filter table", function()
			-- upvalues: (ref) v_u1
			local v_filter = v_u1.Filter({
				10,
				20,
				30,
				40,
				50,
				60,
				70,
				80,
				90
			}, function(arg1)
				local v1
				if arg1 >= 30 then
					v1 = arg1 <= 60
				else
					v1 = false
				end
				return v1
			end)
			expect(#v_filter).to.equal(4)
			expect(v_filter[1]).to.equal(30)
			expect(v_filter[#v_filter]).to.equal(60)
		end)
	end)
	describe("Reduce", function()
		-- upvalues: (copy) v_u1
		it("should reduce table with numbers", function()
			-- upvalues: (ref) v_u1
			local v_reduce = v_u1.Reduce({
				1,
				2,
				3,
				4,
				5
			}, function(arg1, arg2)
				return arg1 + arg2
			end)
			expect(v_reduce).to.equal(15)
		end)
		it("should reduce table", function()
			-- upvalues: (ref) v_u1
			local v_reduce = v_u1.Reduce({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(arg1, arg2)
				return arg1 + arg2.Score
			end, 0)
			expect(v_reduce).to.equal(60)
		end)
		it("should reduce table with initial value", function()
			-- upvalues: (ref) v_u1
			local v_reduce = v_u1.Reduce({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(arg1, arg2)
				return arg1 + arg2.Score
			end, 40)
			expect(v_reduce).to.equal(100)
		end)
		it("should reduce functions", function()
			-- upvalues: (ref) v_u1
			local v1 = v_u1.Reduce({ function(arg1)
					return arg1 * arg1
				end, function(arg1)
					return arg1 * 2
				end }, function(arg1, arg2)
				return function(arg1)
					-- upvalues: (copy) arg1, (copy) arg2
					return arg1(arg2(arg1))
				end
			end)(10)
			expect(v1).to.equal(400)
		end)
	end)
	describe("Assign", function()
		-- upvalues: (copy) v_u1
		it("should assign tables", function()
			-- upvalues: (ref) v_u1
			local v_assign = v_u1.Assign({
				["a"] = 32,
				["x"] = 100
			}, {
				["b"] = 64,
				["c"] = 128
			}, {
				["a"] = 10,
				["c"] = 100,
				["d"] = 200
			})
			expect(v_assign.a).to.equal(10)
			expect(v_assign.b).to.equal(64)
			expect(v_assign.c).to.equal(100)
			expect(v_assign.d).to.equal(200)
			expect(v_assign.x).to.equal(100)
		end)
	end)
	describe("Extend", function()
		-- upvalues: (copy) v_u1
		it("should extend tables", function()
			-- upvalues: (ref) v_u1
			local v_extend = v_u1.Extend({ "a", "b", "c" }, { "d", "e", "f" })
			expect(table.concat(v_extend)).to.equal("abcdef")
		end)
	end)
	describe("Reverse", function()
		-- upvalues: (copy) v_u1
		it("should create a table in reverse", function()
			-- upvalues: (ref) v_u1
			local v_reverse = v_u1.Reverse({ 1, 2, 3 })
			expect(table.concat(v_reverse)).to.equal("321")
		end)
	end)
	describe("Shuffle", function()
		-- upvalues: (copy) v_u1
		it("should shuffle a table", function()
			-- upvalues: (ref) v_u1
			local v_u1 = {
				1,
				2,
				3,
				4,
				5
			}
			expect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.Shuffle(v_u1)
			end).never.to.throw()
		end)
	end)
	describe("Sample", function()
		-- upvalues: (copy) v_u1
		it("should sample a table", function()
			-- upvalues: (ref) v_u1
			local v_sample = v_u1.Sample({
				1,
				2,
				3,
				4,
				5
			}, 3)
			expect(#v_sample).to.equal(3)
		end)
	end)
	describe("Flat", function()
		-- upvalues: (copy) v_u1
		it("should flatten table", function()
			-- upvalues: (ref) v_u1
			local v_flat = v_u1.Flat({
				1,
				2,
				3,
				{
					4,
					5,
					{ 6, 7 }
				}
			}, 3)
			expect(table.concat(v_flat)).to.equal("1234567")
		end)
	end)
	describe("FlatMap", function()
		-- upvalues: (copy) v_u1
		it("should map and flatten table", function()
			-- upvalues: (ref) v_u1
			local v_flatmap = v_u1.FlatMap({
				1,
				2,
				3,
				4,
				5,
				6,
				7
			}, function(arg1)
				return { arg1, arg1 * 2 }
			end)
			expect(table.concat(v_flatmap)).to.equal("12243648510612714")
		end)
	end)
	describe("Keys", function()
		-- upvalues: (copy) v_u1
		it("should give all keys of table", function()
			-- upvalues: (ref) v_u1
			local v_keys = v_u1.Keys({
				["a"] = 1,
				["b"] = 2,
				["c"] = 3
			})
			expect(#v_keys).to.equal(3)
			expect(table.find(v_keys, "a")).to.be.ok()
			expect(table.find(v_keys, "b")).to.be.ok()
			expect(table.find(v_keys, "c")).to.be.ok()
		end)
	end)
	describe("Values", function()
		-- upvalues: (copy) v_u1
		it("should give all values of table", function()
			-- upvalues: (ref) v_u1
			local v_values = v_u1.Values({
				["a"] = 1,
				["b"] = 2,
				["c"] = 3
			})
			expect(#v_values).to.equal(3)
			expect(table.find(v_values, 1)).to.be.ok()
			expect(table.find(v_values, 2)).to.be.ok()
			expect(table.find(v_values, 3)).to.be.ok()
		end)
	end)
	describe("Find", function()
		-- upvalues: (copy) v_u1
		it("should find item in array", function()
			-- upvalues: (ref) v_u1
			local v_find, v1 = v_u1.Find({ 10, 20, 30 }, function(arg1)
				return arg1 == 20
			end)
			expect(v_find).to.be.ok()
			expect(v1).to.equal(2)
			expect(v_find).to.equal(20)
		end)
		it("should find item in dictionary", function()
			-- upvalues: (ref) v_u1
			local v_find, v1 = v_u1.Find({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(arg1)
				return arg1.Score == 20
			end)
			expect(v_find).to.be.ok()
			expect(v1).to.equal(2)
			expect(v_find.Score).to.equal(20)
		end)
	end)
	describe("Every", function()
		-- upvalues: (copy) v_u1
		it("should see every value is above 20", function()
			-- upvalues: (ref) v_u1
			local v_every = v_u1.Every({ 21, 40, 200 }, function(arg1)
				return arg1 > 20
			end)
			expect(v_every).to.equal(true)
		end)
		it("should see every value is not above 20", function()
			-- upvalues: (ref) v_u1
			local v_every = v_u1.Every({ 20, 40, 200 }, function(arg1)
				return arg1 > 20
			end)
			expect(v_every).never.to.equal(true)
		end)
	end)
	describe("Some", function()
		-- upvalues: (copy) v_u1
		it("should see some value is above 20", function()
			-- upvalues: (ref) v_u1
			local v_some = v_u1.Some({ 5, 40, 1 }, function(arg1)
				return arg1 > 20
			end)
			expect(v_some).to.equal(true)
		end)
		it("should see some value is not above 20", function()
			-- upvalues: (ref) v_u1
			local v_some = v_u1.Some({ 5, 15, 1 }, function(arg1)
				return arg1 > 20
			end)
			expect(v_some).never.to.equal(true)
		end)
	end)
	describe("Truncate", function()
		-- upvalues: (copy) v_u1
		it("should truncate an array", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				1,
				2,
				3,
				4,
				5
			}
			local v_truncate = v_u1.Truncate(v1, 3)
			expect(#v_truncate).to.equal(3)
			expect(v_truncate[1]).to.equal(v1[1])
			expect(v_truncate[2]).to.equal(v1[2])
			expect(v_truncate[3]).to.equal(v1[3])
		end)
		it("should truncate an array with out of bounds sizes", function()
			-- upvalues: (ref) v_u1
			local v_u1 = {
				1,
				2,
				3,
				4,
				5
			}
			expect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.Truncate(v_u1, -1)
			end).to.never.throw()
			expect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.Truncate(v_u1, #v_u1 + 1)
			end).to.never.throw()
			local v_truncate = v_u1.Truncate(v_u1, #v_u1 + 10)
			expect(#v_truncate).to.equal(#v_u1)
			expect(v_truncate).to.never.equal(v_u1)
		end)
	end)
	describe("Lock", function()
		-- upvalues: (copy) v_u1
		it("should lock a table", function()
			-- upvalues: (ref) v_u1
			local v_u1 = {}
			local v2 = {
				["xyz"] = {
					["num"] = 32
				}
			}
			v_u1.abc = v2
			expect(function()
				-- upvalues: (copy) v_u1
				v_u1.abc.xyz.num = 64
			end).never.to.throw()
			local v_lock = v_u1.Lock(v_u1)
			expect(v_u1.abc.xyz.num).to.equal(64)
			expect(v_u1).to.equal(v_lock)
			expect(function()
				-- upvalues: (copy) v_u1
				v_u1.abc.xyz.num = 10
			end).to.throw()
		end)
	end)
	describe("Zip", function()
		-- upvalues: (copy) v_u1
		it("should zip arrays together", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				1,
				2,
				3,
				4,
				5
			}
			local v2 = {
				9,
				8,
				7,
				6,
				5
			}
			local v3 = {
				1,
				1,
				1,
				1,
				1
			}
			local v4 = 0
			for v5, v6 in v_u1.Zip(v1, v2, v3) do
				expect(v6[1]).to.equal(v1[v5])
				expect(v6[2]).to.equal(v2[v5])
				expect(v6[3]).to.equal(v3[v5])
				v4 = v5
			end
			expect(v4).to.equal((math.min(#v1, #v2, #v3)))
		end)
		it("should zip arrays of different lengths together", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				1,
				2,
				3,
				4,
				5
			}
			local v2 = {
				9,
				8,
				7,
				6
			}
			local v3 = { 1, 1, 1 }
			local v4 = 0
			for v5, v6 in v_u1.Zip(v1, v2, v3) do
				expect(v6[1]).to.equal(v1[v5])
				expect(v6[2]).to.equal(v2[v5])
				expect(v6[3]).to.equal(v3[v5])
				v4 = v5
			end
			expect(v4).to.equal((math.min(#v1, #v2, #v3)))
		end)
		it("should zip maps together", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["a"] = 10,
				["b"] = 20,
				["c"] = 30
			}
			local v2 = {
				["a"] = 100,
				["b"] = 200,
				["c"] = 300
			}
			local v3 = {
				["a"] = 3000,
				["b"] = 2000,
				["c"] = 3000
			}
			for v4, v5 in v_u1.Zip(v1, v2, v3) do
				expect(v5[1]).to.equal(v1[v4])
				expect(v5[2]).to.equal(v2[v4])
				expect(v5[3]).to.equal(v3[v4])
			end
		end)
		it("should zip maps of different keys together", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["a"] = 10,
				["b"] = 20,
				["c"] = 30,
				["d"] = 40
			}
			local v2 = {
				["a"] = 100,
				["b"] = 200,
				["c"] = 300,
				["z"] = 10
			}
			local v3 = {
				["a"] = 3000,
				["b"] = 2000,
				["c"] = 3000,
				["x"] = 0
			}
			for v4, v5 in v_u1.Zip(v1, v2, v3) do
				expect(v5[1]).to.equal(v1[v4])
				expect(v5[2]).to.equal(v2[v4])
				expect(v5[3]).to.equal(v3[v4])
			end
		end)
	end)
	describe("IsEmpty", function()
		-- upvalues: (copy) v_u1
		it("should detect that table is empty", function()
			-- upvalues: (ref) v_u1
			local v_isempty = v_u1.IsEmpty({})
			expect(v_isempty).to.equal(true)
		end)
		it("should detect that array is not empty", function()
			-- upvalues: (ref) v_u1
			local v_isempty = v_u1.IsEmpty({ 10, 20, 30 })
			expect(v_isempty).to.equal(false)
		end)
		it("should detect that dictionary is not empty", function()
			-- upvalues: (ref) v_u1
			local v_isempty = v_u1.IsEmpty({
				["a"] = 10,
				["b"] = 20,
				["c"] = 30
			})
			expect(v_isempty).to.equal(false)
		end)
	end)
	describe("JSON", function()
		-- upvalues: (copy) v_u1
		it("should encode json", function()
			-- upvalues: (ref) v_u1
			local v_encodejson = v_u1.EncodeJSON({
				["hello"] = "world"
			})
			expect(v_encodejson).to.equal("{\"hello\":\"world\"}")
		end)
		it("should decode json", function()
			-- upvalues: (ref) v_u1
			local v_decodejson = v_u1.DecodeJSON("{\"hello\":\"world\"}")
			expect(v_decodejson).to.be.a("table")
			expect(v_decodejson.hello).to.equal("world")
		end)
	end)
end