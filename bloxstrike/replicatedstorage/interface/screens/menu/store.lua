-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_marketplace = game:GetService("MarketplaceService")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_policy = game:GetService("PolicyService")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
local v_u4 = require(v_u_replicatedstorage.Components.Common.InterfaceAnimations.ActivateButton)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Bundles)
local v_u6 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u7 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v_u8 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u9 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u10 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u11 = require(v_u_replicatedstorage.Packages.Observers)
local v12 = require(v_u_replicatedstorage.Shared.Spring)
local v_u13 = require(v_u_replicatedstorage.Database.Custom.GameStats.Monetization.DevProducts)
local v_u14 = require(v_u_replicatedstorage.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u15 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u_new = v12.new(1, 8, 0)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u16 = -1
local v_u17 = true
local v_u18 = nil
local v_u19 = nil
local v_u_fromrgb = Color3.fromRGB(243, 243, 243)
local v_u_fromrgb = Color3.fromRGB(125, 206, 243)
local v_u_fromrgb = Color3.fromRGB(100, 168, 195)
local v_u_fromrgb = Color3.fromRGB(53, 83, 99)
local v_u_fromrgb = Color3.fromRGB(127, 143, 144)
local v_u_fromoffset = UDim2.fromOffset(215, 125)
local v_u_fromoffset = UDim2.fromOffset(215, 150)
local v_u20 = {
	["Blue"] = 1,
	["Purple"] = 2,
	["Pink"] = 3,
	["Red"] = 4,
	["Special"] = 5
}
local v_u21 = nil
local v_u22 = nil
local v_u23 = {
	["isOpening"] = false,
	["isPendingOpenRequest"] = false,
	["currentTween"] = nil,
	["currentZoomTween"] = nil,
	["renderConnection"] = nil,
	["currentInventoryItem"] = nil,
	["currentCaseIdentifier"] = nil
}
local function v_u24(arg1, arg2)
	for _, v1 in ipairs(arg1:GetChildren()) do
		if not table.find(arg2, v1.Name) then
			v1:Destroy()
		end
	end
end
local function v_u25(arg1)
	local v_fromisodate = DateTime.fromIsoDate(arg1)
	local v_now = DateTime.now()
	if v_fromisodate.UnixTimestamp - v_now.UnixTimestamp <= 0 then
		return "00:00:00:00"
	end
	local v_floor = math.floor(UNNAMED_1729000416072 / 86400)
	local v_floor = math.floor(UNNAMED_1729000416072 % 86400 / 3600)
	local v_floor = math.floor(UNNAMED_1729000416072 % 3600 / 60)
	return string.format("%02d:%02d:%02d:%02d", v_floor, v_floor, v_floor, (math.floor(UNNAMED_1729000416072 % 60)))
end
local function v_u26(self)
	-- upvalues: (copy) v_u_tween, (copy) v_u9, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb
	local v_u_size = self.Size
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size, (ref) v_u9, (ref) v_u_fromrgb, (ref) v_u_fromrgb
		local v_new = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
		v_u_tween:Create(self, v_new, v1):Play()
		v_u9.broadcastRouter("RunInterfaceSound", "UI Highlight")
		if self.Name ~= "Credits" and not self:GetAttribute("Selected") then
			v_u_tween:Create(self.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
				["BackgroundTransparency"] = 0.8,
				["BackgroundColor3"] = v_u_fromrgb
			}):Play()
			v_u_tween:Create(self.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
				["TextColor3"] = v_u_fromrgb
			}):Play()
		end
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size, (ref) v_u_fromrgb
		v_u_tween:Create(self, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
			["Size"] = v_u_size
		}):Play()
		if self.Name ~= "Credits" and not self:GetAttribute("Selected") then
			v_u_tween:Create(self.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
				["TextColor3"] = v_u_fromrgb
			}):Play()
			v_u_tween:Create(self.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
				["BackgroundTransparency"] = 1
			}):Play()
		end
	end)
	self.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
	end)
end
local function v_u27(arg1)
	local v1 = 0
	for _, v2 in ipairs(arg1.contents) do
		v1 = v1 + v2.weight
	end
	local v3 = math.random() * v1
	local v4 = 0
	for _, v5 in ipairs(arg1.contents) do
		v4 = v4 + v5.weight
		if v3 <= v4 then
			return v5, v5.isSpecial or false
		end
	end
	local v6 = arg1.contents[1]
	return v6, v6.isSpecial or false
