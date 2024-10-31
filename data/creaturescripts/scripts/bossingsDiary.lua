function onDeath(cid, corpse, deathlist)
    if not isMonster(cid) then return true end

    for i = 1, #deathlist do
        local player = deathlist[i]
        if isPlayer(player) then
            for _, value in pairs(configBossTeleport) do
                if getCreatureName(cid) == value.bossName then
                    local rewardType
                    if isInRange(getPlayerPosition(player), value.bossRoom.from, value.bossRoom.to) then
                        if value.difficulty == "Fácil" then
                            rewardType = "easyBossDiary"
                        elseif value.difficulty == "Médio" then
                            rewardType = "mediumBossDiary"
                        else
                            rewardType = "hardBossDiary"
                        end

                        setPlayerStorageValue(player, rewardType, getPlayerStorageValue(player, rewardType) + 1)
                        doSendMagicEffect(getPlayerPosition(player), CONST_ME_GIFT_WRAPS, player)
                        setPlayerStorageValue(player, value.bossName, os.time() + value.enterTime *24*60*60)
                        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_ORANGE, "Você derrotou o(a) "..value.bossName.." no modo ["..value.difficulty.."]. Vá reivindicar sua recompensa!")
                    end
                end
            end
        end
    end

    return true
end

function onLogin(cid)
    local diaries = {"easyBossDiary", "mediumBossDiary", "hardBossDiary"}
    for _, diary in ipairs(diaries) do
        if getPlayerStorageValue(cid, diary) < 0 then
            setPlayerStorageValue(cid, diary, 0)
        end
    end
    return true
end
