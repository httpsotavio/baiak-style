function onUse(cid, item, fromPosition, itemEx, toPosition)
    if itemEx.itemid == caveExclusiva.config.buyItemID then
        if (getPlayerLevel(cid)) >= 500 then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você não pode mais usar este item. O level permitido para o uso do item é de 550.")
            doSendAnimatedText(getPlayerPosition(cid), "Failed!", 180)
            doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
            return true
        end

        if caveExclusiva:getPlayerCave(cid) > 0 then
            local caveName = caveExclusiva.caves[getPlayerStorageValue(cid, caveExclusiva.storages.cave)].caveName
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você já é dono da cave de ".. caveName ..".")
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
            return true
        end
        if caveExclusiva:getCaveOwner(itemEx.aid) > 0 then
            local ownerGUID = caveExclusiva:getCaveOwner(itemEx.aid)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Esta cave já pertence ao player ".. getPlayerNameByGUID(ownerGUID) ..".")
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
            return true
        end
        if getPlayerStorageValue(cid, "cavExclu") - os.time() <= 0 then
            doRemoveItem(item.uid)
            caveExclusiva:turnPlayerCave(cid, itemEx.aid)
            caveExclusiva:setCaveOwner(itemEx.aid, getPlayerGUID(cid))
            doSendMagicEffect(getThingPos(cid), CONST_ME_FIREWORK_BLUE)
            setPlayerStorageValue(cid, "cavExclu", os.time() + caveExclusiva.config.timeUse * 60 * 60)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Você alugou a cave de " ..caveExclusiva.caves[itemEx.aid].caveName.. " por " ..getTimeString(caveExclusiva.config.rentTime).. ".")
            return true
        else
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você precisa esperar "..convertTime(getPlayerStorageValue(cid, "cavExclu") - os.time()).." para poder usar o item novamente.")
        end
    else
        doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Use este item em um pilar de cave exclusiva.")
    end
    return true
end