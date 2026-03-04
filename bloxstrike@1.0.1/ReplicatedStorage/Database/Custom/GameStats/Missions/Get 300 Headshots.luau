local v1 = {
    ["MissionId"] = "Get 300 Headshots",
    ["Target"] = 300,
    ["Type"] = "monthly",
    ["Rewards"] = {
        {
            ["type"] = "Credits",
            ["amount"] = 150
        }
    }
}
return table.freeze(v1)