local v1 = {
    ["MissionId"] = "Get 400 Assists",
    ["Target"] = 400,
    ["Type"] = "monthly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 125
        }
    }
}
return table.freeze(v1)