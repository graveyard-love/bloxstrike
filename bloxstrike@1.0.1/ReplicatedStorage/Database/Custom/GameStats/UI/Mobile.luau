local v_u_1 = {
    ["REQUIRED_BUTTONS"] = table.freeze({
        "Shoot",
        "Shop",
        "Reload",
        "Jump",
        "Crouch",
        "Aim",
        "Drop",
        "Interact",
        "Inspect",
        "SwapTeam",
        "Configure",
        "Menu",
        "Ping"
    }),
    ["MIN_SIZE"] = 0.05,
    ["MAX_SIZE"] = 0.4,
    ["MIN_POSITION"] = -2,
    ["MAX_POSITION"] = 2
}
local v_u_2 = {}
local v3 = {
    ["Position"] = {
        ["X"] = 0.71,
        ["Y"] = 0.275
    },
    ["Size"] = {
        ["X"] = 0.08,
        ["Y"] = 0.125
    }
}
v_u_2.Inspect = v3
local v4 = {
    ["Position"] = {
        ["X"] = 0.796,
        ["Y"] = 0.328
    },
    ["Size"] = {
        ["X"] = 0.0877,
        ["Y"] = 0.132
    }
}
v_u_2.Aim = v4
local v5 = {
    ["Position"] = {
        ["X"] = 0.07,
        ["Y"] = 0.382
    },
    ["Size"] = {
        ["X"] = 0.0826,
        ["Y"] = 0.1529
    }
}
v_u_2.Crouch = v5
local v6 = {
    ["Position"] = {
        ["X"] = 0.915,
        ["Y"] = 0.315
    },
    ["Size"] = {
        ["X"] = 0.0638,
        ["Y"] = 0.106
    }
}
v_u_2.Drop = v6
local v7 = {
    ["Position"] = {
        ["X"] = 0.7572,
        ["Y"] = 0.7332
    },
    ["Size"] = {
        ["X"] = 0.1151,
        ["Y"] = 0.1779
    }
}
v_u_2.Interact = v7
local v8 = {
    ["Position"] = {
        ["X"] = 0.919,
        ["Y"] = 0.478
    },
    ["Size"] = {
        ["X"] = 0.0823,
        ["Y"] = 0.1551
    }
}
v_u_2.Jump = v8
local v9 = {
    ["Position"] = {
        ["X"] = 0.835,
        ["Y"] = 0.0645
    },
    ["Size"] = {
        ["X"] = 0.0649,
        ["Y"] = 0.0962
    }
}
v_u_2.Menu = v9
local v10 = {
    ["Position"] = {
        ["X"] = 0.8195,
        ["Y"] = 0.5021
    },
    ["Size"] = {
        ["X"] = 0.1151,
        ["Y"] = 0.1779
    }
}
v_u_2.Shoot = v10
local v11 = {
    ["Position"] = {
        ["X"] = 0.7098,
        ["Y"] = 0.4151
    },
    ["Size"] = {
        ["X"] = 0.066,
        ["Y"] = 0.1233
    }
}
v_u_2.Reload = v11
local v12 = {
    ["Position"] = {
        ["X"] = 0.07,
        ["Y"] = 0.525
    },
    ["Size"] = {
        ["X"] = 0.075,
        ["Y"] = 0.1334
    }
}
v_u_2.Shop = v12
local v13 = {
    ["Position"] = {
        ["X"] = 0.9,
        ["Y"] = 0.0645
    },
    ["Size"] = {
        ["X"] = 0.0649,
        ["Y"] = 0.0962
    }
}
v_u_2.SwapTeam = v13
local v14 = {
    ["Position"] = {
        ["X"] = 0.9,
        ["Y"] = 0.17
    },
    ["Size"] = {
        ["X"] = 0.0649,
        ["Y"] = 0.0962
    }
}
v_u_2.Configure = v14
local v15 = {
    ["Position"] = {
        ["X"] = 0.729,
        ["Y"] = 0.561
    },
    ["Size"] = {
        ["X"] = 0.066,
        ["Y"] = 0.1233
    }
}
v_u_2.Ping = v15
local function v_u_18(p16)
    local v17 = {
        ["Position"] = {
            ["X"] = p16.Position.X,
            ["Y"] = p16.Position.Y
        },
        ["Size"] = {
            ["X"] = p16.Size.X,
            ["Y"] = p16.Size.Y
        }
    }
    return v17
