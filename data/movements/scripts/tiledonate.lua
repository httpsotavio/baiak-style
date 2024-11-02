function onStepIn(cid, item, position, fromPosition)
local tileConfig = {
	kickPos = fromPosition, kickEffect = CONST_ME_POFF,
	kickMsg = "Você não é Premium Account, para virar acesse: http://baiak-frost.com",
	enterEffect = CONST_ME_MAGIC_RED,
}

if isPlayer(cid) then
	if isPremium(cid) then
		doTeleportThing(cid, {x= 4904, y= 662, z= 6})
		doSendMagicEffect(getPlayerPosition(cid), tileConfig.enterEffect)
	else
		doTeleportThing(cid, tileConfig.kickPos)
		doPlayerSendCancel(cid, tileConfig.kickMsg)
		doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
	end
	return true
	end
end