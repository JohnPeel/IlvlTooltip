local UPGRADE_CLASS_START = string.find(ITEM_UPGRADE_TOOLTIP_FORMAT_STRING, "%%s")
local UPGRADE_LEVEL = strsub(ITEM_UPGRADE_TOOLTIP_FORMAT_STRING, 1, UPGRADE_CLASS_START - 1)

local function OnTooltipSetItem(tooltip, tooltipData)
    local _, itemLink = TooltipUtil.GetDisplayedItem(tooltip)
    if not itemLink or not tooltipData then
        return
    end

    local itemClass = select(12, GetItemInfo(itemLink))
    if itemClass ~= Enum.ItemClass.Armor and itemClass ~= Enum.ItemClass.Weapon then
        return
    end

    local itemString = { strsplit(":", string.match(itemLink, "item[%-?%d:]+")) }
    local numberOfBonusIds = tonumber(itemString[14]) or 0
    if numberOfBonusIds == 0 then
        return
    end

    local range = false
    for i=15,15+numberOfBonusIds do
        local bonusId = tonumber(itemString[i])
        if bonusId then
            if bonusId >= 9294 and bonusId <= 9301 then
                range = "(376-398)"
                break
            elseif bonusId >= 9302 and bonusId <= 9309 then
                range = "(389-411)"
                break
            elseif bonusId >= 9313 and bonusId <= 9320 then
                range = "(402-424)"
                break
            elseif bonusId >= 9321 and bonusId <= 9329 then
                range = "(415-437)"
                break
            elseif bonusId >= 9330 and bonusId <= 9334 then
                range = "(428-441)"
                break
            end
        end
    end

    if range then
        local itemLevelLine = 2
        for tooltipLine=3,4 do
            if string.match(tooltipData.lines[tooltipLine].leftText, "^" .. UPGRADE_LEVEL) then
                itemLevelLine = tooltipLine - 1
                break
            end
        end

        tooltipData.lines[itemLevelLine].rightColor = DISABLED_FONT_COLOR
        tooltipData.lines[itemLevelLine].rightText = range
    end
end

TooltipDataProcessor.AddTooltipPreCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
