local configTable = {
	[43523] = {itemid = 17138, voca = {4, 8}}, -- Sword
	[43524] = {itemid = 35044, voca = {4, 8}}, -- Club
	[43525] = {itemid = 43462, voca = {4, 8}}, -- Axe
	[43526] = {itemid = 37633, voca = {1, 2, 5, 6}}, -- Wand
	[43527] = {itemid = 13696, voca = {3, 7}} -- Slingshot
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local accessTable = configTable[item.actionid]
	if accessTable then
		if getPlayerStorageValue(cid, "armadnt") ~= 1 then
			if isInArray(accessTable.voca, getPlayerVocation(cid)) then
				setPlayerStorageValue(cid, "armadnt", 1)
				doPlayerAddItem(cid, accessTable.itemid, 1)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Parab�ns, voc� conseguiu encontrar uma das melhores weapons do jogo. Agora v� e inicie sua jornada!")
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "A weapon escolhida n�o coincide com a sua voca��o. Escolha uma outra weapon e inicie sua jornada.")
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Voc� j� recolheu a recompensa do ba�!")
		end
	end
	return true
end