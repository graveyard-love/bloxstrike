local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(v1.Packages.ByteNet)
local v_u_4 = require(script:WaitForChild("DefinePacket"))
local v5 = table.freeze
local v6 = {}
local function v8()
    local v7 = {
        ["ClaimExclusiveMedalReward"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        }),
        ["RefreshMedalStatus"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 0.2
        })
    }
    return v7
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Collaborations")
end
v6.Collaborations = v_u_3.DefineNamespace("Collaborations", v8)
local function v16()
    local v9 = {
        ["RetrieveAllPlayerData"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
    }
    local v10 = v_u_4
    local v11 = v_u_3.DefinePacket
    local v12 = {
        ["Value"] = v_u_3.Struct({
            ["Player"] = v_u_3.Instance,
            ["Data"] = v_u_3.Unknown
        })
    }
    v9.PlayerDataEvent = v10(v11(v12))
    local v13 = v_u_4
    local v14 = v_u_3.DefinePacket
    local v15 = {
        ["Value"] = v_u_3.Struct({
            ["Data"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown),
            ["Player"] = v_u_3.Instance
        })
    }
    v9.PlayerDataChanged = v13(v14(v15))
    return v9
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("PlayerData")
end
v6.PlayerData = v_u_3.DefineNamespace("PlayerData", v16)
local function v24()
    local v17 = {}
    local v18 = v_u_4
    local v19 = v_u_3.DefinePacket
    local v20 = {
        ["Value"] = v_u_3.Struct({
            ["Path"] = v_u_3.String,
            ["Value"] = v_u_3.Unknown
        })
    }
    v17.UpdatePlayerSettings = v18(v19(v20), {
        ["maximum_requests_per_second"] = 3
    })
    local v21 = v_u_4
    local v22 = v_u_3.DefinePacket
    local v23 = {
        ["Value"] = v_u_3.Struct({
            ["Layout"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown)
        })
    }
    v17.UpdateMobileButtons = v21(v22(v23), {
        ["maximum_requests_per_second"] = 1
    })
    v17.BlankRequest = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Float64
    }), {
        ["maximum_requests_per_second"] = 1
    })
    v17.ReportPlayerConnect = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }), {
        ["maximum_requests_per_second"] = 1
    })
    v17.SubmitUserPlatformAnalytics = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }), {
        ["maximum_requests_per_second"] = 1
    })
    v17.AFKTeleport = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Nothing
    }), {
        ["maximum_requests_per_second"] = 1
    })
    return v17
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Player")
end
v6.Player = v_u_3.DefineNamespace("Player", v24)
local function v34()
    local function v29(p25)
        local v26 = v_u_4
        local v27 = v_u_3.DefinePacket
        local v28 = {
            ["Value"] = v_u_3.Struct({
                ["Amount"] = v_u_3.Uint8,
                ["Voter"] = v_u_3.String
            })
        }
        return v26(v27(v28), {
            ["maximum_requests_per_second"] = p25
        })
    end
    local v30 = {
        ["VoteNo"] = v29(1),
        ["VoteYes"] = v29(1),
        ["VoteNoUpdate"] = v29(0),
        ["VoteYesUpdate"] = v29(0)
    }
    local v31 = v_u_4
    local v32 = v_u_3.DefinePacket
    local v33 = {
        ["Value"] = v_u_3.Struct({
            ["TargetUserId"] = v_u_3.String,
            ["VoterUserId"] = v_u_3.String
        })
    }
    v30.StartVote = v31(v32(v33), {
        ["maximum_requests_per_second"] = 0
    })
    v30.EndVote = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Nothing
    }), {
        ["maximum_requests_per_second"] = 1
    })
    v30.CallVote = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }), {
        ["maximum_requests_per_second"] = 1
    })
    return v30
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("VoteKick")
end
v6.VoteKick = v_u_3.DefineNamespace("VoteKick", v34)
local function v48()
    local v35 = {
        ["CharacterDamaged"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        })),
        ["CharacterDied"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
    }
    local v36 = v_u_4
    local v37 = v_u_3.DefinePacket
    local v38 = {
        ["Value"] = v_u_3.Struct({
            ["Headshot"] = v_u_3.Bool,
            ["Damage"] = v_u_3.Float32
        })
    }
    v35.CharacterFlinch = v36(v37(v38))
    v35.UpdateWalkState = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Bool
    }))
    v35.UpdateCrouchState = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Bool
    }))
    v35.FallDamage = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Float32
    }))
    local v39 = v_u_4
    local v40 = v_u_3.DefinePacket
    local v41 = {
        ["Value"] = v_u_3.Struct({
            ["Duration"] = v_u_3.Float32,
            ["Multiplier"] = v_u_3.Float32
        })
    }
    v35.ShotSlow = v39(v40(v41))
    local v42 = v_u_4
    local v43 = v_u_3.DefinePacket
    local v44 = {
        ["ReliabilityType"] = "Unreliable",
        ["Value"] = v_u_3.Struct({
            ["HorizontalAngle"] = v_u_3.Float32,
            ["VerticalLook"] = v_u_3.Float32
        })
    }
    v35.UpdateLookAngle = v42(v43(v44), {
        ["maximum_requests_per_second"] = 30
    })
    local v45 = v_u_4
    local v46 = v_u_3.DefinePacket
    local v47 = {
        ["ReliabilityType"] = "Unreliable",
        ["Value"] = v_u_3.Struct({
            ["Player"] = v_u_3.Instance,
            ["HorizontalAngle"] = v_u_3.Float32,
            ["VerticalLook"] = v_u_3.Float32
        })
    }
    v35.ReplicateLookAngle = v45(v46(v47))
    return v35
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Character")
end
v6.Character = v_u_3.DefineNamespace("Character", v48)
local function v56()
    local v49 = {}
    local v50 = v_u_4
    local v51 = v_u_3.DefinePacket
    local v52 = {
        ["Value"] = v_u_3.Struct({
            ["Position"] = v_u_3.Optional(v_u_3.Vec3),
            ["Parent"] = v_u_3.Optional(v_u_3.Instance),
            ["Duration"] = v_u_3.Optional(v_u_3.String),
            ["Path"] = v_u_3.Optional(v_u_3.String),
            ["Class"] = v_u_3.String,
            ["Name"] = v_u_3.String
        })
    }
    v49.ReplicateSound = v50(v51(v52), {
        ["maximum_requests_per_second"] = 25
    })
    local v53 = v_u_4
    local v54 = v_u_3.DefinePacket
    local v55 = {
        ["Value"] = v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["Radius"] = v_u_3.Float32
        })
    }
    v49.StopSoundAtPosition = v53(v54(v55))
    return v49
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Sound")
end
v6.Sound = v_u_3.DefineNamespace("Sound", v56)
local function v97()
    local v57 = {}
    local v58 = v_u_4
    local v59 = v_u_3.DefinePacket
    local v60 = {}
    local v61 = v_u_3.Struct
    local v62 = {
        ["DeletedCaseIds"] = v_u_3.Array(v_u_3.String),
        ["CaseIdentifier"] = v_u_3.String,
        ["CaseId"] = v_u_3.String
    }
    local v63 = v_u_3.Array
    local v64 = v_u_3.Struct
    local v65 = {
        ["_id"] = v_u_3.String,
        ["Type"] = v_u_3.String,
        ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
        ["Name"] = v_u_3.String,
        ["Skin"] = v_u_3.String,
        ["Rarity"] = v_u_3.Optional(v_u_3.String),
        ["Float"] = v_u_3.Optional(v_u_3.Float32),
        ["StatTrack"] = v_u_3.Unknown,
        ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
        ["NameTag"] = v_u_3.Unknown,
        ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
        ["Charm"] = v_u_3.Unknown,
        ["Pattern"] = v_u_3.Optional(v_u_3.Uint16)
    }
    local v66 = v_u_3.Optional
    local v67 = v_u_3.Array
    local v68 = v_u_3.Struct
    local v69 = {
        ["Sticker"] = v_u_3.String,
        ["Position"] = v_u_3.Struct({
            ["Rotation"] = v_u_3.Float32,
            ["X"] = v_u_3.Float32,
            ["Y"] = v_u_3.Float32
        })
    }
    v65.Stickers = v66(v67(v68(v69)))
    v65.MetaData = v_u_3.Optional(v_u_3.Struct({
        ["LastTradeAt"] = v_u_3.Optional(v_u_3.String),
        ["CreatedAt"] = v_u_3.Optional(v_u_3.String),
        ["TradeHistory"] = v_u_3.Optional(v_u_3.Array(v_u_3.String)),
        ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
        ["Owner"] = v_u_3.Optional(v_u_3.String),
        ["Origin"] = v_u_3.Optional(v_u_3.String)
    }))
    v65.__v = v_u_3.Optional(v_u_3.Uint32)
    v62.InventoryItems = v63(v64(v65))
    v60.Value = v61(v62)
    v57.CaseOpened = v58(v59(v60), {
        ["maximum_requests_per_second"] = 1
    })
    v57.CaseOpenDenied = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Struct({})
    }), {
        ["maximum_requests_per_second"] = 1
    })
    local v70 = v_u_4
    local v71 = v_u_3.DefinePacket
    local v72 = {
        ["Value"] = v_u_3.Struct({
            ["CaseIdentifiers"] = v_u_3.Array(v_u_3.String),
            ["OpenType"] = v_u_3.String,
            ["CaseId"] = v_u_3.String
        })
    }
    v57.OpenCase = v70(v71(v72), {
        ["maximum_requests_per_second"] = 0.5
    })
    local v73 = v_u_4
    local v74 = v_u_3.DefinePacket
    local v75 = {
        ["Value"] = v_u_3.Struct({
            ["CaseIdentifier"] = v_u_3.String
        })
    }
    v57.CaseOpenSequenceFinished = v73(v74(v75), {
        ["maximum_requests_per_second"] = 2
    })
    local v76 = v_u_4
    local v77 = v_u_3.DefinePacket
    local v78 = {}
    local v79 = v_u_3.Struct
    local v80 = {}
    local v81 = v_u_3.Array
    local v82 = v_u_3.Struct
    local v83 = {
        ["_id"] = v_u_3.String,
        ["Type"] = v_u_3.String,
        ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
        ["Name"] = v_u_3.String,
        ["Skin"] = v_u_3.String,
        ["Rarity"] = v_u_3.Optional(v_u_3.String),
        ["Float"] = v_u_3.Optional(v_u_3.Float32),
        ["StatTrack"] = v_u_3.Unknown,
        ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
        ["NameTag"] = v_u_3.Unknown,
        ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
        ["Charm"] = v_u_3.Unknown,
        ["Pattern"] = v_u_3.Optional(v_u_3.Uint16)
    }
    local v84 = v_u_3.Optional
    local v85 = v_u_3.Array
    local v86 = v_u_3.Struct
    local v87 = {
        ["Sticker"] = v_u_3.String,
        ["Position"] = v_u_3.Struct({
            ["Rotation"] = v_u_3.Float32,
            ["X"] = v_u_3.Float32,
            ["Y"] = v_u_3.Float32
        })
    }
    v83.Stickers = v84(v85(v86(v87)))
    v83.MetaData = v_u_3.Optional(v_u_3.Struct({
        ["LastTradeAt"] = v_u_3.Optional(v_u_3.String),
        ["CreatedAt"] = v_u_3.Optional(v_u_3.String),
        ["TradeHistory"] = v_u_3.Optional(v_u_3.Array(v_u_3.String)),
        ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
        ["Owner"] = v_u_3.Optional(v_u_3.String),
        ["Origin"] = v_u_3.Optional(v_u_3.String)
    }))
    v83.__v = v_u_3.Optional(v_u_3.Uint32)
    v80.Items = v81(v82(v83))
    v80.Player = v_u_3.String
    v80.DeletedItemIds = v_u_3.Optional(v_u_3.Array(v_u_3.String))
    v78.Value = v79(v80)
    v57.NewInventoryItem = v76(v77(v78), {
        ["maximum_requests_per_second"] = 8
    })
    local v88 = v_u_4
    local v89 = v_u_3.DefinePacket
    local v90 = {
        ["Value"] = v_u_3.Struct({
            ["RecipientUserId"] = v_u_3.String,
            ["CaseId"] = v_u_3.String,
            ["Amount"] = v_u_3.Uint8
        })
    }
    v57.GiftCase = v88(v89(v90), {
        ["maximum_requests_per_second"] = 1
    })
    local v91 = v_u_4
    local v92 = v_u_3.DefinePacket
    local v93 = {
        ["Value"] = v_u_3.Struct({
            ["CaseId"] = v_u_3.String,
            ["Amount"] = v_u_3.Uint8
        })
    }
    v57.PurchaseCase = v91(v92(v93), {
        ["maximum_requests_per_second"] = 3
    })
    local v94 = v_u_4
    local v95 = v_u_3.DefinePacket
    local v96 = {
        ["Value"] = v_u_3.Struct({
            ["RecipientUserId"] = v_u_3.String,
            ["ProductName"] = v_u_3.String,
            ["ProductType"] = v_u_3.String
        })
    }
    v57.CreateGift = v94(v95(v96), {
        ["maximum_requests_per_second"] = 1
    })
    return v57
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Store")
end
v6.Store = v_u_3.DefineNamespace("Store", v97)
local function v99()
    local v98 = {
        ["UpdateCameraCFrame"] = v_u_4(v_u_3.DefinePacket({
            ["ReliabilityType"] = "Unreliable",
            ["Value"] = v_u_3.CFrame
        }), {
            ["maximum_requests_per_second"] = 60
        }),
        ["SetSpectatePerspective"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        })),
        ["SpectatePlayer"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        })),
        ["StartSpectating"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        })),
        ["StopSpectating"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        })),
        ["ReplicateSpectateEvent"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
    }
    return v98
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Spectate")
end
v6.Spectate = v_u_3.DefineNamespace("Spectate", v99)
local function v101()
    local v100 = {
        ["MissionCompleted"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        }),
        ["RedeemCode"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        }),
        ["RedeemLikeAndFavoriteReward"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        })
    }
    return v100
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Dashboard")
end
v6.Dashboard = v_u_3.DefineNamespace("Dashboard", v101)
local function v103()
    local v102 = {
        ["SubmitMapVote"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        })),
        ["StartMapVote"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Array(v_u_3.String)
        })),
        ["UpdateMapVote"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Map(v_u_3.String, v_u_3.Uint8)
        })),
        ["EndMapVote"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        })),
        ["RequestMapVote"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
    }
    return v102
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Map")
end
v6.Map = v_u_3.DefineNamespace("Map", v103)
local function v118()
    local v104 = {}
    local v105 = v_u_4
    local v106 = v_u_3.DefinePacket
    local v107 = {}
    local v108 = v_u_3.Struct
    local v109 = {
        ["WinningTeam"] = v_u_3.String,
        ["CTScore"] = v_u_3.Uint16,
        ["TScore"] = v_u_3.Uint16
    }
    local v110 = v_u_3.Map
    local v111 = v_u_3.String
    local v112 = v_u_3.Struct
    local v113 = {
        ["Team"] = v_u_3.String,
        ["ADR"] = v_u_3.Float32,
        ["Kills"] = v_u_3.Uint16,
        ["Deaths"] = v_u_3.Uint16,
        ["Assists"] = v_u_3.Uint16,
        ["Score"] = v_u_3.Uint16,
        ["Headshots"] = v_u_3.Uint16,
        ["Accolade"] = v_u_3.String,
        ["ExperienceEarned"] = v_u_3.Optional(v_u_3.Uint32),
        ["Weapon"] = v_u_3.Optional(v_u_3.Struct({
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.String,
            ["Float"] = v_u_3.Float32,
            ["StatTrack"] = v_u_3.Unknown,
            ["NameTag"] = v_u_3.Unknown
        })),
        ["Gloves"] = v_u_3.Optional(v_u_3.Struct({
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.String,
            ["Float"] = v_u_3.Float32
        }))
    }
    local v114 = v_u_3.Optional
    local v115 = v_u_3.Array
    local v116 = v_u_3.Struct
    local v117 = {
        ["type"] = v_u_3.String,
        ["amount"] = v_u_3.Optional(v_u_3.Uint32),
        ["inventoryItem"] = v_u_3.Optional(v_u_3.Struct({
            ["_id"] = v_u_3.String,
            ["Name"] = v_u_3.String,
            ["Skin"] = v_u_3.Optional(v_u_3.String),
            ["Rarity"] = v_u_3.String,
            ["Type"] = v_u_3.String,
            ["Float"] = v_u_3.Optional(v_u_3.Float32),
            ["Serial"] = v_u_3.Optional(v_u_3.Uint32),
            ["Pattern"] = v_u_3.Optional(v_u_3.Uint16),
            ["StatTrack"] = v_u_3.Unknown,
            ["NameTag"] = v_u_3.Unknown,
            ["Charm"] = v_u_3.Unknown,
            ["IsTradeable"] = v_u_3.Optional(v_u_3.Bool),
            ["Stickers"] = v_u_3.Optional(v_u_3.Unknown),
            ["MetaData"] = v_u_3.Optional(v_u_3.Unknown)
        }))
    }
    v113.LevelRewards = v114(v115(v116(v117)))
    v109.Players = v110(v111, v112(v113))
    v109.ShowAccolades = v_u_3.Optional(v_u_3.Bool)
    v109.ShowProgression = v_u_3.Optional(v_u_3.Bool)
    v109.SequenceDuration = v_u_3.Optional(v_u_3.Float32)
    v109.ReturnToMenu = v_u_3.Optional(v_u_3.Bool)
    v109.Halftime = v_u_3.Optional(v_u_3.Bool)
    v107.Value = v108(v109)
    v104.EndScreen = v105(v106(v107))
    return v104
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Match")
end
v6.Match = v_u_3.DefineNamespace("Match", v118)
local function v195()
    local v119 = {
        ["RemoveInventoryItem"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }))
    }
    local v120 = v_u_4
    local v121 = v_u_3.DefinePacket
    local v122 = {}
    local v123 = v_u_3.Struct
    local v124 = {
        ["customProperties"] = v_u_3.Optional(v_u_3.Map(v_u_3.String, v_u_3.Unknown)),
        ["OriginalOwner"] = v_u_3.Optional(v_u_3.String),
        ["StatTrack"] = v_u_3.Unknown,
        ["NameTag"] = v_u_3.Unknown,
        ["Charm"] = v_u_3.Unknown,
        ["Float"] = v_u_3.Float32,
        ["identifier"] = v_u_3.String,
        ["shouldEquip"] = v_u_3.Optional(v_u_3.Bool),
        ["weapon"] = v_u_3.String,
        ["skin"] = v_u_3.String,
        ["slot"] = v_u_3.Uint8,
        ["_id"] = v_u_3.String
    }
    local v125 = v_u_3.Array
    local v126 = v_u_3.Struct
    local v127 = {
        ["Sticker"] = v_u_3.String,
        ["Position"] = v_u_3.Struct({
            ["X"] = v_u_3.Float32,
            ["Y"] = v_u_3.Float32,
            ["Rotation"] = v_u_3.Float32
        })
    }
    v124.Stickers = v125(v126(v127))
    v122.Value = v123(v124)
    v119.NewInventoryItem = v120(v121(v122))
    local v128 = v_u_4
    local v129 = v_u_3.DefinePacket
    local v130 = {
        ["Value"] = v_u_3.Struct({
            ["Player"] = v_u_3.Instance,
            ["Identifier"] = v_u_3.String,
            ["StatTrack"] = v_u_3.Uint32
        })
    }
    v119.UpdateStatTrack = v128(v129(v130))
    v119.CleanupGameLoadout = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Nothing
    }))
    local v131 = v_u_4
    local v132 = v_u_3.DefinePacket
    local v133 = {}
    local v134 = v_u_3.Array
    local v135 = v_u_3.Struct
    local v136 = {
        ["_items"] = v_u_3.Array(v_u_3.Struct({
            ["Identifier"] = v_u_3.String
        })),
        ["_settings"] = v_u_3.Struct({
            ["_strict_slot_space"] = v_u_3.Uint8,
            ["_strict_type"] = v_u_3.String
        })
    }
    v133.Value = v134(v135(v136))
    v119.CreateGameLoadout = v131(v132(v133))
    v119.RequestSpectatedPlayerInventory = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Instance
    }))
    local v137 = v_u_4
    local v138 = v_u_3.DefinePacket
    local v139 = {}
    local v140 = v_u_3.Struct
    local v141 = {
        ["Player"] = v_u_3.Instance
    }
    local v142 = v_u_3.Array
    local v143 = v_u_3.Struct
    local v144 = {}
    local v145 = v_u_3.Array
    local v146 = v_u_3.Struct
    local v147 = {
        ["Identifier"] = v_u_3.String,
        ["Name"] = v_u_3.String,
        ["Slot"] = v_u_3.Uint8,
        ["Properties"] = v_u_3.Struct({
            ["Class"] = v_u_3.String,
            ["Icon"] = v_u_3.String,
            ["Slot"] = v_u_3.String
        })
    }
    v144._items = v145(v146(v147))
    v144._settings = v_u_3.Struct({
        ["_strict_slot_space"] = v_u_3.Uint8,
        ["_strict_type"] = v_u_3.String
    })
    v141.Inventory = v142(v143(v144))
    v141.EquippedSlot = v_u_3.Uint8
    v141.EquippedSlotSpace = v_u_3.Uint8
    v139.Value = v140(v141)
    v119.SpectatedPlayerInventory = v137(v138(v139))
    local v148 = v_u_4
    local v149 = v_u_3.DefinePacket
    local v150 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["PreviousIdentifier"] = v_u_3.Optional(v_u_3.String)
        })
    }
    v119.WeaponEquipped = v148(v149(v150), {
        ["maximum_requests_per_second"] = 0
    })
    local v151 = v_u_4
    local v152 = v_u_3.DefinePacket
    local v153 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["Equipment"] = v_u_3.Bool
        })
    }
    v119.ReturnBuyMenuPurchase = v151(v152(v153))
    local v154 = v_u_4
    local v155 = v_u_3.DefinePacket
    local v156 = {
        ["Value"] = v_u_3.Struct({
            ["Name"] = v_u_3.String,
            ["Equipment"] = v_u_3.Bool,
            ["Path"] = v_u_3.String
        })
    }
    v119.BuyMenuPurchase = v154(v155(v156), {
        ["maximum_requests_per_second"] = 3
    })
    local v157 = v_u_4
    local v158 = v_u_3.DefinePacket
    local v159 = {
        ["Value"] = v_u_3.Struct({
            ["Identity"] = v_u_3.String
        })
    }
    v119.PickupWeapon = v157(v158(v159), {
        ["maximum_requests_per_second"] = 7
    })
    local v160 = v_u_4
    local v161 = v_u_3.DefinePacket
    local v162 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["Direction"] = v_u_3.Vec3
        })
    }
    v119.DropWeapon = v160(v161(v162), {
        ["maximum_requests_per_second"] = 5
    })
    v119.UpdateScopeIncrement = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Uint8
    }), {
        ["maximum_requests_per_second"] = 10
    })
    local v163 = v_u_4
    local v164 = v_u_3.DefinePacket
    local v165 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["State"] = v_u_3.Bool
        })
    }
    v119.UpdateWeaponSuppressor = v163(v164(v165))
    local v166 = v_u_4
    local v167 = v_u_3.DefinePacket
    local v168 = {
        ["Value"] = v_u_3.Struct({
            ["WeaponId"] = v_u_3.String,
            ["CharmId"] = v_u_3.String,
            ["Position"] = v_u_3.String
        })
    }
    v119.UpdateWeaponCharm = v166(v167(v168))
    local v169 = v_u_4
    local v170 = v_u_3.DefinePacket
    local v171 = {
        ["Value"] = v_u_3.Struct({
            ["WeaponId"] = v_u_3.String
        })
    }
    v119.RemoveWeaponCharm = v169(v170(v171))
    local v172 = v_u_4
    local v173 = v_u_3.DefinePacket
    local v174 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["Rounds"] = v_u_3.Uint16,
            ["Capacity"] = v_u_3.Uint16
        })
    }
    v119.ReloadWeapon = v172(v173(v174))
    local v175 = v_u_4
    local v176 = v_u_3.DefinePacket
    local v177 = {}
    local v178 = v_u_3.Struct
    local v179 = {
        ["ShootingHand"] = v_u_3.String,
        ["Identifier"] = v_u_3.String,
        ["Rounds"] = v_u_3.Uint16,
        ["Capacity"] = v_u_3.Uint16,
        ["IsSniperScoped"] = v_u_3.Bool
    }
    local v180 = v_u_3.Array
    local v181 = v_u_3.Struct
    local v182 = {
        ["Direction"] = v_u_3.Vec3,
        ["Origin"] = v_u_3.Vec3,
        ["Hits"] = v_u_3.Array(v_u_3.Struct({
            ["Instance"] = v_u_3.Instance,
            ["Position"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3,
            ["Material"] = v_u_3.String,
            ["Distance"] = v_u_3.Float32,
            ["Exit"] = v_u_3.Bool
        }))
    }
    v179.Bullets = v180(v181(v182))
    v177.Value = v178(v179)
    v119.ShootWeapon = v175(v176(v177), {
        ["maximum_requests_per_second"] = 20
    })
    v119.CreateMagazine = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }), {
        ["maximum_requests_per_second"] = 1
    })
    local v183 = v_u_4
    local v184 = v_u_3.DefinePacket
    local v185 = {
        ["Value"] = v_u_3.Struct({
            ["Identifier"] = v_u_3.String,
            ["Direction"] = v_u_3.Vec3,
            ["Position"] = v_u_3.Vec3,
            ["Animation"] = v_u_3.String,
            ["CharacterVelocity"] = v_u_3.Vec3,
            ["IsCrouching"] = v_u_3.Bool
        })
    }
    v119.ThrowGrenade = v183(v184(v185), {
        ["maximum_requests_per_second"] = 1
    })
    local v186 = v_u_4
    local v187 = v_u_3.DefinePacket
    local v188 = {
        ["Value"] = v_u_3.Struct({
            ["Type"] = v_u_3.String,
            ["Slot"] = v_u_3.Uint8,
            ["Team"] = v_u_3.String,
            ["Identifier"] = v_u_3.String
        })
    }
    v119.EquipLoadoutSkin = v186(v187(v188), {
        ["maximum_requests_per_second"] = 5
    })
    local v189 = v_u_4
    local v190 = v_u_3.DefinePacket
    local v191 = {
        ["Value"] = v_u_3.Struct({
            ["Type"] = v_u_3.String,
            ["SlotOne"] = v_u_3.Uint8,
            ["SlotTwo"] = v_u_3.Uint8,
            ["Team"] = v_u_3.String
        })
    }
    v119.SwapLoadoutSkins = v189(v190(v191), {
        ["maximum_requests_per_second"] = 5
    })
    local v192 = v_u_4
    local v193 = v_u_3.DefinePacket
    local v194 = {
        ["Value"] = v_u_3.Struct({
            ["Path"] = v_u_3.String,
            ["Team"] = v_u_3.String,
            ["Identifier"] = v_u_3.String
        })
    }
    v119.EquipSpecialItem = v192(v193(v194), {
        ["maximum_requests_per_second"] = 5
    })
    v119.LoadoutResponse = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Bool
    }))
    return v119
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Inventory")
end
v6.Inventory = v_u_3.DefineNamespace("Inventory", v195)
local function v211()
    local v196 = {}
    local v197 = v_u_4
    local v198 = v_u_3.DefinePacket
    local v199 = {}
    local v200 = v_u_3.Struct
    local v201 = {
        ["Id"] = v_u_3.String,
        ["Weapon"] = v_u_3.String,
        ["Skin"] = v_u_3.String,
        ["Float"] = v_u_3.Float32,
        ["StatTrack"] = v_u_3.Unknown,
        ["NameTag"] = v_u_3.Unknown,
        ["Charm"] = v_u_3.Unknown
    }
    local v202 = v_u_3.Array
    local v203 = v_u_3.Struct
    local v204 = {
        ["Sticker"] = v_u_3.String,
        ["Position"] = v_u_3.Struct({
            ["X"] = v_u_3.Float32,
            ["Y"] = v_u_3.Float32,
            ["Rotation"] = v_u_3.Float32
        })
    }
    v201.Stickers = v202(v203(v204))
    v201.State = v_u_3.Struct({
        ["Position"] = v_u_3.Vec3,
        ["Velocity"] = v_u_3.Vec3,
        ["StartTime"] = v_u_3.Optional(v_u_3.Float64),
        ["IsJumpThrow"] = v_u_3.Bool
    })
    v201.Physics = v_u_3.Struct({
        ["Gravity"] = v_u_3.Vec3,
        ["Drag"] = v_u_3.Float32,
        ["Restitution"] = v_u_3.Float32,
        ["Radius"] = v_u_3.Float32,
        ["MaxBounces"] = v_u_3.Uint8,
        ["FuseTime"] = v_u_3.Float32,
        ["Step"] = v_u_3.Float32,
        ["RestVelocityThreshold"] = v_u_3.Float32,
        ["CollisionGroup"] = v_u_3.String
    })
    v199.Value = v200(v201)
    v196.Spawn = v197(v198(v199))
    local v205 = v_u_4
    local v206 = v_u_3.DefinePacket
    local v207 = {
        ["Value"] = v_u_3.Struct({
            ["Id"] = v_u_3.String,
            ["Grenade"] = v_u_3.String,
            ["Position"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3,
            ["Reason"] = v_u_3.String
        })
    }
    v196.Resolve = v205(v206(v207))
    local v208 = v_u_4
    local v209 = v_u_3.DefinePacket
    local v210 = {
        ["Value"] = v_u_3.Struct({
            ["Id"] = v_u_3.String,
            ["BounceIndex"] = v_u_3.Uint8,
            ["Position"] = v_u_3.Vec3,
            ["Velocity"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3,
            ["Timestamp"] = v_u_3.Float64
        })
    }
    v196.Bounce = v208(v209(v210))
    return v196
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Projectile")
end
v6.Projectile = v_u_3.DefineNamespace("Projectile", v211)
local function v255()
    local v212 = {}
    local v213 = v_u_4
    local v214 = v_u_3.DefinePacket
    local v215 = {
        ["Value"] = v_u_3.Struct({
            ["Skin"] = v_u_3.Optional(v_u_3.String),
            ["DirectionMultiplier"] = v_u_3.Float32,
            ["Character"] = v_u_3.Instance,
            ["Finisher"] = v_u_3.String,
            ["Direction"] = v_u_3.Vec3,
            ["Weapon"] = v_u_3.String,
            ["Killer"] = v_u_3.String,
            ["Victim"] = v_u_3.String,
            ["Part"] = v_u_3.String
        })
    }
    v212.ReplicateFinisher = v213(v214(v215), {
        ["maximum_requests_per_second"] = 5
    })
    local v216 = v_u_4
    local v217 = v_u_3.DefinePacket
    local v218 = {
        ["Value"] = v_u_3.Struct({
            ["Suppressor"] = v_u_3.Optional(v_u_3.String),
            ["ShootingHand"] = v_u_3.String,
            ["PlayerName"] = v_u_3.String,
            ["WeaponName"] = v_u_3.String
        })
    }
    v212.CreateCharacterMuzzleFlash = v216(v217(v218), {
        ["maximum_requests_per_second"] = 25
    })
    local v219 = v_u_4
    local v220 = v_u_3.DefinePacket
    local v221 = {
        ["Value"] = v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["Direction"] = v_u_3.Vec3
        })
    }
    v212.CreateBloodSplatter = v219(v220(v221), {
        ["maximum_requests_per_second"] = 0
    })
    local v222 = v_u_4
    local v223 = v_u_3.DefinePacket
    local v224 = {
        ["Value"] = v_u_3.Struct({
            ["Instance"] = v_u_3.Instance,
            ["Material"] = v_u_3.String,
            ["Position"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3,
            ["Exit"] = v_u_3.Bool,
            ["Ricochet"] = v_u_3.Bool,
            ["AttackerUserId"] = v_u_3.Optional(v_u_3.String),
            ["IsWallbang"] = v_u_3.Optional(v_u_3.Bool),
            ["WasHelmetHeadshot"] = v_u_3.Optional(v_u_3.Bool)
        })
    }
    v212.CreateImpact = v222(v223(v224), {
        ["maximum_requests_per_second"] = 25
    })
    local v225 = v_u_4
    local v226 = v_u_3.DefinePacket
    local v227 = {
        ["Value"] = v_u_3.Struct({
            ["Instance"] = v_u_3.Instance,
            ["Type"] = v_u_3.String,
            ["Position"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3
        })
    }
    v212.CreateMarker = v225(v226(v227), {
        ["maximum_requests_per_second"] = 25
    })
    local v228 = v_u_4
    local v229 = v_u_3.DefinePacket
    local v230 = {
        ["Value"] = v_u_3.Struct({
            ["Distance"] = v_u_3.Float32,
            ["Origin"] = v_u_3.Vec3,
            ["Target"] = v_u_3.Vec3
        })
    }
    v212.CreateTracer = v228(v229(v230), {
        ["maximum_requests_per_second"] = 25
    })
    v212.CleanupDebris = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Nothing
    }))
    local v231 = v_u_4
    local v232 = v_u_3.DefinePacket
    local v233 = {
        ["Value"] = v_u_3.Struct({
            ["Instance"] = v_u_3.Instance,
            ["Position"] = v_u_3.Vec3,
            ["Direction"] = v_u_3.Vec3
        })
    }
    v212.BreakGlass = v231(v232(v233), {
        ["maximum_requests_per_second"] = 25
    })
    local v234 = v_u_4
    local v235 = v_u_3.DefinePacket
    local v236 = {}
    local v237 = v_u_3.Struct
    local v238 = {
        ["SmokeId"] = v_u_3.String,
        ["Duration"] = v_u_3.Float32,
        ["DeployTime"] = v_u_3.Float32,
        ["Voxels"] = v_u_3.Array(v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["Size"] = v_u_3.Float32
        })),
        ["Team"] = v_u_3.Optional(v_u_3.String)
    }
    v236.Value = v237(v238)
    v212.CreateVoxelSmoke = v234(v235(v236))
    v212.DestroyVoxelSmoke = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    local v239 = v_u_4
    local v240 = v_u_3.DefinePacket
    local v241 = {
        ["Value"] = v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["Radius"] = v_u_3.Float32,
            ["Duration"] = v_u_3.Float32
        })
    }
    v212.DisruptVoxelSmoke = v239(v240(v241))
    local v242 = v_u_4
    local v243 = v_u_3.DefinePacket
    local v244 = {}
    local v245 = v_u_3.Struct
    local v246 = {
        ["FireId"] = v_u_3.String,
        ["Duration"] = v_u_3.Float32,
        ["Voxels"] = v_u_3.Array(v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["SizeX"] = v_u_3.Float32,
            ["SizeZ"] = v_u_3.Float32,
            ["Normal"] = v_u_3.Vec3
        }))
    }
    v244.Value = v245(v246)
    v212.CreateVoxelFire = v242(v243(v244))
    v212.DestroyVoxelFire = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    local v247 = v_u_4
    local v248 = v_u_3.DefinePacket
    local v249 = {}
    local v250 = v_u_3.Struct
    local v251 = {
        ["FireId"] = v_u_3.String,
        ["Voxels"] = v_u_3.Array(v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["SizeX"] = v_u_3.Float32,
            ["SizeZ"] = v_u_3.Float32,
            ["Normal"] = v_u_3.Vec3
        }))
    }
    v249.Value = v250(v251)
    v212.UpdateVoxelFire = v247(v248(v249))
    local v252 = v_u_4
    local v253 = v_u_3.DefinePacket
    local v254 = {
        ["Value"] = v_u_3.Struct({
            ["Position"] = v_u_3.Vec3,
            ["AttackerUserId"] = v_u_3.Optional(v_u_3.String),
            ["Duration"] = v_u_3.Optional(v_u_3.Float32)
        })
    }
    v212.FlashPlayer = v252(v253(v254))
    return v212
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("VFX")
end
v6.VFX = v_u_3.DefineNamespace("VFX", v255)
local function v263()
    local v256 = {
        ["Defused"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
    }
    local v257 = v_u_4
    local v258 = v_u_3.DefinePacket
    local v259 = {
        ["Value"] = v_u_3.Struct({
            ["SessionId"] = v_u_3.Uint32
        })
    }
    v256.StartDefuse = v257(v258(v259))
    local v260 = v_u_4
    local v261 = v_u_3.DefinePacket
    local v262 = {
        ["Value"] = v_u_3.Struct({
            ["SessionId"] = v_u_3.Uint32
        })
    }
    v256.CancelDefuse = v260(v261(v262))
    v256.Planted = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    v256.Start = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    v256.Cancel = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    v256.ForceCancel = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Nothing
    }))
    return v256
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("C4")
end
v6.C4 = v_u_3.DefineNamespace("C4", v263)
local function v265()
    local v264 = {
        ["StartRescue"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        })),
        ["CancelRescue"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        })),
        ["PickedUp"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.Nothing
        }))
    }
    return v264
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Hostage")
end
v6.Hostage = v_u_3.DefineNamespace("Hostage", v265)
local function v270()
    local v266 = {}
    local v267 = v_u_4
    local v268 = v_u_3.DefinePacket
    local v269 = {
        ["Value"] = v_u_3.Struct({
            ["Direction"] = v_u_3.Vec3,
            ["Material"] = v_u_3.String,
            ["Distance"] = v_u_3.Float32,
            ["Instance"] = v_u_3.Instance,
            ["Position"] = v_u_3.Vec3,
            ["Normal"] = v_u_3.Vec3,
            ["MeleeAttack"] = v_u_3.String,
            ["Identifier"] = v_u_3.String
        })
    }
    v266.MeleeAttack = v267(v268(v269), {
        ["maximum_requests_per_second"] = 5
    })
    return v266
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Melee")
end
v6.Melee = v_u_3.DefineNamespace("Melee", v270)
local function v311()
    local v271 = {}
    local v272 = v_u_4
    local v273 = v_u_3.DefinePacket
    local v274 = {
        ["Value"] = v_u_3.Struct({
            ["displayName"] = v_u_3.String,
            ["team"] = v_u_3.String,
            ["message"] = v_u_3.String,
            ["alive"] = v_u_3.Bool,
            ["role"] = v_u_3.Uint8,
            ["verified"] = v_u_3.Bool
        })
    }
    v271.ServerChat = v272(v273(v274))
    local v275 = v_u_4
    local v276 = v_u_3.DefinePacket
    local v277 = {
        ["Value"] = v_u_3.Struct({
            ["displayName"] = v_u_3.String,
            ["team"] = v_u_3.String,
            ["message"] = v_u_3.String,
            ["alive"] = v_u_3.Bool,
            ["role"] = v_u_3.Uint8,
            ["verified"] = v_u_3.Bool
        })
    }
    v271.ServerTeamChat = v275(v276(v277))
    local v278 = v_u_4
    local v279 = v_u_3.DefinePacket
    local v280 = {
        ["Value"] = v_u_3.Struct({
            ["name"] = v_u_3.String,
            ["team"] = v_u_3.String
        })
    }
    v271.ChatTeamJoin = v278(v279(v280))
    local v281 = v_u_4
    local v282 = v_u_3.DefinePacket
    local v283 = {
        ["Value"] = v_u_3.Struct({
            ["Killer"] = v_u_3.String,
            ["Weapon"] = v_u_3.String,
            ["Points"] = v_u_3.Optional(v_u_3.Uint8)
        })
    }
    v271.ChatPlayerKilled = v281(v282(v283))
    local v284 = v_u_4
    local v285 = v_u_3.DefinePacket
    local v286 = {
        ["Value"] = v_u_3.Struct({
            ["weaponName"] = v_u_3.Optional(v_u_3.String),
            ["amount"] = v_u_3.String,
            ["source"] = v_u_3.String
        })
    }
    v271.ChatMoneyReward = v284(v285(v286))
    local v287 = v_u_4
    local v288 = v_u_3.DefinePacket
    local v289 = {
        ["Value"] = v_u_3.Struct({
            ["displayName"] = v_u_3.String,
            ["team"] = v_u_3.String,
            ["weaponName"] = v_u_3.String,
            ["skinName"] = v_u_3.String,
            ["rarity"] = v_u_3.String,
            ["statTrak"] = v_u_3.Bool
        })
    }
    v271.ChatCaseOpened = v287(v288(v289))
    local v290 = v_u_4
    local v291 = v_u_3.DefinePacket
    local v292 = {
        ["Value"] = v_u_3.Struct({
            ["name"] = v_u_3.String
        })
    }
    v271.ChatPlayerLeave = v290(v291(v292))
    local v293 = v_u_4
    local v294 = v_u_3.DefinePacket
    local v295 = {
        ["Value"] = v_u_3.Struct({
            ["name"] = v_u_3.String
        })
    }
    v271.ChatPlayerBanned = v293(v294(v295))
    local v296 = v_u_4
    local v297 = v_u_3.DefinePacket
    local v298 = {
        ["Value"] = v_u_3.Struct({
            ["message"] = v_u_3.String
        })
    }
    v271.ChatSystemMessage = v296(v297(v298))
    local v299 = v_u_4
    local v300 = v_u_3.DefinePacket
    local v301 = {
        ["Value"] = v_u_3.Struct({
            ["messageType"] = v_u_3.String,
            ["displayName"] = v_u_3.String,
            ["team"] = v_u_3.String
        })
    }
    v271.ChatTeamDamage = v299(v300(v301))
    local v302 = v_u_4
    local v303 = v_u_3.DefinePacket
    local v304 = {
        ["Value"] = v_u_3.Struct({
            ["displayName"] = v_u_3.String,
            ["grenadeName"] = v_u_3.String,
            ["team"] = v_u_3.String
        })
    }
    v271.ChatGrenadeThrow = v302(v303(v304))
    local v305 = v_u_4
    local v306 = v_u_3.DefinePacket
    local v307 = {
        ["Value"] = v_u_3.Struct({
            ["displayName"] = v_u_3.String,
            ["team"] = v_u_3.String,
            ["site"] = v_u_3.String
        })
    }
    v271.ChatDefuseStart = v305(v306(v307))
    local v308 = v_u_4
    local v309 = v_u_3.DefinePacket
    local v310 = {
        ["Value"] = v_u_3.Struct({
            ["Text"] = v_u_3.String,
            ["Mode"] = v_u_3.Uint8
        })
    }
    v271.ClientChat = v308(v309(v310), {
        ["maximum_requests_per_second"] = 5
    })
    return v271
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Chat")
end
v6.Chat = v_u_3.DefineNamespace("Chat", v311)
local function v334()
    local v312 = {}
    local v313 = v_u_4
    local v314 = v_u_3.DefinePacket
    local v315 = {
        ["Value"] = v_u_3.Struct({
            ["Text"] = v_u_3.String,
            ["Type"] = v_u_3.String
        })
    }
    v312.UpdateCreatorCode = v313(v314(v315))
    local v316 = v_u_4
    local v317 = v_u_3.DefinePacket
    local v318 = {
        ["Value"] = v_u_3.Struct({
            ["CreatorCode"] = v_u_3.String
        })
    }
    v312.EquipCreatorCode = v316(v317(v318), {
        ["maximum_requests_per_second"] = 1
    })
    local v319 = v_u_4
    local v320 = v_u_3.DefinePacket
    local v321 = {
        ["Value"] = v_u_3.Struct({
            ["notificationType"] = v_u_3.String,
            ["text"] = v_u_3.String
        })
    }
    v312.CreateMenuNotification = v319(v320(v321))
    v312.RoundWinner = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }))
    local v322 = v_u_4
    local v323 = v_u_3.DefinePacket
    local v324 = {
        ["Value"] = v_u_3.Struct({
            ["PlayerName"] = v_u_3.String,
            ["Team"] = v_u_3.String,
            ["Reason"] = v_u_3.String
        })
    }
    v312.RoundMVP = v322(v323(v324))
    local v325 = v_u_4
    local v326 = v_u_3.DefinePacket
    local v327 = {
        ["Value"] = v_u_3.Struct({
            ["Assistor"] = v_u_3.Optional(v_u_3.String),
            ["Float"] = v_u_3.Optional(v_u_3.Float32),
            ["Skin"] = v_u_3.Optional(v_u_3.String),
            ["Killer"] = v_u_3.String,
            ["Victim"] = v_u_3.String,
            ["Weapon"] = v_u_3.String,
            ["Headshot"] = v_u_3.Bool,
            ["NoScope"] = v_u_3.Optional(v_u_3.Bool),
            ["Smoke"] = v_u_3.Optional(v_u_3.Bool),
            ["Wallbang"] = v_u_3.Optional(v_u_3.Bool),
            ["Blind"] = v_u_3.Optional(v_u_3.Bool),
            ["Jump"] = v_u_3.Optional(v_u_3.Bool),
            ["FlashAssist"] = v_u_3.Optional(v_u_3.Bool),
            ["DeathPosition"] = v_u_3.Optional(v_u_3.Vec3)
        })
    }
    v312.UIPlayerKilled = v325(v326(v327))
    local v328 = v_u_4
    local v329 = v_u_3.DefinePacket
    local v330 = {
        ["Value"] = v_u_3.Struct({
            ["timeLength"] = v_u_3.Float32,
            ["message"] = v_u_3.String,
            ["header"] = v_u_3.String
        })
    }
    v312.ShowNotification = v328(v329(v330))
    v312.CreateDamageIndicator = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Vec3
    }))
    local v331 = v_u_4
    local v332 = v_u_3.DefinePacket
    local v333 = {
        ["Value"] = v_u_3.Struct({
            ["KillerName"] = v_u_3.String,
            ["KillerTeam"] = v_u_3.String,
            ["Weapon"] = v_u_3.String,
            ["Headshot"] = v_u_3.Bool
        })
    }
    v312.ShowDeathCard = v331(v332(v333))
    return v312
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("UI")
end
v6.UI = v_u_3.DefineNamespace("UI", v334)
local function v339()
    local v335 = {}
    local v336 = v_u_4
    local v337 = v_u_3.DefinePacket
    local v338 = {
        ["Value"] = v_u_3.Struct({
            ["WeaponIdentity"] = v_u_3.Optional(v_u_3.String),
            ["WeaponName"] = v_u_3.Optional(v_u_3.String),
            ["WeaponSkin"] = v_u_3.Optional(v_u_3.String),
            ["Position"] = v_u_3.Vec3,
            ["IsDanger"] = v_u_3.Bool
        })
    }
    v335.CreatePlayerPositionPing = v336(v337(v338), {
        ["maximum_requests_per_second"] = 2
    })
    return v335
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Ping")
end
v6.Ping = v_u_3.DefineNamespace("Ping", v339)
local function v341()
    local v340 = {
        ["SelectTeam"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
    }
    return v340
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("TeamSelection")
end
v6.TeamSelection = v_u_3.DefineNamespace("TeamSelection", v341)
local function v343()
    local v342 = {
        ["SelectGamemode"] = v_u_4(v_u_3.DefinePacket({
            ["Value"] = v_u_3.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
    }
    return v342
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Modes")
end
v6.Modes = v_u_3.DefineNamespace("Modes", v343)
local function v354()
    local v344 = {}
    local v345 = v_u_4
    local v346 = v_u_3.DefinePacket
    local v347 = {
        ["Value"] = v_u_3.Struct({
            ["site"] = v_u_3.String,
            ["action"] = v_u_3.String
        })
    }
    v344.BombSiteEntered = v345(v346(v347))
    local v348 = v_u_4
    local v349 = v_u_3.DefinePacket
    local v350 = {
        ["Value"] = v_u_3.Struct({
            ["site"] = v_u_3.String,
            ["action"] = v_u_3.String
        })
    }
    v344.BombSiteExited = v348(v349(v350))
    local v351 = v_u_4
    local v352 = v_u_3.DefinePacket
    local v353 = {
        ["Value"] = v_u_3.Struct({
            ["hintType"] = v_u_3.String
        })
    }
    v344.ClearHint = v351(v352(v353))
    return v344
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("Hints")
end
v6.Hints = v_u_3.DefineNamespace("Hints", v354)
local function v365()
    local v355 = {}
    local v356 = v_u_4
    local v357 = v_u_3.DefinePacket
    local v358 = {
        ["Value"] = v_u_3.Struct({
            ["Key"] = v_u_3.String,
            ["Value"] = v_u_3.Unknown
        })
    }
    v355.SetSetting = v356(v357(v358), {
        ["maximum_requests_per_second"] = 5
    })
    local v359 = v_u_4
    local v360 = v_u_3.DefinePacket
    local v361 = {
        ["Value"] = v_u_3.Struct({
            ["Action"] = v_u_3.String,
            ["Params"] = v_u_3.Optional(v_u_3.Unknown)
        })
    }
    v355.ExecuteAction = v359(v360(v361), {
        ["maximum_requests_per_second"] = 2
    })
    v355.SyncState = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.Map(v_u_3.String, v_u_3.Unknown)
    }))
    v355.RequestData = v_u_4(v_u_3.DefinePacket({
        ["Value"] = v_u_3.String
    }), {
        ["maximum_requests_per_second"] = 2
    })
    local v362 = v_u_4
    local v363 = v_u_3.DefinePacket
    local v364 = {
        ["Value"] = v_u_3.Struct({
            ["Type"] = v_u_3.String,
            ["Data"] = v_u_3.Unknown
        })
    }
    v355.DataResponse = v362(v363(v364))
    return v355
end
if v2:IsClient() then
    v1:WaitForChild("BytenetStorage"):WaitForChild("VIP")
end
v6.VIP = v_u_3.DefineNamespace("VIP", v365)
return v5(v6)