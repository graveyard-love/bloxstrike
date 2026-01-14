-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Packages.ByteNet)
local v_u2 = require(script.DefinePacket)
return table.freeze({
	["PlayerData"] = v_u1.DefineNamespace("PlayerData", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.RetrieveAllPlayerData = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Player"] = v_u1.Instance,
			["Data"] = v_u1.Unknown
		})
		v1.PlayerDataEvent = v_u2(v_u1.DefinePacket(v2))
		local v3 = {}
		v3.Value = v_u1.Struct({
			["Player"] = v_u1.Instance,
			["Data"] = v_u1.Map(v_u1.String, v_u1.Unknown)
		})
		v1.PlayerDataChanged = v_u2(v_u1.DefinePacket(v3))
		return v1
	end),
	["Player"] = v_u1.DefineNamespace("Player", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Path"] = v_u1.String,
			["Value"] = v_u1.Unknown
		})
		v1.UpdatePlayerSettings = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 3
		})
		v1.UpdateMobileButtons = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Map(v_u1.String, v_u1.Unknown)
		}), {
			["maximum_requests_per_second"] = 3
		})
		v1.BlankRequest = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Float64
		}), {
			["maximum_requests_per_second"] = 1
		})
		v1.ReportPlayerConnect = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}), {
			["maximum_requests_per_second"] = 1
		})
		v1.AFKTeleport = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}), {
			["maximum_requests_per_second"] = 1
		})
		return v1
	end),
	["VoteKick"] = v_u1.DefineNamespace("VoteKick", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Amount"] = v_u1.Uint8,
			["Voter"] = v_u1.String
		})
		v1.VoteNo = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 1
		})
		local v3 = {}
		v3.Value = v_u1.Struct({
			["Amount"] = v_u1.Uint8,
			["Voter"] = v_u1.String
		})
		v1.VoteYes = v_u2(v_u1.DefinePacket(v3), {
			["maximum_requests_per_second"] = 1
		})
		local v4 = {}
		v4.Value = v_u1.Struct({
			["TargetUserId"] = v_u1.String,
			["VoterUserId"] = v_u1.String
		})
		v1.StartVote = v_u2(v_u1.DefinePacket(v4), {
			["maximum_requests_per_second"] = 1
		})
		v1.EndVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}), {
			["maximum_requests_per_second"] = 1
		})
		v1.CallVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}), {
			["maximum_requests_per_second"] = 1
		})
		return v1
	end),
	["Character"] = v_u1.DefineNamespace("Character", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.CharacterDamaged = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.CharacterDied = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Headshot"] = v_u1.Bool,
			["Damage"] = v_u1.Float32
		})
		v1.CharacterFlinch = v_u2(v_u1.DefinePacket(v2))
		v1.UpdateWalkState = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Bool
		}))
		v1.UpdateCrouchState = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Bool
		}))
		v1.FallDamage = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Float32
		}))
		v1.UpdateLookAngle = v_u2(v_u1.DefinePacket({
			["ReliabilityType"] = "Unreliable",
			["Value"] = v_u1.Float32
		}), {
			["maximum_requests_per_second"] = 30
		})
		local v3 = {
			["ReliabilityType"] = "Unreliable"
		}
		v3.Value = v_u1.Struct({
			["Player"] = v_u1.Instance,
			["Angle"] = v_u1.Float32
		})
		v1.ReplicateLookAngle = v_u2(v_u1.DefinePacket(v3))
		return v1
	end),
	["Sound"] = v_u1.DefineNamespace("Sound", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Position"] = v_u1.Optional(v_u1.Vec3),
			["Parent"] = v_u1.Optional(v_u1.Instance),
			["Duration"] = v_u1.Optional(v_u1.String),
			["Path"] = v_u1.Optional(v_u1.String),
			["Class"] = v_u1.String,
			["Name"] = v_u1.String
		})
		v1.ReplicateSound = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 25
		})
		local v3 = {}
		v3.Value = v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["Radius"] = v_u1.Float32
		})
		v1.StopSoundAtPosition = v_u2(v_u1.DefinePacket(v3))
		return v1
	end),
	["Store"] = v_u1.DefineNamespace("Store", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["InventoryItem"] = v_u1.Map(v_u1.String, v_u1.Unknown),
			["CaseId"] = v_u1.String,
			["CaseIdentifier"] = v_u1.String
		})
		v1.CaseOpened = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 1
		})
		v1.CaseOpenDenied = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Struct({})
		}), {
			["maximum_requests_per_second"] = 1
		})
		local v3 = {}
		v3.Value = v_u1.Struct({
			["CaseIdentifier"] = v_u1.String,
			["CaseId"] = v_u1.String
		})
		v1.OpenCase = v_u2(v_u1.DefinePacket(v3), {
			["maximum_requests_per_second"] = 1
		})
		local v4 = {}
		v4.Value = v_u1.Struct({
			["CaseIdentifier"] = v_u1.String
		})
		v1.CaseOpenSequenceFinished = v_u2(v_u1.DefinePacket(v4), {
			["maximum_requests_per_second"] = 2
		})
		local v5 = {}
		v5.Value = v_u1.Struct({
			["Items"] = v_u1.Array(v_u1.Map(v_u1.String, v_u1.Unknown)),
			["Player"] = v_u1.String
		})
		v1.NewInventoryItem = v_u2(v_u1.DefinePacket(v5), {
			["maximum_requests_per_second"] = 8
		})
		local v6 = {}
		v6.Value = v_u1.Struct({
			["RecipientUserId"] = v_u1.String,
			["CaseId"] = v_u1.String
		})
		v1.GiftCase = v_u2(v_u1.DefinePacket(v6), {
			["maximum_requests_per_second"] = 1
		})
		local v7 = {}
		v7.Value = v_u1.Struct({
			["CaseId"] = v_u1.String,
			["Amount"] = v_u1.Uint8
		})
		v1.PurchaseCase = v_u2(v_u1.DefinePacket(v7), {
			["maximum_requests_per_second"] = 3
		})
		local v8 = {}
		v8.Value = v_u1.Struct({
			["RecipientUserId"] = v_u1.String,
			["ProductName"] = v_u1.String,
			["ProductType"] = v_u1.String
		})
		v1.CreateGift = v_u2(v_u1.DefinePacket(v8), {
			["maximum_requests_per_second"] = 1
		})
		return v1
	end),
	["Spectate"] = v_u1.DefineNamespace("Spectate", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.UpdateCameraCFrame = v_u2(v_u1.DefinePacket({
			["ReliabilityType"] = "Unreliable",
			["Value"] = v_u1.CFrame
		}), {
			["maximum_requests_per_second"] = 60
		})
		v1.SetSpectatePerspective = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.SpectatePlayer = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.StartSpectating = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.StopSpectating = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.ReplicateSpectateEvent = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		return v1
	end),
	["Dashboard"] = v_u1.DefineNamespace("Dashboard", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.RedeemCode = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}), {
			["maximum_requests_per_second"] = 1
		})
		v1.RedeemLikeAndFavoriteReward = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}), {
			["maximum_requests_per_second"] = 1
		})
		return v1
	end),
	["Map"] = v_u1.DefineNamespace("Map", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.SubmitMapVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.StartMapVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Array(v_u1.String)
		}))
		v1.UpdateMapVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Map(v_u1.String, v_u1.Uint8)
		}))
		v1.EndMapVote = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		return v1
	end),
	["Inventory"] = v_u1.DefineNamespace("Inventory", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.RemoveInventoryItem = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		local v2 = {}
		local v3 = {
			["customProperties"] = v_u1.Optional(v_u1.Map(v_u1.String, v_u1.Unknown)),
			["OriginalOwner"] = v_u1.Optional(v_u1.String),
			["StatTrack"] = v_u1.Unknown,
			["NameTag"] = v_u1.Unknown,
			["Charm"] = v_u1.Unknown,
			["Float"] = v_u1.Float32,
			["identifier"] = v_u1.String,
			["shouldEquip"] = v_u1.Optional(v_u1.Bool),
			["weapon"] = v_u1.String,
			["skin"] = v_u1.String,
			["slot"] = v_u1.Uint8,
			["_id"] = v_u1.String
		}
		local v4 = {
			["Sticker"] = v_u1.String
		}
		v4.Position = v_u1.Struct({
			["X"] = v_u1.Float32,
			["Y"] = v_u1.Float32,
			["Rotation"] = v_u1.Float32
		})
		v3.Stickers = v_u1.Array(v_u1.Struct(v4))
		v2.Value = v_u1.Struct(v3)
		v1.NewInventoryItem = v_u2(v_u1.DefinePacket(v2))
		local v5 = {}
		v5.Value = v_u1.Struct({
			["Player"] = v_u1.Instance,
			["Identifier"] = v_u1.String,
			["StatTrack"] = v_u1.Uint32
		})
		v1.UpdateStatTrack = v_u2(v_u1.DefinePacket(v5))
		v1.CleanupGameLoadout = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		local v6 = {}
		local v7 = {}
		v7._items = v_u1.Array(v_u1.Struct({
			["Identifier"] = v_u1.String
		}))
		v7._settings = v_u1.Struct({
			["_strict_slot_space"] = v_u1.Uint8,
			["_strict_type"] = v_u1.String
		})
		v6.Value = v_u1.Array(v_u1.Struct(v7))
		v1.CreateGameLoadout = v_u2(v_u1.DefinePacket(v6))
		v1.RequestSpectatedPlayerInventory = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Instance
		}))
		local v8 = {}
		local v9 = {
			["Player"] = v_u1.Instance
		}
		local v10 = {}
		local v11 = {
			["Identifier"] = v_u1.String,
			["Name"] = v_u1.String,
			["Slot"] = v_u1.Uint8
		}
		v11.Properties = v_u1.Struct({
			["Class"] = v_u1.String,
			["Icon"] = v_u1.String,
			["Slot"] = v_u1.String
		})
		v10._items = v_u1.Array(v_u1.Struct(v11))
		v10._settings = v_u1.Struct({
			["_strict_slot_space"] = v_u1.Uint8,
			["_strict_type"] = v_u1.String
		})
		v9.Inventory = v_u1.Array(v_u1.Struct(v10))
		v8.Value = v_u1.Struct(v9)
		v1.SpectatedPlayerInventory = v_u2(v_u1.DefinePacket(v8))
		local v12 = {}
		v12.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["PreviousIdentifier"] = v_u1.Optional(v_u1.String)
		})
		v1.WeaponEquipped = v_u2(v_u1.DefinePacket(v12))
		local v13 = {}
		v13.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["Equipment"] = v_u1.Bool
		})
		v1.ReturnBuyMenuPurchase = v_u2(v_u1.DefinePacket(v13))
		local v14 = {}
		v14.Value = v_u1.Struct({
			["Name"] = v_u1.String,
			["Equipment"] = v_u1.Bool,
			["Path"] = v_u1.String
		})
		v1.BuyMenuPurchase = v_u2(v_u1.DefinePacket(v14), {
			["maximum_requests_per_second"] = 3
		})
		local v15 = {}
		v15.Value = v_u1.Struct({
			["Identity"] = v_u1.String
		})
		v1.PickupWeapon = v_u2(v_u1.DefinePacket(v15), {
			["maximum_requests_per_second"] = 3
		})
		local v16 = {}
		v16.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["Direction"] = v_u1.Vec3
		})
		v1.DropWeapon = v_u2(v_u1.DefinePacket(v16), {
			["maximum_requests_per_second"] = 5
		})
		v1.UpdateScopeIncrement = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Uint8
		}), {
			["maximum_requests_per_second"] = 10
		})
		local v17 = {}
		v17.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["State"] = v_u1.Bool
		})
		v1.UpdateWeaponSuppressor = v_u2(v_u1.DefinePacket(v17))
		local v18 = {}
		v18.Value = v_u1.Struct({
			["WeaponId"] = v_u1.String,
			["CharmId"] = v_u1.String,
			["Position"] = v_u1.String
		})
		v1.UpdateWeaponCharm = v_u2(v_u1.DefinePacket(v18))
		local v19 = {}
		v19.Value = v_u1.Struct({
			["WeaponId"] = v_u1.String
		})
		v1.RemoveWeaponCharm = v_u2(v_u1.DefinePacket(v19))
		local v20 = {}
		v20.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["Rounds"] = v_u1.Uint16,
			["Capacity"] = v_u1.Uint16
		})
		v1.ReloadWeapon = v_u2(v_u1.DefinePacket(v20))
		local v21 = {}
		local v22 = {
			["ShootingHand"] = v_u1.String,
			["Identifier"] = v_u1.String,
			["Rounds"] = v_u1.Uint16,
			["Capacity"] = v_u1.Uint16,
			["IsSniperScoped"] = v_u1.Bool
		}
		local v23 = {
			["Direction"] = v_u1.Vec3,
			["Origin"] = v_u1.Vec3
		}
		v23.Hits = v_u1.Array(v_u1.Struct({
			["Instance"] = v_u1.Instance,
			["Position"] = v_u1.Vec3,
			["Normal"] = v_u1.Vec3,
			["Material"] = v_u1.String,
			["Distance"] = v_u1.Float32,
			["Exit"] = v_u1.Bool
		}))
		v22.Bullets = v_u1.Array(v_u1.Struct(v23))
		v21.Value = v_u1.Struct(v22)
		v1.ShootWeapon = v_u2(v_u1.DefinePacket(v21), {
			["maximum_requests_per_second"] = 20
		})
		v1.CreateMagazine = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}), {
			["maximum_requests_per_second"] = 1
		})
		local v24 = {}
		v24.Value = v_u1.Struct({
			["Identifier"] = v_u1.String,
			["Direction"] = v_u1.Vec3,
			["Position"] = v_u1.Vec3,
			["Animation"] = v_u1.String
		})
		v1.ThrowGrenade = v_u2(v_u1.DefinePacket(v24), {
			["maximum_requests_per_second"] = 1
		})
		local v25 = {}
		v25.Value = v_u1.Struct({
			["Type"] = v_u1.String,
			["Slot"] = v_u1.Uint8,
			["Team"] = v_u1.String,
			["Identifier"] = v_u1.String
		})
		v1.EquipLoadoutSkin = v_u2(v_u1.DefinePacket(v25), {
			["maximum_requests_per_second"] = 5
		})
		local v26 = {}
		v26.Value = v_u1.Struct({
			["Type"] = v_u1.String,
			["SlotOne"] = v_u1.Uint8,
			["SlotTwo"] = v_u1.Uint8,
			["Team"] = v_u1.String
		})
		v1.SwapLoadoutSkins = v_u2(v_u1.DefinePacket(v26), {
			["maximum_requests_per_second"] = 5
		})
		local v27 = {}
		v27.Value = v_u1.Struct({
			["Path"] = v_u1.String,
			["Team"] = v_u1.String,
			["Identifier"] = v_u1.String
		})
		v1.EquipSpecialItem = v_u2(v_u1.DefinePacket(v27), {
			["maximum_requests_per_second"] = 5
		})
		v1.LoadoutResponse = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Bool
		}))
		return v1
	end),
	["Projectile"] = v_u1.DefineNamespace("Projectile", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		local v3 = {
			["Id"] = v_u1.String,
			["Weapon"] = v_u1.String,
			["Skin"] = v_u1.String,
			["Float"] = v_u1.Float32,
			["StatTrack"] = v_u1.Unknown,
			["NameTag"] = v_u1.Unknown,
			["Charm"] = v_u1.Unknown
		}
		local v4 = {
			["Sticker"] = v_u1.String
		}
		v4.Position = v_u1.Struct({
			["X"] = v_u1.Float32,
			["Y"] = v_u1.Float32,
			["Rotation"] = v_u1.Float32
		})
		v3.Stickers = v_u1.Array(v_u1.Struct(v4))
		v3.State = v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["Velocity"] = v_u1.Vec3,
			["StartTime"] = v_u1.Optional(v_u1.Float64)
		})
		v3.Physics = v_u1.Struct({
			["Gravity"] = v_u1.Vec3,
			["Drag"] = v_u1.Float32,
			["Restitution"] = v_u1.Float32,
			["Radius"] = v_u1.Float32,
			["MaxBounces"] = v_u1.Uint8,
			["FuseTime"] = v_u1.Float32,
			["Step"] = v_u1.Float32,
			["RestVelocityThreshold"] = v_u1.Float32
		})
		v2.Value = v_u1.Struct(v3)
		v1.Spawn = v_u2(v_u1.DefinePacket(v2))
		local v5 = {}
		v5.Value = v_u1.Struct({
			["Id"] = v_u1.String,
			["Grenade"] = v_u1.String,
			["Position"] = v_u1.Vec3,
			["Normal"] = v_u1.Vec3,
			["Reason"] = v_u1.String
		})
		v1.Resolve = v_u2(v_u1.DefinePacket(v5))
		return v1
	end),
	["VFX"] = v_u1.DefineNamespace("VFX", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["DirectionMultiplier"] = v_u1.Float32,
			["Character"] = v_u1.Instance,
			["Direction"] = v_u1.Vec3,
			["Weapon"] = v_u1.String,
			["Part"] = v_u1.String
		})
		v1.CreateRagdoll = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 5
		})
		local v3 = {}
		v3.Value = v_u1.Struct({
			["Suppressor"] = v_u1.Optional(v_u1.String),
			["ShootingHand"] = v_u1.String,
			["PlayerName"] = v_u1.String,
			["WeaponName"] = v_u1.String
		})
		v1.CreateCharacterMuzzleFlash = v_u2(v_u1.DefinePacket(v3), {
			["maximum_requests_per_second"] = 25
		})
		local v4 = {}
		v4.Value = v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["Direction"] = v_u1.Vec3
		})
		v1.CreateBloodSplatter = v_u2(v_u1.DefinePacket(v4), {
			["maximum_requests_per_second"] = 0
		})
		local v5 = {}
		v5.Value = v_u1.Struct({
			["Instance"] = v_u1.Instance,
			["Material"] = v_u1.String,
			["Position"] = v_u1.Vec3,
			["Normal"] = v_u1.Vec3,
			["Exit"] = v_u1.Bool,
			["Ricochet"] = v_u1.Bool
		})
		v1.CreateImpact = v_u2(v_u1.DefinePacket(v5), {
			["maximum_requests_per_second"] = 25
		})
		local v6 = {}
		v6.Value = v_u1.Struct({
			["Instance"] = v_u1.Instance,
			["Type"] = v_u1.String,
			["Position"] = v_u1.Vec3,
			["Normal"] = v_u1.Vec3
		})
		v1.CreateMarker = v_u2(v_u1.DefinePacket(v6), {
			["maximum_requests_per_second"] = 25
		})
		local v7 = {}
		v7.Value = v_u1.Struct({
			["Distance"] = v_u1.Float32,
			["Origin"] = v_u1.Vec3,
			["Target"] = v_u1.Vec3
		})
		v1.CreateTracer = v_u2(v_u1.DefinePacket(v7), {
			["maximum_requests_per_second"] = 25
		})
		v1.CleanupDebris = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		local v8 = {}
		v8.Value = v_u1.Struct({
			["Instance"] = v_u1.Instance,
			["Position"] = v_u1.Vec3,
			["Direction"] = v_u1.Vec3
		})
		v1.BreakGlass = v_u2(v_u1.DefinePacket(v8), {
			["maximum_requests_per_second"] = 25
		})
		local v9 = {}
		local v10 = {
			["SmokeId"] = v_u1.String,
			["Duration"] = v_u1.Float32,
			["DeployTime"] = v_u1.Float32
		}
		v10.Voxels = v_u1.Array(v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["Size"] = v_u1.Float32
		}))
		v9.Value = v_u1.Struct(v10)
		v1.CreateVoxelSmoke = v_u2(v_u1.DefinePacket(v9))
		v1.DestroyVoxelSmoke = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		local v11 = {}
		v11.Value = v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["Radius"] = v_u1.Float32,
			["Duration"] = v_u1.Float32
		})
		v1.DisruptVoxelSmoke = v_u2(v_u1.DefinePacket(v11))
		local v12 = {}
		local v13 = {
			["FireId"] = v_u1.String,
			["Duration"] = v_u1.Float32
		}
		v13.Voxels = v_u1.Array(v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["SizeX"] = v_u1.Float32,
			["SizeZ"] = v_u1.Float32,
			["Normal"] = v_u1.Vec3
		}))
		v12.Value = v_u1.Struct(v13)
		v1.CreateVoxelFire = v_u2(v_u1.DefinePacket(v12))
		v1.DestroyVoxelFire = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		local v14 = {}
		local v15 = {
			["FireId"] = v_u1.String
		}
		v15.Voxels = v_u1.Array(v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["SizeX"] = v_u1.Float32,
			["SizeZ"] = v_u1.Float32,
			["Normal"] = v_u1.Vec3
		}))
		v14.Value = v_u1.Struct(v15)
		v1.UpdateVoxelFire = v_u2(v_u1.DefinePacket(v14))
		local v16 = {}
		v16.Value = v_u1.Struct({
			["Position"] = v_u1.Vec3,
			["AttackerUserId"] = v_u1.Optional(v_u1.Int32)
		})
		v1.FlashPlayer = v_u2(v_u1.DefinePacket(v16))
		return v1
	end),
	["C4"] = v_u1.DefineNamespace("C4", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.Defused = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.StartDefuse = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.CancelDefuse = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.Planted = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.Start = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.Cancel = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		v1.ForceCancel = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		return v1
	end),
	["Hostage"] = v_u1.DefineNamespace("Hostage", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.StartRescue = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.CancelRescue = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		v1.PickedUp = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Nothing
		}))
		return v1
	end),
	["Melee"] = v_u1.DefineNamespace("Melee", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["Direction"] = v_u1.Vec3,
			["Material"] = v_u1.String,
			["Distance"] = v_u1.Float32,
			["Instance"] = v_u1.Instance,
			["Position"] = v_u1.Vec3,
			["Normal"] = v_u1.Vec3,
			["MeleeAttack"] = v_u1.String,
			["Identifier"] = v_u1.String
		})
		v1.MeleeAttack = v_u2(v_u1.DefinePacket(v2), {
			["maximum_requests_per_second"] = 5
		})
		return v1
	end),
	["Chat"] = v_u1.DefineNamespace("Chat", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["displayName"] = v_u1.String,
			["team"] = v_u1.String,
			["message"] = v_u1.String,
			["alive"] = v_u1.Bool,
			["role"] = v_u1.Uint8,
			["verified"] = v_u1.Bool
		})
		v1.ServerChat = v_u2(v_u1.DefinePacket(v2))
		local v3 = {}
		v3.Value = v_u1.Struct({
			["displayName"] = v_u1.String,
			["team"] = v_u1.String,
			["message"] = v_u1.String,
			["alive"] = v_u1.Bool,
			["role"] = v_u1.Uint8,
			["verified"] = v_u1.Bool
		})
		v1.ServerTeamChat = v_u2(v_u1.DefinePacket(v3))
		local v4 = {}
		v4.Value = v_u1.Struct({
			["name"] = v_u1.String,
			["team"] = v_u1.String
		})
		v1.ChatTeamJoin = v_u2(v_u1.DefinePacket(v4))
		local v5 = {}
		v5.Value = v_u1.Struct({
			["params"] = v_u1.Map(v_u1.String, v_u1.Unknown)
		})
		v1.ChatPlayerKilled = v_u2(v_u1.DefinePacket(v5))
		local v6 = {}
		v6.Value = v_u1.Struct({
			["weaponName"] = v_u1.Optional(v_u1.String),
			["amount"] = v_u1.String,
			["source"] = v_u1.String
		})
		v1.ChatMoneyReward = v_u2(v_u1.DefinePacket(v6))
		local v7 = {}
		v7.Value = v_u1.Struct({
			["displayName"] = v_u1.String,
			["team"] = v_u1.String,
			["weaponName"] = v_u1.String,
			["skinName"] = v_u1.String,
			["rarity"] = v_u1.String,
			["statTrak"] = v_u1.Bool
		})
		v1.ChatCaseOpened = v_u2(v_u1.DefinePacket(v7))
		local v8 = {}
		v8.Value = v_u1.Struct({
			["name"] = v_u1.String
		})
		v1.ChatPlayerLeave = v_u2(v_u1.DefinePacket(v8))
		local v9 = {}
		v9.Value = v_u1.Struct({
			["Text"] = v_u1.String,
			["Mode"] = v_u1.Uint8
		})
		v1.ClientChat = v_u2(v_u1.DefinePacket(v9), {
			["maximum_requests_per_second"] = 5
		})
		return v1
	end),
	["UI"] = v_u1.DefineNamespace("UI", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["notificationType"] = v_u1.String,
			["text"] = v_u1.String
		})
		v1.CreateMenuNotification = v_u2(v_u1.DefinePacket(v2))
		v1.RoundWinner = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}))
		local v3 = {}
		v3.Value = v_u1.Struct({
			["PlayerName"] = v_u1.String,
			["Team"] = v_u1.String,
			["Reason"] = v_u1.String
		})
		v1.RoundMVP = v_u2(v_u1.DefinePacket(v3))
		local v4 = {}
		v4.Value = v_u1.Struct({
			["Assistor"] = v_u1.Optional(v_u1.String),
			["Skin"] = v_u1.Optional(v_u1.String),
			["Killer"] = v_u1.String,
			["Victim"] = v_u1.String,
			["Weapon"] = v_u1.String,
			["Headshot"] = v_u1.Bool,
			["NoScope"] = v_u1.Optional(v_u1.Bool),
			["Smoke"] = v_u1.Optional(v_u1.Bool),
			["Wallbang"] = v_u1.Optional(v_u1.Bool),
			["Blind"] = v_u1.Optional(v_u1.Bool),
			["Jump"] = v_u1.Optional(v_u1.Bool),
			["FlashAssist"] = v_u1.Optional(v_u1.Bool),
			["DeathPosition"] = v_u1.Optional(v_u1.Vec3)
		})
		v1.UIPlayerKilled = v_u2(v_u1.DefinePacket(v4))
		local v5 = {}
		v5.Value = v_u1.Struct({
			["timeLength"] = v_u1.Float32,
			["message"] = v_u1.String,
			["header"] = v_u1.String
		})
		v1.ShowNotification = v_u2(v_u1.DefinePacket(v5))
		v1.CreateDamageIndicator = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.Vec3
		}))
		local v6 = {}
		v6.Value = v_u1.Struct({
			["KillerName"] = v_u1.String,
			["KillerTeam"] = v_u1.String,
			["Weapon"] = v_u1.String,
			["Headshot"] = v_u1.Bool
		})
		v1.ShowDeathCard = v_u2(v_u1.DefinePacket(v6))
		return v1
	end),
	["TeamSelection"] = v_u1.DefineNamespace("TeamSelection", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		v1.SelectTeam = v_u2(v_u1.DefinePacket({
			["Value"] = v_u1.String
		}), {
			["maximum_requests_per_second"] = 1
		})
		return v1
	end),
	["Hints"] = v_u1.DefineNamespace("Hints", function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		local v1 = {}
		local v2 = {}
		v2.Value = v_u1.Struct({
			["site"] = v_u1.String,
			["action"] = v_u1.String
		})
		v1.BombSiteEntered = v_u2(v_u1.DefinePacket(v2))
		local v3 = {}
		v3.Value = v_u1.Struct({
			["site"] = v_u1.String,
			["action"] = v_u1.String
		})
		v1.BombSiteExited = v_u2(v_u1.DefinePacket(v3))
		local v4 = {}
		v4.Value = v_u1.Struct({
			["hintType"] = v_u1.String
		})
		v1.ClearHint = v_u2(v_u1.DefinePacket(v4))
		return v1
	end)
})