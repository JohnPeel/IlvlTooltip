local ranges = {
    explorer = "(376-398)",
    adventurer = "(389-411)",
    veteran = "(402-424)",
    champion = "(415-437)",
    hero = "(428-441)",
}

local function OnTooltipSetItem(tooltip, tooltipData)
    local itemName, itemLink = TooltipUtil.GetDisplayedItem(tooltip)
    if not itemLink or not tooltipData then
        return
    end

    local itemType = select(6, GetItemInfo(itemLink))
    if itemType ~= "Armor" and itemType ~= "Weapon" then
        return
    end

    local upgradeText = tooltipData.lines[3].leftText
    local upgradeTextLength = strlen(upgradeText)
    if upgradeTextLength >= 24 then
        local upgradeClass = strlower(strsub(upgradeText, 16, upgradeTextLength - 4));
        local range = ranges[upgradeClass];
        if range then
            tooltipData.lines[2].rightColor = DISABLED_FONT_COLOR
            tooltipData.lines[2].rightText = range
        end
    end
end

TooltipDataProcessor.AddTooltipPreCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
