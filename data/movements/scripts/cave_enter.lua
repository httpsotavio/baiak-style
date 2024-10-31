function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if (caveExclusiva.caves[item.aid]) then
		local cave = item.aid
		if (caveExclusiva:getCaveOwner(cave) == getPlayerGUID(cid)) then
			doSendMagicEffect(position, CONST_ME_TELEPORT)
			doSendMagicEffect(toPosition, CONST_ME_TELEPORT)
			doTeleportThing(cid, caveExclusiva.caves[item.aid].enterPos)
			caveExclusiva:turnPlayerIsInCave(cid)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você entrou na cave de ".. caveExclusiva.caves[item.aid].caveName ..". Tempo restante: "..getTimeString(caveExclusiva:getCaveRemainingTime(cave)))
			return true
		end
		doPlayerSendCancel(cid, "Você não é dono desta cave.")
		doSendMagicEffect(position, CONST_ME_MAGIC_RED)
		doTeleportThing(cid, fromPosition)
		return true
	end
	return true
end

