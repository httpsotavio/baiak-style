function onUse(cid, item, fromPosition, itemEx, toPosition)
    local received = false
    for storageBoss, rewardBoss in pairs(configBossReward) do
        local difficultyBoss = getPlayerStorageValue(cid, storageBoss)
        if difficultyBoss >= 1 then
            local randomIndex = math.random(#rewardBoss)
            local reward = rewardBoss[randomIndex]
            if math.random(100) <= reward.chance then
                received = true
                setPlayerStorageValue(cid, storageBoss, difficultyBoss - 1)
                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_GIFT_WRAPS)
                doPlayerAddItem(cid, reward.rewardId, math.random(reward.rewardCount))
            else
                received = true
                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                setPlayerStorageValue(cid, storageBoss, difficultyBoss - 1)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Que azar! Derrote mais boses para ter mais chance de conseguir novas recompensas.")
            end
        end
    end

    if not received then
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
        return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Você não derrotou nenhum boss para ser recompensado.")
    end
    return true
end