local canRun = false

addEventHandler("onClientResourceStart", resourceRoot, function() 
    if isWeaponAllowed() == true then canRun = true else outputChatBox("Prohibited Weapon ID") return false end
    if not WEAPON_MODEL_ID or WEAPON_MODEL_ID == nil or WEAPON_MODEL_ID == 0 then return false end
    local skin = engineLoadTXD("files/models/weapon.txd", true) 
    engineImportTXD(skin, WEAPON_MODEL_ID) 
    local skin = engineLoadDFF("files/models/weapon.dff", WEAPON_MODEL_ID) 
    engineReplaceModel(skin, WEAPON_MODEL_ID) 
end)

addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function(previousSlot, actualSlot)
    if canRun ~= true then return false end
    if getPedWeapon(localPlayer) == WEAPON_ID then setWorldSoundEnabled ( 5, false ) else setWorldSoundEnabled ( 5, true ) end
end)

addEventHandler("onClientPlayerDamage", localPlayer, function(attacker, weapon, bodypart)
    if canRun ~= true then return false end
    if (weapon == WEAPON_ID) then cancelEvent() end
end)

addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if canRun ~= true then return false end
    local actualWeapon = getPedWeapon(source)
    if actualWeapon ~= WEAPON_ID then return false end
       
    xm,ym,zm = getPedWeaponMuzzlePosition(source)
    infx,infy,infz = getPositionInfrontOfLP()
    x,y,z,lx,ly,lz,roll,dof = getCameraMatrix()
    velx,vely =(infx-x)*STRENGHT,(infy-y)*STRENGHT
    local projectile = createProjectile(source,16,xm,ym,zm-0.05,0,nil,0,0,180,velx,vely,lz-z+0.1)
    local timerProjectile
    setSoundMaxDistance(playSound3D("files/sounds/shot.mp3",xm,ym,zm),100)

    timerProjectile = setTimer(function(proj)
        if isElement(projectile) then
            local px, py, pz = getElementPosition(projectile)
            local ground = getGroundPosition(px, py, pz + 5) 
            local minHeight = 1

            if pz - ground < minHeight then
                destroyElement(projectile)
                if isTimer(timerProjectile) then
                    killTimer(timerProjectile)
                end
            else 
                local distanceVerification = 5
                local hit, hitX, hitY, hitZ = processLineOfSight(px, py, pz, px + velx * distanceVerification, py + vely * distanceVerification, pz, true, true, true, true, true, false, false, false, nil, false)

                if hit then
                    destroyElement(projectile)       
                    if isTimer(timerProjectile) then
                        killTimer(timerProjectile)
                    end
                end
            end
        else 
            if isTimer(timerProjectile) then
                killTimer(timerProjectile)
            end
        end
    end, 200, 0, projectile) 
end)
