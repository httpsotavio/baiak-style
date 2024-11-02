function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
local accessTable = configBossTeleport[item.actionid]
  if accessTable then
    if accessTable.lvlRequired then
      if getPlayerLevel(cid) < accessTable.lvlMin then
        doTeleportThing(cid, fromPosition)
        doPlayerSendCancel(cid, "Você precisa ser no mínimo lvl"..accessTable.lvlMin.." para poder enfrentar o(a) "..accessTable.bossName..".")
        doSendMagicEffect(fromPosition, CONST_ME_POFF)
        return true
      end
    end
    local playersInRoom = getPlayersInRoom(accessTable.bossRoom.from, accessTable.bossRoom.to)
    if (#playersInRoom) == accessTable.maxPlayer then
      doTeleportThing(cid, fromPosition)
      doSendMagicEffect(fromPosition, CONST_ME_POFF)
      doPlayerSendCancel(cid, "Você precisa esperar a sala já atingiu o máximo de "..accessTable.maxPlayer..".")
      return true
    elseif getPlayerStorageValue(cid, accessTable.bossName) - os.time() > 0 then
      doTeleportThing(cid, fromPosition)
      doSendMagicEffect(fromPosition, CONST_ME_POFF)
      doPlayerSendCancel(cid, "Você precisa esperar "..convertTime(getPlayerStorageValue(cid, accessTable.bossName) - os.time()).." para poder enfrentar o(a) "..accessTable.bossName..".")
      return true
    else
      if doTeleportThing(cid, accessTable.playerEnter) then
        doSendMagicEffect(accessTable.playerEnter, CONST_ME_MAGIC_GREEN, cid)
        if not bossInArea({accessTable.bossRoom.from, accessTable.bossRoom.to}, accessTable.bossName) then
          local monster = doCreateMonster(accessTable.bossName, accessTable.bossPosition)
          doSendMagicEffect(getCreaturePosition(monster), CONST_ME_FIREATTACK)
        end
        addEvent(function()
          if isPlayer(cid) then
            if isInRange(getPlayerPosition(cid), accessTable.bossRoom.from, accessTable.bossRoom.to) then
              doTeleportThing(cid, {x = 797, y = 1064, z = 13})
              doSendMagicEffect(getPlayerPosition(cid), CONST_ME_BATS)
              setPlayerStorageValue(cid, accessTable.bossName, os.time() + accessTable.enterTime *24*60*60)
            end
          end
        end, accessTable.duelTime * 1000)
      end
    end
  end
  return true
end