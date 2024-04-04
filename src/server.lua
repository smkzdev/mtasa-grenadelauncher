function isWeaponAllowed()
    local ALLOWED_WEAPONS = {22, 23, 24, 25, 27, 30, 31, 33}
    local status = false
    for i, weapon in pairs(ALLOWED_WEAPONS) do
        if WEAPON_ID == weapon then status = true end
    end

    if status == false then return false end
    local skills = {"poor", "std", "pro"}
    for i, skill in pairs(skills) do
        setWeaponProperty(WEAPON_ID, skill, "flag_move_and_shoot", true)
        setWeaponProperty(WEAPON_ID, skill, "weapon_range", 300)
        setWeaponProperty(WEAPON_ID, skill, "target_range", 300)
        setWeaponProperty(WEAPON_ID, skill, "flag_move_and_aim", true)
        setWeaponProperty(WEAPON_ID, skill, "flag_anim_reload", false)
        setWeaponProperty(WEAPON_ID, skill, "flag_shot_anim_abrupt", false)
    end
end
isWeaponAllowed()