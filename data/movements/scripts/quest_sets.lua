function onStepIn(cid, item, toPosition, fromPosition)
local config = {
    storage = 8000
}
    if getPlayerStorageValue(cid, config.storage) <= -1 then
        doCreatureSay(cid, "Voc� precisa fazer a quest do Assault Set para ter acesso a esta quest.", TALKTYPE_MONSTER, true, cid)
        doTeleportThing(cid, fromPosition)
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
        return true
    end
end