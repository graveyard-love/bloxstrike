local v1 = {
    ["MissionId"] = "Get 100 Assists",
    ["Target"] = 100,
    ["Type"] = "weekly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 30
        }
    }
}
return table.freeze(v1)