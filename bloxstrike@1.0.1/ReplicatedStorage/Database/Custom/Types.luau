local v1 = game:GetService("ReplicatedStorage")
local v2 = v1:WaitForChild("Packages")
local v3 = v1:WaitForChild("Shared")
require(v3:WaitForChild("Janitor"))
require(v3:WaitForChild("Promise"))
require(v2:WaitForChild("Signal"))
require(v1.Database.Custom.GameStats.NumberSlots)
return {}