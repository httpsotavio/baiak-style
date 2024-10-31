function onStepIn(cid, item, toPosition, fromPosition)
local config = {
  playerLevel = 500,
  kickPos = fromPosition,
}

  if not isPlayer(cid) then
    return false
  end

  if getPlayerLevel(cid) >= config.playerLevel then
    doSendMagicEffect(getCreaturePosition(cid), 12)
  else
    doTeleportThing(cid, config.kickPos)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    doPlayerSendCancel(cid, "Voce nao tem level superior a "..config.playerLevel.." e nao podera passar.")
  end
  return true
end