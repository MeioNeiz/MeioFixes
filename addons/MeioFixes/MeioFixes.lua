-- Profession recipe list: each row registers for RefreshCraftableCount in OnShow and again
-- in OnHide (meant to unregister), so rows released back to the ScrollBox pool keep the
-- callback after losing their GetElementData accessor, and the next refresh
-- (PLAYER_TALENT_UPDATE) errors in SetCraftableCount. Drop the callback for released rows.
-- The release hides the row (OnHide re-registers) after OnReleasedFrame fires, and then
-- strips the accessors, so check on the next frame.
local REFRESH_EVENT = "ProfessionsRecipeListMixin.Event.RefreshCraftableCount"
local owner = {}
local watched = setmetatable({}, { __mode = "k" })

local function onReleased(_, row)
	C_Timer.After(0, function()
		if not row.GetElementData then
			EventRegistry:UnregisterCallback(REFRESH_EVENT, row)
		end
	end)
end

local function watch(list)
	local view = list and list.ScrollBox and list.ScrollBox:GetView()
	if not view or watched[view] then return end
	watched[view] = true
	view:RegisterCallback(ScrollBoxListViewMixin.Event.OnReleasedFrame, onReleased, owner)
end

local function watchProfessions()
	local frame = ProfessionsFrame
	if not frame then return end
	watch(frame.CraftingPage and frame.CraftingPage.RecipeList)
	local browse = frame.OrdersPage and frame.OrdersPage.BrowseFrame
	watch(browse and browse.RecipeList)
end

-- AH Browse: SelectBrowseResult indexes C_AuctionHouse.GetItemKeyInfo (nilable) unchecked,
-- so clicking a result whose item info hasn't arrived errors. Rows click on mouse up: a
-- row without info is disabled on mouse down, which drops that one click instead of
-- erroring, and re-enabled after the mouse up (or by Blizzard's initializer on reuse).
-- Only Enable/Disable and our own hooked scripts: Blizzard's click path stays untainted.
-- Every result's info is asked for as results arrive, so this rarely triggers.
local guarded = setmetatable({}, { __mode = "k" })

local function infoMissing(row)
	local key = row.rowData and row.rowData.itemKey
	return key and not C_AuctionHouse.GetItemKeyInfo(key)
end

local function onRowDown(row, button)
	if button ~= "LeftButton" or IsModifiedClick("DRESSUP") then return end
	if not infoMissing(row) then return end
	guarded[row] = true
	row:Disable()
end

local function onRowUp(row)
	if not guarded[row] then return end
	C_Timer.After(0, function()
		if guarded[row] then
			guarded[row] = nil
			row:Enable()
		end
	end)
end

local hooked = setmetatable({}, { __mode = "k" })

local function onRowAcquired(_, row)
	-- released between mouse down and up: don't hand the row back disabled
	if guarded[row] then row:Enable() end
	guarded[row] = nil
	if hooked[row] then return end
	hooked[row] = true
	row:HookScript("OnMouseDown", onRowDown)
	row:HookScript("OnMouseUp", onRowUp)
end

local function warmItemKeys()
	for _, r in ipairs(C_AuctionHouse.GetBrowseResults() or {}) do
		if r.itemKey then C_AuctionHouse.GetItemKeyInfo(r.itemKey) end
	end
end

-- Commodity Sell frame: GetDepositAmount returns C_AuctionHouse.CalculateCommodityDeposit,
-- which is nilable (Forever gives nil for trade goods at times), and CanPostItem compares
-- GetMoney() with it: an error on Post or on any post-state update. Fall back to the item
-- deposit, else 0, so Post goes ahead and the server decides; Blizzard's value whenever it
-- has one. Replacing this one method taints the Post click; PostCommodity only needs the
-- hardware event, which the click still carries (TSM posts from addon code the same way).
local function fixCommodityDeposit(cf)
	if not cf or not cf.GetDepositAmount then return end
	local blizzard = cf.GetDepositAmount
	cf.GetDepositAmount = function(self)
		local deposit = blizzard(self)
		if deposit then return deposit end
		local ok, asItem = pcall(C_AuctionHouse.CalculateItemDeposit, self:GetItem(),
			self:GetDuration(), self:GetQuantity())
		return ok and asItem or 0
	end
end

local ahWatched
local function watchAuctionHouse()
	local ah = AuctionHouseFrame
	if not ah or ahWatched then return end
	ahWatched = true
	local list = ah.BrowseResultsFrame and ah.BrowseResultsFrame.ItemList
	if list and list.ScrollBox then
		list.ScrollBox:RegisterCallback(ScrollBoxListMixin.Event.OnAcquiredFrame,
			onRowAcquired, owner)
	end
	fixCommodityDeposit(ah.CommoditiesSellFrame)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
f:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_ADDED")
f:SetScript("OnEvent", function(_, event, name)
	if event ~= "ADDON_LOADED" then
		warmItemKeys()
	elseif name == "Blizzard_Professions" then
		watchProfessions()
	elseif name == "Blizzard_AuctionHouseUI" then
		watchAuctionHouse()
	end
end)
if C_AddOns.IsAddOnLoaded("Blizzard_Professions") then watchProfessions() end
if C_AddOns.IsAddOnLoaded("Blizzard_AuctionHouseUI") then watchAuctionHouse() end
