local v1 = {
    ["MissionId"] = "Get 7 Kills",
    ["Target"] = 7,
    ["Type"] = "hourly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 1
        }
    }
}
return table.freeze(v1)