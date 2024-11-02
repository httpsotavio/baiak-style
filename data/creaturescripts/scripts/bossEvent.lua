function onDeath(cid, corpse)
	local bossName = getGlobalStorageValue("bossEvent")
	if isMonster(cid) then
		if getCreatureName(cid) == bossName then
			if getTileItemById(bossEvent.teleportPos.create, 1387).uid >= 1 then
				doSendMagicEffect(bossEvent.teleportPos.create, CONST_ME_GROUNDSHAKER)
				doRemoveItem(getTileItemById(bossEvent.teleportPos.create, 1387).uid, 1)
			end

			doBroadcastMessage("O boss "..bossName.." foi morto!")
			setGlobalStorageValue("bossEvent", 0)
		end
	end
	return true
end

function onLogin(cid)
	registerCreatureEvent(cid, "bossEventDeath")
	registerCreatureEvent(cid, "bossEventLogin")
	return true
end