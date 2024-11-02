function onUse(cid, item, fromPosition, itemEx, toPosition)
local queryMorte = getPlayerGUID(cid)

    if getTilePzInfo(getCreaturePosition(cid)) then
    doRemoveItem(item.uid, 1)
    doSendMagicEffect(getCreaturePosition(cid), math.random(22, 24))
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sua lista de fracassos esta limpa.")
    db.executeQuery('DELETE FROM `player_deaths` WHERE `player_id` ='.. queryMorte ..';')
else
    doPlayerSendCancel(cid, "Voce precisa estar na Protection Zone.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    end
    return true
end