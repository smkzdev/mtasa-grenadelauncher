function getPositionInfrontOfLP()
    local posX,posY,posZ = getElementPosition(localPlayer)
    local _,_,rotation = getElementRotation(localPlayer)
    rotation = rotation-15
    posX =(posX - math.sin(math.rad(rotation)))
    posY =(posY + math.cos(math.rad(rotation)))
    return posX,posY,posZ
end

function isWeaponAllowed()
    local ALLOWED_WEAPONS = {22, 23, 24, 25, 27, 30, 31, 33}
    local status = false
    for i, weapon in pairs(ALLOWED_WEAPONS) do
        if WEAPON_ID == weapon then status = true end
    end
    return status
end