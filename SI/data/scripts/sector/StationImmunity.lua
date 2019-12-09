-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace StationImmunity
StationImmunity = {}

function StationImmunity.initialize() -- Called everytime a station with this script attached is loaded.
    if onServer() then
        local entity = Entity()

        entity.invincible = true -- Should set the entity in question to 'invicible' status in all cases. It will persist even after the script is removed.

    end
end