function onStepIn(cid, item, toPosition, fromPosition)
  if realCastle.isDominating(cid) then
    doTeleportThing(cid, fromPosition)
    doSendMagicEffect(getPlayerPosition(cid), 6)
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "As Hunts foram desativadas. Sua guild possui mais ganho de experiência por isso.")
  end
  return true
end