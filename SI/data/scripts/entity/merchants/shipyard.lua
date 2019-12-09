-- secure the old initialize function so we can override it and still call it
local oldInitialize = Shipyard.initialize or function() end
function Shipyard.initialize(...)
    -- make sure to call the old function, too!
    oldInitialize(...)

    -- add the script to the station
    -- since initialize() is also called on load, this also makes sure that the StationImmunity.lua script is always added to the given station type
    Entity():addScriptOnce("data/scripts/sector/StationImmunity.lua")

end