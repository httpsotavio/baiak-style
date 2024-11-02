function onUse(cid, item, fromPosition, itemEx, toPosition)
	if getPlayerStorageValue(cid, 4463456345645) ~= 1 then
		doPlayerAddItem(cid, 7443, 1)
		doPlayerAddItem(cid, 2346, 1)
		db.executeQuery("UPDATE `accounts` SET `premdays` = `premdays` + 5 WHERE `id` = "..getPlayerAccountId(cid).."")
		setPlayerStorageValue(cid, 4463456345645, 1)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você recebeu 5 Dias de Premium Points, 1 Stamina Potion e 1 Double Exp.")
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta recompensa não vai ficar para sempre, é só uma recompensa pelo bug que ocorreu na Cave Exclusiva e nos fez ter que resetar o servidor. Obrigado por voltar!")
	else
		doPlayerSendCancel(cid, "Você já coletou a recompensa!")
	end
	return true
end