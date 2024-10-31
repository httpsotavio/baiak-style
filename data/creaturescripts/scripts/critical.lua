local configCriticalPercent = {
    storage = 48903,
    effect = {100, 20},
    message = "Critical!",

    percent = {
        {min = 1, max = 10, chance = 3},
        {min = 11, max = 20, chance = 6},
        {min = 21, max = 40, chance = 8},
        {min = 41, max = 50, chance = 11},
        {min = 51, max = 70, chance = 13},
        {min = 71, max = 90, chance = 15},
        {min = 91, max = 100, chance = 18}
    },
}

function onStatsChange(cid, attacker, type, combat, value)
    if (type == STATSCHANGE_HEALTHLOSS or type == STATSCHANGE_MANALOSS) and isPlayer(attacker) then
        local criticalPercent = getPlayerStorageValue(attacker, configCriticalPercent.storage)
        for _, criticalRange in ipairs(configCriticalPercent.percent) do
            if criticalPercent >= criticalRange.min and criticalPercent <= criticalRange.max then
                local rand = math.random(1, 100)
                if rand <= criticalRange.chance then
                    local danoMin = math.ceil(value * 1.2)
                    local danoMax = math.ceil(value * 1.5)
                    doSendAnimatedText(getCreaturePos(attacker), configCriticalPercent.message, configCriticalPercent.effect[1])
                    doTargetCombatHealth(attacker, cid, COMBAT_PHYSICALDAMAGE, -danoMin, -danoMax, configCriticalPercent.effect[2])
                end
            end
        end
    end
    return true
end