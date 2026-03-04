local v1 = {
    ["MissionId"] = "Get 1 Kill While Low HP",
    ["Target"] = 1,
    ["Type"] = "hourly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 2
        }
    }
}
return table.freeze(v1)