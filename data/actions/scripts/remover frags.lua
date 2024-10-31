function onUse(cid, item, fromPosition, itemEx, toPosition)
local queryFrags = getPlayerGUID(cid)

    if getTilePzInfo(getCreaturePosition(cid)) then
        doRemoveItem(item.uid, 1)
        doSendMagicEffect(getCreaturePosition(cid), math.random(22, 24))
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sua lista de assassinatos esta limpa.")
        db.executeQuery('UPDATE `killers` SET `unjustified` = 0 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` ='.. queryFrags ..');')
    else
        doPlayerSendCancel(cid, "Voce precisa estar na Protection Zone.")
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)   
    end
    return true
end