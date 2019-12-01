function FighterMerchant.shop:addItems()

    local station = Entity()

    if station.title == "" then
        station.title = "Fighter Merchant"%_t
    end

    -- create all fighters
    local allFighters = {}

    for i = 1, 9 do
        local fighter = FighterGenerator.generate(Sector():getCoordinates())

        local pair = {}
        pair.fighter = fighter
        pair.amount = 1

        if fighter.rarity.value == RarityType.Exceptional then
            pair.amount = getInt(1, 120)
        elseif fighter.rarity.value == RarityType.Rare then
            pair.amount = getInt(1, 120)
        elseif fighter.rarity.value == RarityType.Uncommon then
            pair.amount = getInt(1, 120)
        elseif fighter.rarity.value == RarityType.Common then
            pair.amount = getInt(1, 120)
        end

        table.insert(allFighters, pair)
    end

    for i = 1, 3 do
        local fighter = FighterGenerator.generateCargoShuttle(Sector():getCoordinates())

        local pair = {}
        pair.fighter = fighter
        pair.amount = getInt(1, 120)

        table.insert(allFighters, pair)
    end

    for i = 1, 3 do
        local fighter = FighterGenerator.generateCrewShuttle(Sector():getCoordinates())

        local pair = {}
        pair.fighter = fighter
        pair.amount = getInt(1, 120)

        table.insert(allFighters, pair)
    end

    table.sort(allFighters, comp)

    for _, pair in pairs(allFighters) do
        FighterMerchant.shop:add(pair.fighter, pair.amount)
    end

end