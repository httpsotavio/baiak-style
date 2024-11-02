local function getWeapon(cid)
    local leftItem = getPlayerSlotItem(cid, CONST_SLOT_LEFT)
    if (leftItem and leftItem.uid > 0) then
        if (isEquipment(leftItem.uid)) then return leftItem end
    end
    local rightItem = getPlayerSlotItem(cid, CONST_SLOT_RIGHT)
    if (rightItem and rightItem.uid > 0) then
        if (isEquipment(rightItem.uid)) then return rightItem end
    end
    return false
end

function onStatsChange(cid, attacker, type, combat, value)
    if (type == STATSCHANGE_HEALTHLOSS and isPlayer(attacker)) then
        local weapon = getWeapon(attacker)
        if (weapon and weapon.uid > 0) then
            local weaponTier = getItemTier(weapon.uid)
            if (weaponTier and weaponTier > 0) then
                local extraDamage = (value / 100) * weaponTier
                doTargetCombatHealth(attacker, cid, type, -extraDamage, -extraDamage, CONST_ME_NONE)
            end
        end
    end
    return true
end