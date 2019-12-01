function UtilityMerchant.shop:addItems()
    local item = UsableInventoryItem("reinforcementstransmitter.lua", Rarity(RarityType.Exotic), Faction().index)
    UtilityMerchant.add(item, getInt(1, 3))
    local item = UsableInventoryItem("equipmentmerchantcaller.lua", Rarity(RarityType.Exceptional), Faction().index)
    UtilityMerchant.add(item, getInt(1, 9))
    local item = UsableInventoryItem("energysuppressor.lua", Rarity(RarityType.Exceptional))
    UtilityMerchant.add(item, getInt(1, 20))
end