end
local function v_u28(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u27
	local v1 = {}
	for v2 = 1, 75 do
		if v2 == arg3 then
			table.insert(v1, {
				["item"] = arg2,
				["isGold"] = arg4
			})
		else
			local v3, v4 = v_u27(arg1)
			table.insert(v1, {
				["item"] = v3,
				["isGold"] = v4
			})
		end
	end
	return v1
end
local function v_u29(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u15, (copy) v_u6
	local v_casescroll = v_u_replicatedstorage.Assets.UI.Store.CaseScroll
	local v1
	if arg2.isGold then
		v1 = v_casescroll:FindFirstChild("GoldTemplate")
	else
		v1 = v_casescroll:FindFirstChild("ItemTemplate")
	end
	if v1 then
		local v_clone = v1:Clone()
		v_clone.Name = tostring(arg3)
		v_clone.LayoutOrder = arg3
		v_clone.Size = arg4
		v_clone.SizeConstraint = Enum.SizeConstraint.RelativeXY
		v_clone.AutomaticSize = Enum.AutomaticSize.None
		v_clone.Parent = arg1
		if not arg2.isGold then
			local v2 = v_u15[arg2.item.rarity]
			local v_getskininformation = v_u6.GetSkinInformation(arg2.item.skin.weaponName, arg2.item.skin.skinName)
			local v_frame = v_clone:FindFirstChild("Frame")
			if v2 and (v_getskininformation and v_frame) then
				local v_rarityframe = v_frame:FindFirstChild("RarityFrame")
				local v3 = v_rarityframe and v_rarityframe:FindFirstChild("UIGradient")
				if v3 then
					v3.Color = v2.ColorSequence
				end
				local v_icon = v_frame:FindFirstChild("Icon")
				if v_icon then
					local v4 = ""
					if v_getskininformation.wearImages and #v_getskininformation.wearImages > 0 then
						v4 = v_getskininformation.wearImages[1].assetId
					elseif v_getskininformation.charmImages and #v_getskininformation.charmImages > 0 then
						v4 = v_getskininformation.charmImages[1].assetId
					elseif v_getskininformation.imageAssetId then
						v4 = v_getskininformation.imageAssetId
					end
					v_icon.Image = v4
				end
				local v_rarity = v_frame:FindFirstChild("Rarity")
				if v_rarity then
					v_rarity.ImageColor3 = v2.Color
				end
			end
		end
	else
		warn("[Store] Missing case scroll template")
	end
end
local function v_u30(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u29
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v1:IsA("Frame") or (v1:IsA("ImageLabel") or v1:IsA("ImageButton")) then
			v1:Destroy()
		end
	end
	local v_uilistlayout = arg1:FindFirstChildOfClass("UIListLayout")
	if v_uilistlayout then
		v_uilistlayout.FillDirection = Enum.FillDirection.Horizontal
		v_uilistlayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		v_uilistlayout.VerticalAlignment = Enum.VerticalAlignment.Center
		v_uilistlayout.Padding = UDim.new(0, arg4)
	end
	for v2, v3 in ipairs(arg2) do
		v_u29(arg1, v3, v2, arg3)
	end
end
local function v_u31(arg1, arg2)
	local v_max = math.max(arg1.AbsoluteSize.X, 1)
	local v_max = math.max(arg2 / v_max, 1)
	arg1.CanvasSize = UDim2.fromScale(v_max, 0)
	arg1:SetAttribute("ScrollMaxOffset", (math.max(0, arg2 - v_max)))
	arg1:SetAttribute("ScrollViewportWidth", v_max)
end
local function v_u32(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (copy) v_u_tween, (copy) v_u23, (copy) v_u_run
	local v_new = TweenInfo.new(7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local v_u_create = v_u_tween:Create(arg1, v_new, {
		["CanvasPosition"] = Vector2.new(arg3, 0)
	})
	local v_create = v_u_tween:Create(arg2, v_new, {
		["CanvasPosition"] = Vector2.new(arg4, 0)
	})
	v_u23.currentTween = v_u_create
	v_u23.currentZoomTween = v_create
	local v_u1 = 0
	local v_u2 = nil
	v_u2 = v_u_run.RenderStepped:Connect(function()
		-- upvalues: (ref) v_u23, (ref) v_u2, (copy) arg1, (copy) arg5, (ref) v_u1, (copy) arg6, (copy) v_u_create
		if v_u23.isOpening then
			local v1 = math.floor(arg5 <= 0 and 0 or arg1.CanvasPosition.X / arg5) + 1
			if v_u1 < v1 and v1 <= 75 then
				arg6(v1)
				v_u1 = v1
			end
			if v_u_create.PlaybackState == Enum.PlaybackState.Completed and v_u2 then
				v_u2:Disconnect()
				v_u2 = nil
				v_u23.renderConnection = nil
			end
		elseif v_u2 then
			v_u2:Disconnect()
			v_u2 = nil
			v_u23.renderConnection = nil
		end
	end)
	v_u23.renderConnection = v_u2
	v_u_create.Completed:Connect(function()
		-- upvalues: (ref) v_u2, (ref) v_u23
		if v_u2 then
			v_u2:Disconnect()
			v_u2 = nil
			v_u23.renderConnection = nil
		end
	end)
	v_u_create:Play()
	v_create:Play()
	return v_u_create
end
local function v_u33(self)
	-- upvalues: (copy) v_u9, (copy) v_u_tween, (ref) v_u17, (copy) v_u_marketplace, (copy) v_u_localplayer, (copy) v_u13
	local v_u_size = self.Size
	self.Button.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u9, (copy) self, (ref) v_u_tween, (copy) v_u_size
		v_u9.broadcastRouter("RunInterfaceSound", "UI Highlight")
		self.Hoverstroke.Enabled = true
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.fromScale(v2.X.Scale * 0.975, v2.Y.Scale * 0.975)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.Button.MouseLeave:Connect(function()
		-- upvalues: (copy) self, (ref) v_u_tween, (copy) v_u_size
		self.Hoverstroke.Enabled = false
		v_u_tween:Create(self, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Size"] = v_u_size
		}):Play()
	end)
	self.Button.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u_tween, (copy) self, (copy) v_u_size
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.fromScale(v2.X.Scale * 0.95, v2.Y.Scale * 0.95)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.Button.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.fromScale(v2.X.Scale * 0.975, v2.Y.Scale * 0.975)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u17, (ref) v_u_marketplace, (ref) v_u_localplayer, (ref) v_u13, (copy) self
		if v_u17 then
			v_u_marketplace:PromptProductPurchase(v_u_localplayer, v_u13[self.Name].DevProductId)
		end
	end)
end
function v_u1.PurchaseCase(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u8, (ref) v_u17, (copy) v_u_marketplace, (copy) v_u13, (copy) v_u1
	local v_get = v_u2.Get(v_u_localplayer, "Credits")
	local v1 = arg1.price * arg2
	if v1 <= v_get then
		v_u8.Store.PurchaseCase.Send({
			["CaseId"] = arg1.caseId,
			["Amount"] = arg2
		})
		return
	elseif v_u17 then
		local v2 = v1 - v_get
		v_u_marketplace:PromptProductPurchase(v_u_localplayer, v_u13[v2 <= 300 and "+ 300 Credits" or (v2 <= 945 and "+ 945 Credits" or (v2 <= 2700 and "+ 2,700 Credits" or "+ 9,500 Credits"))].DevProductId)
		v_u1.CloseCaseContent("Store")
		v_u1.OpenTab("Credits")
	end
end
function v_u1.CreateCaseTemplate(arg1, arg2)
	-- upvalues: (copy) v_u15, (copy) v_u_replicatedstorage, (copy) v_u4, (copy) v_u9, (copy) v_u1
	local v1 = v_u15[arg1.caseRarity]
	if v1 then
		local v_clone = v_u_replicatedstorage.Assets.UI.Store.CaseTemplate:Clone()
		v_clone.Contents.Rarity.UIGradient.Color = v1.ColorSequence
		v_clone.Buy.Credits.Amount.Text = ("%*"):format((tostring(arg1.price):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
		v_clone.Contents.Glow.ImageColor3 = v1.Color
		v_clone.Alert.Visible = arg1.status == "featured"
		v_clone.Contents.Icon.Image = arg1.imageAssetId
		v_clone.Footer.CaseName.Text = arg1.name
		v_clone.Parent = arg2
		v_clone.Name = arg1.caseId
		v_u4(v_clone.Purchase)
		v_clone.Purchase.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u9, (ref) v_u1, (copy) arg1
			v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
			v_u1.OpenCaseContent(arg1.caseId, "Inspect")
		end)
		v_u4(v_clone.Gift)
		v_clone.Gift.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg1
			v_u1.OpenGift(arg1.caseId, "Case")
		end)
	end
end
function v_u1.ActivateGiftTemplate(arg1, arg2)
	-- upvalues: (copy) v_u9, (copy) v_u_tween, (copy) v_u_localplayer, (ref) v_u21, (copy) v_u2, (copy) v_u7, (copy) v_u8, (copy) v_u_marketplace, (copy) v_u14, (copy) v_u13
	arg1.Button.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u_tween, (copy) arg1
		v_u9.broadcastRouter("RunInterfaceSound", "UI Highlight")
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_tween:Create(arg1.Player.Username, v_new, {
			["TextColor3"] = Color3.fromRGB(255, 200, 0)
		}):Play()
	end)
	arg1.Button.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg1
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_tween:Create(arg1.Player.Username, v_new, {
			["TextColor3"] = Color3.fromRGB(190, 190, 190)
		}):Play()
	end)
	arg1.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) arg2, (ref) v_u_localplayer, (ref) v_u21, (ref) v_u9, (ref) v_u2, (ref) v_u7, (ref) v_u8, (ref) v_u_marketplace, (ref) v_u14, (ref) v_u13
		if arg2 == v_u_localplayer.UserId then
			return
		else
			local v_giftproductname = v_u21:GetAttribute("GiftProductName")
			local v_giftproducttype = v_u21:GetAttribute("GiftProductType")
			v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
			if v_giftproducttype == "Case" then
				if v_u2.Get(v_u_localplayer, "Credits") >= v_u7.GetCase(v_giftproductname).price then
					local v1 = {
						["RecipientUserId"] = tostring(arg2),
						["CaseId"] = v_giftproductname
					}
					v_u8.Store.GiftCase.Send(v1)
					v_u21.Gift.Visible = false
				end
			else
				local v2 = {
					["RecipientUserId"] = tostring(arg2),
					["ProductName"] = v_giftproductname,
					["ProductType"] = v_giftproducttype
				}
				v_u8.Store.CreateGift.Send(v2)
				if v_giftproducttype == "Gamepass" then
					v_u_marketplace:PromptGamePassPurchase(v_u_localplayer, v_u14[v_giftproductname].GamepassId)
					return
				elseif v_giftproducttype == "DevProduct" then
					v_u_marketplace:PromptProductPurchase(v_u_localplayer, v_u13[v_giftproductname].DevProductId)
				end
			end
		end
	end)
