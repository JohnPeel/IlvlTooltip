local RANGES = {
    explorer = "(376-398)",
    adventurer = "(389-411)",
    veteran = "(402-424)",
    champion = "(415-437)",
    hero = "(428-441)",
}

local UPGRADE_CLASS_START = string.find(ITEM_UPGRADE_TOOLTIP_FORMAT_STRING, "%%s")
local UPGRADE_LEVEL = strsub(ITEM_UPGRADE_TOOLTIP_FORMAT_STRING, 1, UPGRADE_CLASS_START - 1)

local function OnTooltipSetItem(tooltip, tooltipData)
    local itemName, itemLink = TooltipUtil.GetDisplayedItem(tooltip)
    if not itemLink or not tooltipData then
        return
    end

    local itemType = select(6, GetItemInfo(itemLink))
    if itemType ~= ARMOR and itemType ~= WEAPON then
        return
    end

    local upgradeLine = 3
    local upgradeText = tooltipData.lines[upgradeLine].leftText
    local upgradeTextLength = strlen(upgradeText)

    while(upgradeTextLength < UPGRADE_CLASS_START + 4 or strsub(upgradeText, 1, UPGRADE_CLASS_START - 1) ~= UPGRADE_LEVEL) do
        if upgradeLine > 5 then
            return
        end

        upgradeLine = upgradeLine + 1
        upgradeText = tooltipData.lines[upgradeLine].leftText
        upgradeTextLength = strlen(upgradeText)
    end

    local upgradeClass = strlower(strsub(upgradeText, UPGRADE_CLASS_START, upgradeTextLength - 4));
    local range = RANGES[upgradeClass];
    if range then
        tooltipData.lines[upgradeLine - 1].rightColor = DISABLED_FONT_COLOR
        tooltipData.lines[upgradeLine - 1].rightText = range
    end
end

TooltipDataProcessor.AddTooltipPreCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
