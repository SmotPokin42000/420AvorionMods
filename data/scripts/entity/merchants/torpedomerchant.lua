function TorpedoMerchant.shop:addItems()

    local station = Entity()

    if station.title == "" then
        station.title = "Torpedo Merchant"%_t
    end

    -- create all torpedoes
    local allTorpedoes = {}

    for i = 1, 15 do

        local torpedo = TorpedoGenerator.generate(Sector():getCoordinates())
        --local rarities = TorpedoGenerator.generate(x, y, offset_in, rarity_in, warhead_in, body_in)

        --rarities[5] = rarities[5] * 100 -- 0.1 -- legendary
        --rarities[4] = rarities[4] * 1 -- 1 -- exotic
        --rarities[3] = rarities[3] * 1 -- 8 -- exceptional
        --rarities[2] = rarities[2] * 1 -- 16 -- rare
        --rarities[1] = rarities[1] * 1 -- 32 -- uncommon
        --rarities[0] = rarities[0] * 1 -- 128 -- common

        for _, p in pairs(allTorpedoes) do
            if torpedo.name == p.torpedo.name and torpedo.rarity == p.torpedo.rarity then
                goto continue
            end
        end

        local dice = math.random() -- local dice
        local pair = {}
        pair.torpedo = torpedo
        pair.amount = 1

        if torpedo.rarity.value == RarityType.Legendary then
            if dice > 0.5 then
                pair.amount = getInt(1, 75)
            elseif dice > 0.2 then
                pair.amount = getInt(75, 150)
            else pair.amount = getInt(150, 300)
            end
            
        elseif torpedo.rarity.value == RarityType.Exotic then
            if dice > 0.5 then
                pair.amount = getInt(1, 87)
            elseif dice > 0.2 then
                pair.amount = getInt(87, 175)
            else pair.amount = getInt(175, 350)
            end

        elseif torpedo.rarity.value == RarityType.Exceptional then
            if dice > 0.5 then
                pair.amount = getInt(1, 100)
            elseif dice > 0.2 then
                pair.amount = getInt(100, 200)
            else pair.amount = getInt(200, 400)
            end
            
        elseif torpedo.rarity.value == RarityType.Rare then
            if dice > 0.5 then
                pair.amount = getInt(1, 112)
            elseif dice > 0.2 then
                pair.amount = getInt(112, 225)
            else pair.amount = getInt(225, 450)
            end
            
        elseif torpedo.rarity.value == RarityType.Uncommon then
            if dice > 0.5 then
                pair.amount = getInt(1, 125)
            elseif dice > 0.2 then
                pair.amount = getInt(125, 250)
            else pair.amount = getInt(250, 500)
            end
            
        elseif torpedo.rarity.value == RarityType.Common then
            if dice > 0.5 then
                pair.amount = getInt(1, 137)
            elseif dice > 0.2 then
                pair.amount = getInt(137, 275)
            else pair.amount = getInt(275, 550)
            end
            
        end

        table.insert(allTorpedoes, pair)

        ::continue::
    end

    table.sort(allTorpedoes, comp)

    for _, pair in pairs(allTorpedoes) do
        TorpedoMerchant.shop:add(pair.torpedo, pair.amount)
    end

end