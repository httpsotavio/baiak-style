local configDodgePercent = {
    storage = 98798644,
    effect = {250, 31},
    mensagem = "Dodge!",

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
    if not isCreature(cid) then
        return false
    end

    local dodgePercent = getPlayerStorageValue(cid, configDodgePercent.storage)
    for _, dodgeRange in ipairs(configDodgePercent.percent) do
        if dodgePercent >= dodgeRange.min and dodgePercent <= dodgeRange.max then
            local rand = math.random(1, 100)
            if rand <= dodgeRange.chance then
                if combat ~= COMBAT_HEALING then
                    doSendMagicEffect(getCreaturePosition(cid), configDodgePercent.effect[2])
                    doSendAnimatedText(getCreaturePosition(cid), configDodgePercent.mensagem, configDodgePercent.effect[1])
                    return false
                end
            end
        end
    end

    return true
end