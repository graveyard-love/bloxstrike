local v1 = {
    ["MissionId"] = "Get 20 Rifle Kills",
    ["Target"] = 20,
    ["Type"] = "daily",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 10
        }
    }
}
return table.freeze(v1)