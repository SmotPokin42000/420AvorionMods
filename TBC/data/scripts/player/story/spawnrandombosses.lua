function SpawnRandomBosses.onSwoksDestroyed()

    local beaten = Server():getValue("swoks_beaten") or 2
    beaten = beaten + 1

    Server():setValue("swoks_beaten", beaten)

    print ("Swoks was beaten for the %s. time!", beaten)

    noSpawnTimer = 3.5 * 60 --Swoks Cooldown
end

function SpawnRandomBosses.updateServer(timeStep)
    -- decrease common no-spawn-timer
    noSpawnTimer = noSpawnTimer - timeStep

    -- check if the AI upgrade was dropped
    local dropped, present = AI.checkForDrop()
    aiPresent = present

    if dropped then
        noSpawnTimer = 3.5 * 60 --AI Cooldown

        print ("The AI was beaten!")
    end

    -- update spawn interdictions of sectors where no bosses may be spawned
    for i, interdiction in pairs(self.spawnInterdictions) do
        interdiction.time = interdiction.time - timeStep

        if interdiction.time <= 0.0 then
            self.spawnInterdictions[i] = nil
        end
    end
end