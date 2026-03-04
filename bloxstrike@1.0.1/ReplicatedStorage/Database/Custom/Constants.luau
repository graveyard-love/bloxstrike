local v1 = table.freeze({
    ["Deathmatch"] = 107028954108065,
    ["Defusal"] = 100334860793031,
    ["UnrankedComp"] = 89844875164241
})
local v2 = table.freeze({
    ["Deathmatch"] = 135434213652028,
    ["Defusal"] = 114234929420007,
    ["UnrankedComp"] = 108194354348181
})
local v3 = table.freeze({
    ["Deathmatch"] = 0,
    ["Defusal"] = 0,
    ["UnrankedComp"] = 0
})
local v4 = game.PlaceId
for _, v5 in pairs(v1) do
    if v5 == v4 then
        v13 = true
        ::l4::
        local v6
        if v13 then
            v6 = "Dev"
            ::l8::
            local v7 = v6 == "Dev" and v1 and v1 or (v6 == "Prod" and v2 and v2 or v3)
            local v8 = v7.Defusal
            local v9 = v7.UnrankedComp
            local v10 = (v9 == v8 or not v9) and 0 or v9
            return table.freeze({
                ["VERSION"] = "1.0.1",
                ["MINIMUM_CREDITS_FOR_SPECIAL_CREDITS_OPTION"] = 100000,
                ["DEFAULT_CAMERA_FOV"] = 70,
                ["ACTIVE_EVENTS"] = {
                    ["MEDAL.TV"] = true
                },
                ["EVENT_END_TIMES"] = {
                    ["MEDAL.TV"] = os.time({
                        ["year"] = 2026,
                        ["month"] = 3,
                        ["day"] = 1,
                        ["hour"] = 0,
                        ["min"] = 0,
                        ["sec"] = 0
                    })
                },
                ["ADMINISTRATOR_FINISHER_WHITELIST"] = { 3659308968, 107643044, 1243042178 },
                ["AIM_ASSIST_WHITELIST"] = {},
                ["AIM_ASSIST_CONFIGS"] = {
                    ["DEVELOPER"] = {
                        ["TargetSelection"] = {
                            ["Enabled"] = true,
                            ["MaxDistance"] = 200,
                            ["MaxAngle"] = 0.7853981633974483
                        },
                        ["Friction"] = {
                            ["Enabled"] = true,
                            ["BubbleRadius"] = 4,
                            ["MinSensitivity"] = 0.3,
                            ["MaxSensitivity"] = 1
                        },
                        ["Magnetism"] = {
                            ["Enabled"] = true,
                            ["MaxAngleHorizontal"] = 0.3490658503988659,
                            ["MaxAngleVertical"] = 0.17453292519943295,
                            ["PullStrength"] = 0.3141592653589793,
                            ["StopThreshold"] = 0.003490658503988659,
                            ["MaxDistance"] = 200
                        },
                        ["VerticalMagnetism"] = {
                            ["Enabled"] = true,
                            ["MaxAngleHorizontal"] = 0.17453292519943295,
                            ["MaxAngleVertical"] = 0.3490658503988659,
                            ["PullStrength"] = 0.20943951023931956,
                            ["StopThreshold"] = 0.008726646259971648,
                            ["MaxDistance"] = 200
                        },
                        ["RecoilAssist"] = {
                            ["Enabled"] = true,
                            ["ReductionAmount"] = 0.75,
                            ["RequiresTarget"] = false
                        }
                    },
                    ["PLAYER"] = {
                        ["TargetSelection"] = {
                            ["Enabled"] = true,
                            ["MaxDistance"] = 125,
                            ["MaxAngle"] = 0.5235987755982988
                        },
                        ["Friction"] = {
                            ["Enabled"] = true,
                            ["BubbleRadius"] = 2.4,
                            ["MinSensitivity"] = 0.5,
                            ["MaxSensitivity"] = 1
                        },
                        ["Magnetism"] = {
                            ["Enabled"] = true,
                            ["MaxAngleHorizontal"] = 0.20943951023931956,
                            ["MaxAngleVertical"] = 0.10471975511965978,
                            ["PullStrength"] = 0.11344640137963143,
                            ["StopThreshold"] = 0.008726646259971648,
                            ["MaxDistance"] = 125
                        },
                        ["VerticalMagnetism"] = {
                            ["Enabled"] = true,
                            ["MaxAngleHorizontal"] = 0.20943951023931956,
                            ["MaxAngleVertical"] = 0.10471975511965978,
                            ["PullStrength"] = 0.11344640137963143,
                            ["StopThreshold"] = 0.008726646259971648,
                            ["MaxDistance"] = 125
                        },
                        ["RecoilAssist"] = {
                            ["Enabled"] = true,
                            ["ReductionAmount"] = 0.5,
                            ["RequiresTarget"] = false
                        }
                    }
                },
                ["ACTIVE_PLACE_ENVIRONMENT"] = v6,
                ["GAMEMODE_SUBPLACE_IDS"] = {
                    ["Prod"] = v2,
                    ["Dev"] = v1
                },
                ["ACTIVE_GAMEMODE_SUBPLACE_IDS"] = v7,
                ["GAMEMODE_PLACE_IDS"] = {
                    ["Deathmatch"] = v7.Deathmatch,
                    ["Casual"] = v7.Defusal,
                    ["Competitive"] = v10
                }
            })
        end
        for _, v11 in pairs(v2) do
            if v11 == v4 then
                v12 = true
                ::l12::
                if v12 then
                    v6 = "Prod"
                elseif game.GameId == 7633926880 then
                    v6 = "Prod"
                else
                    v6 = "Dev"
                end
                goto l8
            end
        end
        local v12 = false
        goto l12
    end
end
local v13 = false
goto l4