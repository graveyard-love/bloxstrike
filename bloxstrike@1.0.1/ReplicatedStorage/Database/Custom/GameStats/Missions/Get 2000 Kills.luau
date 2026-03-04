local v1 = {
    ["MissionId"] = "Get 2000 Kills",
    ["Target"] = 2000,
    ["Type"] = "monthly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 140
        }
    }
}
return table.freeze(v1)