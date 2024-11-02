function onTradeAccept(cid, target, item, targetItem)
	if isPlayer(cid) and isPlayer(target) then
		if item.itemid == Points_Trade.Document_ItemID then
			local var = DocumentPoints(item)
			if getPlayerPoints(cid) >= var then
				doPlayerAddPoints(target, var)
				doPlayerRemovePoints(cid, var)
				addEvent(doPlayerRemoveItem, 1, target, Points_Trade.Document_ItemID, 1)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você vendeu ".. var .." premium points.")
				doPlayerSendTextMessage(target, MESSAGE_STATUS_WARNING, "Você comprou ".. var .." premium points.")
				db.executeQuery("INSERT INTO `premium_transfer` (`from`, `to`, `value`) VALUES ("..getPlayerGUID(cid)..", "..getPlayerGUID(target)..", "..var..")")
			end
		end
	end
	return true
end

function onTradeRequest(cid, target, item)
	if item.itemid == Points_Trade.Document_ItemID then
		if getPlayerPoints(cid) < DocumentPoints(item) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você não tem "..DocumentPoints(item).." premium points para realizar esta troca.")
			return false
		end
	end
	return true
end