end
function v_u1.SetupCreditsFrame(self)
	-- upvalues: (copy) v_u33, (copy) v_u4, (ref) v_u17, (copy) v_u_marketplace, (copy) v_u_localplayer, (copy) v_u13, (copy) v_u1
	v_u33(self)
	v_u4(self.Purchase)
	self.Purchase.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u17, (ref) v_u_marketplace, (ref) v_u_localplayer, (ref) v_u13, (copy) self
		if v_u17 then
			v_u_marketplace:PromptProductPurchase(v_u_localplayer, v_u13[self.Name].DevProductId)
		end
	end)
	v_u4(self.Gift)
	self.Gift.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) self
		v_u1.OpenGift("Gift " .. self.Name, "DevProduct")
	end)
end
function v_u1.UpdateCases()
	-- upvalues: (copy) v_u7, (copy) v_u24, (ref) v_u21, (copy) v_u1
	local v_getfeaturedcases = v_u7.GetFeaturedCases(6)
	v_u24(v_u21.Tabs.Container.Featured.Container.Items, { "UIListLayout" })
	local v_getcases = v_u7.GetCases()
	v_u24(v_u21.Tabs.Container.Cases.Cases, { "UIListLayout", "UIGridLayout" })
	for _, v1 in ipairs(v_getfeaturedcases) do
		v_u1.CreateCaseTemplate(v1, v_u21.Tabs.Container.Featured.Container.Items)
	end
	for _, v2 in ipairs(v_getcases) do
		v_u1.CreateCaseTemplate(v2, v_u21.Tabs.Container.Cases.Cases)
	end
