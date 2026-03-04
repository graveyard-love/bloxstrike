local v1 = {
    ["MissionId"] = "Win 5 Matches",
    ["Target"] = 5,
    ["Type"] = "daily",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 12
        }
    }
}
return table.freeze(v1)