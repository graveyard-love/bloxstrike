local v1 = {
    ["MissionId"] = "Get 500 Kills",
    ["Target"] = 500,
    ["Type"] = "weekly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 32
        }
    }
}
return table.freeze(v1)