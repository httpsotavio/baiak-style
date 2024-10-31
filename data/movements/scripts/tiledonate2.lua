function onStepIn(cid, item, position, fromPosition, toPosition)
	if not isPremium(cid) then
		doTeleportThing(cid, fromPosition)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você não é Premium Account, para virar acesse: http://baiak-frost.com.")
	end
	return true
end