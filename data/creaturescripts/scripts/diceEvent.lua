function onLogin(cid)
	registerCreatureEvent(cid, "CombatDiceLogin")
	registerCreatureEvent(cid, "CombatDiceTarget")
	registerCreatureEvent(cid, "CombatDiceCombat")
	return true
end

function onCombat(cid, target)
	if isPlayer(cid) and isPlayer(target) and isInRange(getPlayerPosition(cid), {x= 14768, y= 15023, z= 7}, {x= 14785, y= 15039, z= 7}) then
		doPlayerSendCancel(cid, "You may not attack this player.") return false	
	end
	return true
end

function onTarget(cid, target)
	if isPlayer(cid) and isPlayer(target) and isInRange(getPlayerPosition(cid), {x= 14768, y= 15023, z= 7}, {x= 14785, y= 15039, z= 7}) then
		doPlayerSendCancel(cid, "You may not attack this player.") return false	
	end
	return true
end