function TorpedoGenerator.generate(x, y, offset_in, rarity_in, warhead_in, body_in) -- server

    local offset = offset_in or 0
    local seed = rand:createSeed()
    local sector = math.floor(length(vec2(x, y))) + offset

    local dps, tech = Balancing_GetSectorWeaponDPS(sector, 0)
    dps = dps * Balancing_GetSectorTurretsUnrounded(sector, 0) -- remove turret bias

    local rarities = {}
    rarities[5] = 0.1 * 5 -- legendary
    rarities[4] = 1 * 1.5 -- exotic
    rarities[3] = 8 * 1 -- exceptional
    rarities[2] = 16 * 1 -- rare
    rarities[1] = 32 * 1 -- uncommon
    rarities[0] = 128 * 0.5 -- common

    local rarity = rarity_in or Rarity(getValueFromDistribution(rarities))

    local bodyProbabilities = TorpedoGenerator.getBodyProbability(sector, 0)
    local body = Bodies[selectByWeight(rand, bodyProbabilities)]
    if body_in then body = Bodies[body_in] end

    local warheadProbabilities = TorpedoGenerator.getWarheadProbability(sector, 0)

    local torpedo = TorpedoTemplate()
    torpedo.type = warhead_in or selectByWeight(rand, warheadProbabilities)
    local warhead = Warheads[torpedo.type]

    -- normal properties
    torpedo.rarity = rarity
    torpedo.tech = tech
    torpedo.size = round(body.size * warhead.size, 2)

    -- body properties
    torpedo.durability = (2 + tech / 10) * (rarity.value + 1) + 4;
    torpedo.turningSpeed = 0.3 + 0.1 * ((body.agility * 2) - 1)
    torpedo.maxVelocity = 250 + 100 * body.velocity
    torpedo.reach = (body.reach * 4 + 3 * rarity.value) * 150

    -- warhead properties
    local damage = dps * (1 + rarity.value * 0.25) * 10

    torpedo.shieldDamage = round(damage * warhead.shield / 100) * 100
    torpedo.hullDamage = round(damage * warhead.hull / 100) * 100
    torpedo.shieldPenetration = warhead.penetrateShields or false
    torpedo.shieldDeactivation = warhead.deactivateShields or false
    torpedo.shieldAndHullDamage = warhead.shieldAndHullDamage or false
    torpedo.energyDrain = warhead.energyDrain or false
    torpedo.storageEnergyDrain = (warhead.storageEnergyDrain or 0.0) * tech
    torpedo.acceleration = 0.5 * torpedo.maxVelocity * torpedo.maxVelocity / 1000 -- reach max velocity after 10km of travelled way

    if warhead.damageVelocityFactor then
        -- scale to normal dps damage dependent on maxVelocity
        torpedo.damageVelocityFactor = damage * warhead.hull / torpedo.maxVelocity
        torpedo.maxVelocity = torpedo.maxVelocity * 2.0
        torpedo.hullDamage = 0
    end

    -- torpedo visuals
    torpedo.visualSeed = rand:getInt()
    torpedo.stripes = body.stripes
    torpedo.stripeColor = body.color
    torpedo.headColor = warhead.color
    torpedo.prefix = warhead.name
    torpedo.name = "${speed}-Class ${warhead} Torpedo"%_T
    torpedo.icon = "data/textures/icons/missile-pod.png"
    torpedo.warheadClass = warhead.name
    torpedo.bodyClass = body.name

    -- impact visuals
    torpedo.numShockwaves = 1
    torpedo.shockwaveSize = 60
    torpedo.shockwaveDuration = 0.6
    torpedo.shockwaveColor = ColorRGB(0.9, 0.6, 0.3)
    -- torpedo.shockwaveColor = ColorRGB(0.1, 0.3, 1.2) -- this looks cool :)
    torpedo.explosionSize = 6
    torpedo.flashSize = 25
    torpedo.flashDuration = 1

    return torpedo
end