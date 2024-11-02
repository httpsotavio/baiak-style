function onUse(cid, item, toPosition, itemEx, fromPosition)
local config = {
    levelRequired = 350,
    pos = Position(2478, 992, 7)
}

    if (isPlayerPzLocked(cid)) then
	    return doPlayerSendCancel(cid, "Você não pode se teletransportar agora!")
    end

    if getPlayerLevel(cid) <= config.levelRequired then
        doPlayerSendCancel(cid, "Você precisa ser level maior que "..config.levelRequired.." para usar este item.")
        return true
    else
        doTeleportThing(cid, config.pos)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você foi teleportado para a sala de recompensa!")
        doSendMagicEffect(getCreaturePosition(cid), 14)
        return doRemoveItem(item.uid, 1)
    end
end