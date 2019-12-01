function TurretMerchant.shop:addItems()

    -- simply init with a 'random' seed
    local station = Entity()

    -- create all turrets
    local turrets = {}

    for i = 1, 15 do -- # of different turrets listed
        local turret = InventoryTurret(TurretGenerator.generate(Sector():getCoordinates()))

        local dice = math.random() -- math.random()'s initial Lookup
        local pair = {}
        pair.turret = turret
        pair.amount = 1 -- base amount

        if turret.rarity.value == 1 then -- uncommon weapons may be 1-120
            --pair.amount = pair.amount + 2 -- rarity adjustment
            if dice > 0.5 then
                pair.amount = getInt(1, 10) -- (1) amount teirs; Higher teirs are less common
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30) -- (2)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60) -- (3)
            else pair.amount = getInt(60, 120) -- (4)
            end

        elseif turret.rarity.value == 0 then -- common weapons may be 1-120
            --pair.amount = pair.amount + 3
            if dice > 0.5 then
                pair.amount = getInt(1, 10)
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60)
            else pair.amount = getInt(60, 120)
            end

        elseif turret.rarity.value == 2 then -- rare weapons may be 1-120
            --pair.amount = pair.amount + 1
            if dice > 0.5 then
                pair.amount = getInt(1, 10)
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60)
            else pair.amount = getInt(60, 120)
            end

        elseif turret.rarity.value == 3 then -- exceptional weapons may be 1-120
            --pair.amount = pair.amount + 0
            if dice > 0.5 then
                pair.amount = getInt(1, 10)
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60)
            else pair.amount = getInt(60, 120)
            end

        elseif turret.rarity.value == 4 then -- exotic weapons may be 1-120
            --pair.amount = pair.amount - 1
            if dice > 0.5 then
                pair.amount = getInt(1, 10)
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60)
            else pair.amount = getInt(60, 120)
            end

        elseif turret.rarity.value >= 5 then -- legendary weapons+ may be 1-240
            --pair.amount = pair.amount - 2
            if dice > 0.5 then
                pair.amount = getInt(1, 10)
            elseif dice > 0.3 then
                pair.amount = getInt(10, 30)
            elseif dice > 0.1 then
                pair.amount = getInt(30, 60)
            elseif dice > 0.05 then
                pair.amount = getInt(60, 120)
            else pair.amount = getInt(120, 240) -- JackPot :)
            end
 
        end        

        table.insert(turrets, pair)
    end

    table.sort(turrets, comp)

    for _, pair in pairs(turrets) do
        TurretMerchant.shop:add(pair.turret, pair.amount)
    end

end