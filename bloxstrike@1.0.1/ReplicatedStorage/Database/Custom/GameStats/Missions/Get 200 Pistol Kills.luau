local v1 = {
    ["MissionId"] = "Get 200 Pistol Kills",
    ["Target"] = 200,
    ["Type"] = "monthly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 150
        }
    }
}
return table.freeze(v1)