end
local function v_u_27(p19)
    if typeof(p19) ~= "table" then
        return false
    end
    local v20 = p19.Position
    local v21 = p19.Size
    if typeof(v20) ~= "table" or typeof(v21) ~= "table" then
        return false
    end
    local v22 = v20.X
    local v23
    if typeof(v22) == "number" and (v22 == v22 and v22 ~= (1 / 0)) then
        v23 = v22 ~= (-1 / 0)
    else
        v23 = false
    end
    if v23 then
        local v24 = v20.Y
        if typeof(v24) == "number" and (v24 == v24 and v24 ~= (1 / 0)) then
            v23 = v24 ~= (-1 / 0)
        else
            v23 = false
        end
        if v23 then
            local v25 = v21.X
            if typeof(v25) == "number" and (v25 == v25 and v25 ~= (1 / 0)) then
                v23 = v25 ~= (-1 / 0)
            else
                v23 = false
            end
            if v23 then
                local v26 = v21.Y
                if typeof(v26) == "number" and (v26 == v26 and v26 ~= (1 / 0)) then
                    v23 = v26 ~= (-1 / 0)
                else
                    v23 = false
                end
            end
        end
    end
    return v23
end
function v_u_1.GetButtonNames()
    return table.clone(v_u_1.REQUIRED_BUTTONS)
end
function v_u_1.GetDefaultLayout()
    local v28 = {}
    for _, v29 in ipairs(v_u_1.REQUIRED_BUTTONS) do
        v28[v29] = v_u_18(v_u_2[v29])
    end
    return v28
end
function v_u_1.GetDefaultButtonLayout(p30)
    local v31 = v_u_2[p30]
    if v31 then
        return v_u_18(v31)
    end
    local v32 = {
        ["Position"] = {
            ["X"] = 0.5,
            ["Y"] = 0.5
        },
        ["Size"] = {
            ["X"] = 0.1,
            ["Y"] = 0.1
        }
    }
    return v32
end
function v_u_1.ClampButtonLayout(p33)
    local v34 = p33.Size.X
    local v35 = v_u_1.MIN_SIZE
    local v36 = v_u_1.MAX_SIZE
    local v37 = math.clamp(v34, v35, v36)
    local v38 = p33.Size.Y
    local v39 = v_u_1.MIN_SIZE
    local v40 = v_u_1.MAX_SIZE
    local v41 = math.clamp(v38, v39, v40)
    local v42 = {}
    local v43 = {}
    local v44 = p33.Position.X
    local v45 = v_u_1.MIN_POSITION
    local v46 = v_u_1.MAX_POSITION
    v43.X = math.clamp(v44, v45, v46)
    local v47 = p33.Position.Y
    local v48 = v_u_1.MIN_POSITION
    local v49 = v_u_1.MAX_POSITION
    v43.Y = math.clamp(v47, v48, v49)
    v42.Position = v43
    v42.Size = {
        ["X"] = v37,
        ["Y"] = v41
    }
    return v42
end
function v_u_1.HasAllRequiredButtons(p50)
    if typeof(p50) ~= "table" then
        return false
    end
    for _, v51 in ipairs(v_u_1.REQUIRED_BUTTONS) do
        if not v_u_27(p50[v51]) then
            return false
        end
    end
    return true
end
function v_u_1.SanitizeLayout(p52)
    local v53 = v_u_1.GetDefaultLayout()
    if typeof(p52) ~= "table" then
        return v53
    end
    for _, v54 in ipairs(v_u_1.REQUIRED_BUTTONS) do
        local v55 = p52[v54]
        if v_u_27(v55) then
            local v56 = v_u_1.ClampButtonLayout
            local v57 = {
                ["Position"] = {
                    ["X"] = v55.Position.X,
                    ["Y"] = v55.Position.Y
                },
                ["Size"] = {
                    ["X"] = v55.Size.X,
                    ["Y"] = v55.Size.Y
                }
            }
            v53[v54] = v56(v57)
        end
    end
    return v53
end
return v_u_1