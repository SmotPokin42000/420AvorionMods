function EquipmentDock.shop:addItems()

    UpgradeGenerator.initialize()

    local counter = 0
    local systems = {}
    while counter < 15 do

        local x, y = Sector():getCoordinates()
        local rarities, weights = UpgradeGenerator.getSectorProbabilities(x, y)
        local dice = math.random() -- math.random()'s initial Lookup
        local system = UpgradeGenerator.generateSystem(nil, weights)
        --local pair = {}
        --pair.system = system
        --pair.amount = 1

        weights[1] = weights[1] * 0.5 -- 2 + pos * 14 Petty     Custom weights -> see upgradegenerator.lua for base values
        weights[2] = weights[2] * 0.5 -- 8 + pos * 40 Common
        weights[3] = weights[3] * 1 -- 8 + pos * 8 Uncommon
        weights[4] = weights[4] * 1 -- 8 Rare
        weights[5] = weights[5] * 0.8 -- 4 Exceptional
        weights[6] = weights[6] * 0.4 -- 1 Exotic
        weights[7] = weights[7] * 1.5 -- 0.2 Legendary

        --local system = UpgradeGenerator.generateSystem(nil, weights)

        if system.rarity.value >= 0 or dice < 0.25 then
            --spair.amount = getInt(1, 9)
            --table.insert(systems, pair)
            counter = counter + 1
        
        --elseif system.rarity.value == 3 then
            --pair.amount = getInt(1, 6)
            --table.insert(systems, pair)
            --counter = counter + 1
        
        --elseif system.rarity.value == 4 then
            --pair.amount = getInt(1, 3)
            --table.insert(systems, pair)
            --counter = counter + 1

        --else --pair.amount = 1
            --table.insert(systems, pair)
            --counter = counter + 1

        end
        table.insert(systems, system)

    end

    --table.sort(systems, system.rarity.value)
    table.sort(systems, sortSystems)
    
    for _, system in pairs(systems) do
        if system.rarity.value < 3 then
            EquipmentDock.shop:add(system, getInt(1, 9)) -- Up to 9 units per sys mod spawned @ rare and below

        elseif system.rarity.value == 3 then
            EquipmentDock.shop:add(system, getInt(1, 6)) -- Up to 6 units per Exceptional sys mod spawned

        elseif system.rarity.value == 4 then
            EquipmentDock.shop:add(system, getInt(1, 3)) -- Up to 3 units per Exotic sys mod spawned

        else EquipmentDock.shop:add(system, 1) -- Just one unit per Legendary system mod spawned, VED isn't 'that' kind of mod :P
        
        end
    end

end