end
function v_u1.OpenCaseContent(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (ref) v_u18, (ref) v_u19, (ref) v_u21, (ref) v_u22, (copy) v_u3, (copy) v_u24, (copy) v_u20, (copy) v_u6, (copy) v_u15, (copy) v_u_replicatedstorage
	local v_getcase = v_u7.GetCase(arg1)
	v_u18 = arg3
	v_u19 = v_getcase
	if v_getcase then
		v_u21.CaseContent.Title.Text = arg2 == "Inspect" and "Inspect Container" or "Unlock Container"
		v_u21.CaseContent.List.Buy.Header.TextLabel.Text = ("BUY (%*)"):format((tostring(v_getcase.price):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
		v_u21.CaseContent.List.Amount.Visible = arg2 == "Inspect"
		v_u21.CaseContent.List.Amount.Header.TextLabel.Text = "1"
		v_u21.CaseContent.List.Buy.Visible = arg2 == "Inspect"
		v_u21.CaseContent.CaseName.Text = v_getcase.name
		v_u21.CaseContent.List.Open.Visible = arg2 == "Open"
		v_u21.CaseContent:SetAttribute("State", arg2)
		v_u21.Tabs.Container.Visible = false
		v_u21.CaseContent.Visible = true
		v_u22.Menu.Top.Visible = false
		v_u21.Top.Visible = false
		v_u21.Visible = true
		for _, v1 in ipairs(v_u21.CaseContent.List.Amount.Container:GetChildren()) do
			if v1:IsA("TextButton") then
				v1.Frame.BackgroundTransparency = v1.Name == "1" and 0 or 1
				v1:SetAttribute("Selected", v1.Name == "1")
			end
		end
		for _, v2 in ipairs(v_u21.CaseContent.CaseChances:GetChildren()) do
			if v2:IsA("TextLabel") then
				v2.Visible = false
			end
		end
		for _, v3 in ipairs(v_getcase.rarityChances) do
			local v4 = v_u21.CaseContent.CaseChances:FindFirstChild(v3.rarity)
			v4.Text = ("%*: %*%%"):format(v3.rarity, v3.chance)
			v4.Visible = true
		end
		if v_getcase.caseType == "Case" then
			local v5 = 0
			for _, v6 in ipairs(v_getcase.rarityChances) do
				v5 = v5 + v6.chance
			end
			v_u21.CaseContent.CaseChances.Special.Text = ("Special: %*%%"):format(math.round((100 - v5) * 100) / 100)
			v_u21.CaseContent.CaseChances.Special.Visible = true
		end
		v_u3.ShowCaseScene(v_getcase.caseType == "Charm Capsule" and "Charm" or "Case", v_getcase.name)
		task.defer(function()
			-- upvalues: (ref) v_u21, (ref) v_u22
			v_u21.Visible = true
			v_u21.CaseContent.Visible = true
			if v_u22 and v_u22.Menu then
				v_u22.Menu.Visible = true
			end
		end)
		v_u24(v_u21.CaseContent.Container, { "UIGridLayout", "UIPadding" })
		local v_clone = table.clone(v_getcase.contents)
		table.sort(v_clone, function(arg1, arg2)
			-- upvalues: (ref) v_u20
			return (v_u20[arg1.rarity] or 0) < (v_u20[arg2.rarity] or 0)
		end)
		for _, v7 in ipairs(v_clone) do
			local v_getskininformation = v_u6.GetSkinInformation(v7.skin.weaponName, v7.skin.skinName)
			local v8 = v_u15[v7.rarity]
			local v9
			if v_getskininformation.wearImages and v_getskininformation.wearImages[1] then
				v9 = v_getskininformation.wearImages[1].assetId
			elseif v_getskininformation.charmImages and v_getskininformation.charmImages[1] then
				v9 = v_getskininformation.charmImages[1].assetId
			else
				v9 = v_getskininformation.imageAssetId or ""
			end
			local v_clone = v_u_replicatedstorage.Assets.UI.Store.ItemTemplate:Clone()
			v_clone.Content.RarityFrame.UIGradient.Color = v8.ColorSequence
			v_clone.Footer.WeaponName.Text = v7.skin.weaponName
			v_clone.Content.Rarity.ImageColor3 = v8.Color
			v_clone.Footer.SkinName.Text = v7.skin.skinName
			v_clone.Parent = v_u21.CaseContent.Container
			v_clone.Content.Icon.Image = v9
		end
		if v_getcase.caseType == "Case" then
			v_u_replicatedstorage.Assets.UI.Store.GoldTemplate:Clone().Parent = v_u21.CaseContent.Container
			return
		end
	end
end
function v_u1.OpenGift(arg1, arg2)
	-- upvalues: (ref) v_u21
	v_u21:SetAttribute("GiftProductName", arg1)
	v_u21:SetAttribute("GiftProductType", arg2)
	v_u21.Gift.Visible = true
end
function v_u1.SearchPlayerGift(arg1)
	-- upvalues: (ref) v_u21, (copy) v_u_players, (copy) v_u_replicatedstorage, (copy) v_u1
	local v_searchresult = v_u21.Gift.Container:FindFirstChild("SearchResult")
	if v_searchresult then
		v_searchresult:Destroy()
	end
	local v_u1 = tonumber(arg1)
	if arg1 == "" or not v_u1 then
		return
	else
		for _, v2 in ipairs(v_u21.Gift.Container:GetChildren()) do
			if v2:IsA("Frame") then
				v2.Visible = false
			end
		end
		local v3, v4 = pcall(function()
			-- upvalues: (ref) v_u_players, (copy) v_u1
			return v_u_players:GetNameFromUserIdAsync(v_u1)
		end)
		if v3 then
			local v_clone = v_u_replicatedstorage.Assets.UI.Store.PlayerTemplate:Clone()
			v_clone.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v_u1)
			v_clone.Player.Username.Text = ("@%*"):format(v4)
			v_clone.Parent = v_u21.Gift.Container
			v_clone.Name = "SearchResult"
			v_u1.ActivateGiftTemplate(v_clone, v_u1)
		end
	end
end
function v_u1.OpenTab(arg1)
	-- upvalues: (ref) v_u17, (copy) v_u9, (ref) v_u21, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb
	if arg1 == "Credits" and not v_u17 then
		v_u9.broadcastRouter("CreateMenuNotification", "Error", "Paid random items are not allowed in your region.")
	else
		for _, v1 in ipairs(v_u21.Top.Categories:GetChildren()) do
			if v1:IsA("TextButton") then
				v1:SetAttribute("Selected", v1.Name == arg1)
				if v1.Name == arg1 and v1.Name ~= "Credits" then
					v1.HoverFrame.BackgroundTransparency = 0
					v1.HoverFrame.BackgroundColor3 = v_u_fromrgb
					v1.TextLabel.TextColor3 = v_u_fromrgb
				elseif v1.Name ~= "Credits" then
					v1.HoverFrame.BackgroundColor3 = Color3.fromRGB(243, 243, 243)
					v1.TextLabel.TextColor3 = v_u_fromrgb
					v1.HoverFrame.BackgroundTransparency = 1
				end
				v1:SetAttribute("Selected", v1.Name == arg1)
			end
		end
		for _, v2 in ipairs(v_u21.Tabs.Container:GetChildren()) do
			if v2:IsA("Frame") then
				v2.Visible = v2.Name == arg1
			end
		end
	end
end
function v_u1.OpenCase(arg1, arg2, arg3)
	-- upvalues: (copy) v_u23, (copy) v_u7, (ref) v_u21, (ref) v_u22, (copy) v_u28, (copy) v_u30, (copy) v_u_fromoffset, (copy) v_u_fromoffset, (copy) v_u31, (copy) v_u32, (copy) v_u9, (copy) v_u8, (copy) v_u3, (copy) v_u10
	v_u23.isPendingOpenRequest = false
	v_u23.currentCaseIdentifier = arg3
	local v_u_getcase = v_u7.GetCase(arg1)
	if v_u_getcase then
		v_u23.isOpening = true
		v_u23.currentInventoryItem = arg2
		v_u21.CaseContent.Visible = false
		local function v1()
			-- upvalues: (ref) v_u23, (ref) v_u22, (copy) v_u_getcase, (ref) v_u21, (copy) arg2, (ref) v_u28, (ref) v_u30, (ref) v_u_fromoffset, (ref) v_u_fromoffset, (ref) v_u31, (ref) v_u32, (ref) v_u9, (ref) v_u8, (ref) v_u3, (ref) v_u10
			if not v_u23.isOpening then
				return
			end
			v_u22.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v_u_getcase.name)
			v_u22.Menu.OpenCase.Visible = true
			v_u21.Visible = false
			local v_opencase = v_u22.Menu.OpenCase
			local v_canvasgroup = v_opencase:FindFirstChild("CanvasGroup")
			local v_zoom = v_opencase:FindFirstChild("Zoom")
			if not (v_canvasgroup and v_zoom) then
				warn("[Store] Missing CanvasGroup or Zoom group in OpenCase UI")
				return
			end
			local v_container = v_canvasgroup:FindFirstChild("Container")
			local v_container = v_zoom:FindFirstChild("Container")
			if not (v_container and v_container) then
				warn("[Store] Missing scroll containers for case opening")
				return
			end
			local v1 = nil
			local v2 = false
			for _, v3 in ipairs(v_u_getcase.contents) do
				if v3.skin.skinName == arg2.Skin and v3.skin.weaponName == arg2.Name then
					v2 = v3.isSpecial or false
					v1 = v3
					break
				end
			end
			if not v1 then
				if arg2.Type == "Melee" and true or arg2.Type == "Glove" then
					v1 = {
						["skin"] = {
							["weaponName"] = arg2.Name,
							["skinName"] = arg2.Skin,
							["type"] = arg2.Type
						},
						["isSpecial"] = true,
						["rarity"] = "Special",
						["skinId"] = "",
						["weight"] = 0
					}
					v2 = true
				else
					v1 = v_u_getcase.contents[1]
					v2 = v1.isSpecial or false
				end
			end
			local v4 = v_u28(v_u_getcase, v1, 55, v2)
			v_u30(v_container, v4, v_u_fromoffset, 8)
			v_u30(v_container, v4, v_u_fromoffset, 8)
			v_container.CanvasPosition = Vector2.new(0, 0)
			v_container.CanvasPosition = Vector2.new(0, 0)
			task.wait()
			v_u31(v_container, 16725)
			v_u31(v_container, 16725)
			local v_random = math.random(-97.72727272727272, 97.72727272727272)
			local v_max = math.max(v_container.AbsoluteSize.X, 1)
			local v_max = math.max(0, 16725 - v_max)
			local v_max = math.max(v_container.AbsoluteSize.X, 1)
			local v_max = math.max(0, 16725 - v_max)
			local v5 = v_u32(v_container, v_container, v_max <= 0 and 0 or math.clamp(12153.5 - v_max * 0.5 + v_random, 0, v_max), v_max <= 0 and 0 or math.clamp(12153.5 - v_max * 0.5 + v_random, 0, v_max), 223, function()
				-- upvalues: (ref) v_u9
				v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
			end)
			if v5 then
				v5.Completed:Wait()
				if not v_u23.isOpening then
					return
				end
				v_u9.broadcastRouter("RunInterfaceSound", "UI Notification")
				task.wait(0.5)
				if not v_u23.isOpening then
					return
				end
				v_u23.isOpening = false
				v_u23.currentInventoryItem = nil
				v_u23.currentTween = nil
				v_u23.currentZoomTween = nil
				local v_currentcaseidentifier = v_u23.currentCaseIdentifier
				if v_currentcaseidentifier then
					v_u8.Store.CaseOpenSequenceFinished.Send({
						["CaseIdentifier"] = v_currentcaseidentifier
					})
					v_u23.currentCaseIdentifier = nil
				end
				v_u22.Menu.OpenCase.Visible = false
				v_u3.HideCaseScene()
				v_u21.Tabs.Container.Visible = true
				v_u21.CaseContent.Visible = false
				v_u22.Menu.Top.Visible = true
				v_u21.Top.Visible = true
				v_u21.Visible = false
				v_u10.SetScreen("Inventory")
				v_u9.broadcastRouter("RunStoreSound", "Case Close")
				v_u9.broadcastRouter("WeaponInspect", arg2.Name, arg2.Skin, arg2.Float, arg2.StatTrack, arg2.NameTag, arg2.Charm, arg2.Stickers, arg2.Type, arg2.Pattern, arg2._id, arg2.Serial, arg2.IsTradeable)
			end
		end
		if v_u_getcase.caseType == "Charm Capsule" then
			v_u3.TransitionToUnboxing(v1)
		else
			v_u3.TransitionToUnboxing()
			task.wait(0.8)
			v1()
		end
	else
		return
	end
end
function v_u1.StopCaseOpening()
	-- upvalues: (copy) v_u23, (copy) v_u9, (copy) v_u3
	if v_u23.isOpening then
		v_u9.broadcastRouter("RunStoreSound", "Case Close")
	end
	if v_u23.currentTween then
		v_u23.currentTween:Cancel()
		v_u23.currentTween = nil
	end
	if v_u23.currentZoomTween then
		v_u23.currentZoomTween:Cancel()
		v_u23.currentZoomTween = nil
	end
	if v_u23.renderConnection then
		v_u23.renderConnection:Disconnect()
		v_u23.renderConnection = nil
	end
	v_u23.isOpening = false
	v_u23.isPendingOpenRequest = false
	v_u23.currentInventoryItem = nil
	v_u3.HideCaseScene()
	return v_u23.currentInventoryItem
end
function v_u1.CloseCaseContent(arg1)
	-- upvalues: (copy) v_u23, (copy) v_u3, (ref) v_u21, (ref) v_u22
	v_u23.isPendingOpenRequest = false
	v_u3.HideCaseScene()
	v_u21.Tabs.Container.Visible = true
	v_u21.CaseContent.Visible = false
	v_u22.Menu.Top.Visible = true
	v_u21.Top.Visible = true
	if arg1 == "Inventory" then
		v_u22.Menu.Inventory.Visible = true
		v_u21.Visible = false
	else
		v_u21.Visible = true
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u22, (ref) v_u21, (copy) v_u1, (copy) v_u23, (copy) v_u8, (copy) v_u10, (copy) v_u9, (copy) v_u4, (ref) v_u19, (ref) v_u18, (copy) v_u24, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u_marketplace, (copy) v_u14, (copy) v_u_run, (copy) v_u_new, (ref) v_u16, (copy) v_u25
	v_u22 = arg1
	v_u21 = arg2
	v_u22.Menu.OpenCase.Contents.Close.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u22, (ref) v_u23, (ref) v_u8, (ref) v_u21, (ref) v_u10, (ref) v_u9
		local v_stopcaseopening = v_u1.StopCaseOpening()
		v_u22.Menu.OpenCase.Visible = false
		local v_currentcaseidentifier = v_u23.currentCaseIdentifier
		if v_currentcaseidentifier then
			v_u8.Store.CaseOpenSequenceFinished.Send({
				["CaseIdentifier"] = v_currentcaseidentifier
			})
			v_u23.currentCaseIdentifier = nil
		end
		v_u21.Tabs.Container.Visible = true
		v_u21.CaseContent.Visible = false
		v_u22.Menu.Top.Visible = true
		v_u21.Top.Visible = true
		v_u21.Visible = false
		v_u10.SetScreen("Inventory")
		if v_stopcaseopening then
			v_u9.broadcastRouter("WeaponInspect", v_stopcaseopening.Name, v_stopcaseopening.Skin, v_stopcaseopening.Float, v_stopcaseopening.StatTrack, v_stopcaseopening.NameTag, v_stopcaseopening.Charm, v_stopcaseopening.Stickers, v_stopcaseopening.Type, v_stopcaseopening.Pattern, v_stopcaseopening._id, v_stopcaseopening.Serial, v_stopcaseopening.IsTradeable)
		else
			v_u22.Menu.Inventory.Visible = true
		end
	end)
	v_u4(v_u21.CaseContent.List.Open)
	v_u21.CaseContent.List.Open.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u19, (ref) v_u23, (ref) v_u8, (ref) v_u18
		if v_u19 and not v_u23.isPendingOpenRequest then
			v_u23.isPendingOpenRequest = true
			v_u8.Store.OpenCase.Send({
				["CaseIdentifier"] = v_u18,
				["CaseId"] = v_u19.caseId
			})
		end
	end)
	v_u4(v_u21.CaseContent.List.Buy)
	v_u21.CaseContent.List.Buy.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u19, (ref) v_u1, (ref) v_u21
		if v_u19 then
			v_u1.PurchaseCase(v_u19, (tonumber(v_u21.CaseContent.List.Amount.Header.TextLabel.Text)))
		end
	end)
	v_u4(v_u21.CaseContent.List.Close)
	v_u21.CaseContent.List.Close.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u23, (ref) v_u1, (ref) v_u21
		if not v_u23.isPendingOpenRequest then
			v_u1.CloseCaseContent(v_u21.CaseContent:GetAttribute("State") == "Inspect" and "Store" or "Inventory")
		end
	end)
	v_u24(v_u21.Gift.Container, { "UICorner", "UIListLayout" })
	v_u21.Gift.Close.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u21
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u21.Gift.Visible = false
	end)
	v_u4(v_u21.Top.Credits.Buy)
	v_u21.Top.Credits.Buy.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.OpenTab("Credits")
	end)
	v_u4(v_u21.Tabs.Container.Featured.Bundle.Gift)
	v_u21.Tabs.Container.Featured.Bundle.Gift.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.OpenGift("Gift Featured Bundle", "DevProduct")
	end)
	v_u4(v_u21.Tabs.Container.Featured.Bundle.Purchase)
	v_u21.Tabs.Container.Featured.Bundle.Purchase.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u2, (ref) v_u_localplayer, (ref) v_u5, (ref) v_u_marketplace, (ref) v_u14
		local v_get = v_u2.Get(v_u_localplayer, "Gamepasses")
		local v_getactivebundle = v_u5.GetActiveBundle()
		if v_get and (v_getactivebundle and not table.find(v_get, v_getactivebundle.bundleId)) then
			v_u_marketplace:PromptGamePassPurchase(v_u_localplayer, v_u14["Purchase Featured Bundle"].GamepassId)
		end
	end)
	v_u21.Gift.Search.TextBox.Focused:Connect(function()
		-- upvalues: (ref) v_u21
		local v_searchresult = v_u21.Gift.Container:FindFirstChild("SearchResult")
		if v_searchresult then
			v_searchresult:Destroy()
		end
		for _, v1 in ipairs(v_u21.Gift.Container:GetChildren()) do
			if v1:IsA("Frame") then
				v1.Visible = true
			end
		end
	end)
	v_u21.Gift.Search.TextBox.FocusLost:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u21
		v_u1.SearchPlayerGift(v_u21.Gift.Search.TextBox.Text)
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_new, (ref) v_u21, (ref) v_u16, (ref) v_u5, (ref) v_u25
		local v_getposition = v_u_new:getPosition()
		local v_round = math.round(v_getposition)
		v_u21.Top.Credits.TextLabel.Text = ("%*"):format((tostring(v_round):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
		v_u_new:update(arg1)
		v_u21.Top.Categories.Credits.TextLabel.UIGradient.Offset = Vector2.new(v_u16 + 0.85 * arg1, 0)
		if UNNAMED_1729008323304 > 1 then
			v_u16 = -1
		end
		local v_getactivebundle = v_u5.GetActiveBundle()
		if v_getactivebundle then
			v_u21.Tabs.Container.Featured.Bundle.Timer.Text = v_u25(v_getactivebundle.discontinueDate)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u1, (copy) v_u_policy, (copy) v_u_localplayer, (ref) v_u17, (ref) v_u21, (copy) v_u26, (ref) v_u19, (copy) v_u2, (copy) v_u5, (copy) v_u_new, (copy) v_u7, (copy) v_u8, (copy) v_u23, (copy) v_u11, (copy) v_u_replicatedstorage
	v_u1.OpenTab("Featured")
	local v1, v2 = pcall(function()
		-- upvalues: (ref) v_u_policy, (ref) v_u_localplayer
		return v_u_policy:GetPolicyInfoForPlayerAsync(v_u_localplayer)
	end)
	if v1 and (v2 and v2.ArePaidRandomItemsRestricted) then
		v_u21.Top.Categories.Credits.Visible = false
	end
	for _, v_u3 in ipairs(v_u21.Top.Categories:GetChildren()) do
		if v_u3:IsA("TextButton") then
			v_u26(v_u3)
			v_u3.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u3
				v_u1.OpenTab(v_u3.Name)
			end)
		end
	end
	for _, v4 in ipairs(v_u21.Tabs.Container.Credits.Container:GetChildren()) do
		if v4:IsA("Frame") then
			v_u1.SetupCreditsFrame(v4)
		end
	end
	v_u21.CaseContent.List.Amount.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u21
		local v_u_container = v_u21.CaseContent.List.Amount.Container
		v_u_container.Visible = not v_u_container.Visible
		if v_u_container.Visible then
			task.defer(function()
				-- upvalues: (copy) v_u_container
				local v_max = math.max(0, v_u_container.AbsoluteCanvasSize.Y - v_u_container.AbsoluteWindowSize.Y)
				v_u_container.CanvasPosition = Vector2.new(v_u_container.CanvasPosition.X, v_max)
			end)
		end
	end)
	for _, v_u5 in ipairs(v_u21.CaseContent.List.Amount.Container:GetChildren()) do
		if v_u5:IsA("TextButton") then
			v_u5.MouseEnter:Connect(function()
				-- upvalues: (copy) v_u5
				if not v_u5:GetAttribute("Selected") then
					v_u5.Frame.BackgroundTransparency = 0.5
				end
			end)
			v_u5.MouseLeave:Connect(function()
				-- upvalues: (copy) v_u5
				if not v_u5:GetAttribute("Selected") then
					v_u5.Frame.BackgroundTransparency = 1
				end
			end)
			v_u5.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u19, (copy) v_u5, (ref) v_u21
				v_u21.CaseContent.List.Buy.Header.TextLabel.Text = ("BUY (%*)"):format((tostring(v_u19.price * tonumber(v_u5.Name)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
				v_u21.CaseContent.List.Amount.Header.TextLabel.Text = tostring(v_u5.Name)
				v_u21.CaseContent.List.Amount.Container.Visible = false
				for _, v1 in ipairs(v_u21.CaseContent.List.Amount.Container:GetChildren()) do
					if v1:IsA("TextButton") then
						v1.Frame.BackgroundTransparency = v1 == v_u5 and 0 or 1
						v1:SetAttribute("Selected", v1 == v_u5)
					end
				end
			end)
		end
	end
	v_u2.CreateListener(v_u_localplayer, "Gamepasses", function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u21
		local v_getactivebundle = v_u5.GetActiveBundle()
		if v_getactivebundle and table.find(arg1, v_getactivebundle.bundleId) then
			v_u21.Tabs.Container.Featured.Bundle.Purchase.Credits.Amount.Text = "OWNED"
		end
	end)
	v_u2.CreateListener(v_u_localplayer, "Credits", function(arg1)
		-- upvalues: (ref) v_u_new
		v_u_new:setGoal(arg1)
	end)
	v_u7.ObserveAvailableCases(function(_)
		-- upvalues: (ref) v_u1
		v_u1.UpdateCases()
	end)
	v_u5.ObserveActiveBundle(function(arg1)
		-- upvalues: (ref) v_u21
		v_u21.Tabs.Container.Featured.Bundle.BundleName.Text = arg1.name
	end)
	v_u8.Store.CaseOpened.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.OpenCase(arg1.CaseId, arg1.InventoryItem, arg1.CaseIdentifier)
	end)
	v_u8.Store.CaseOpenDenied.Listen(function()
		-- upvalues: (ref) v_u23
		v_u23.isPendingOpenRequest = false
	end)
	v_u11.observePlayer(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_replicatedstorage, (ref) v_u21, (ref) v_u1
		if v_u_localplayer == arg1 then
			return function() end
		end
		local v_u_clone = v_u_replicatedstorage.Assets.UI.Store.PlayerTemplate:Clone()
		v_u_clone.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(arg1.UserId)
		v_u_clone.Player.Username.Text = ("@%*"):format(arg1.Name)
		v_u_clone.Parent = v_u21.Gift.Container
		v_u_clone.Name = tostring(arg1.UserId)
		v_u1.ActivateGiftTemplate(v_u_clone, arg1.UserId)
		return function()
			-- upvalues: (copy) v_u_clone
			if v_u_clone then
				v_u_clone:Destroy()
			end
		end
	end)
end
return v_u1