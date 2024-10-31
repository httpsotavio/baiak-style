function onSay(cid, words, param, channel)
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Digite !protecthouse on para ligar a prote��o ou !protecthouse off para deslig�-la.")
		return true
	end
	local parame = tostring(param) 
	
	if parame == "on" then
		
		
		local house = getHouseFromPos(getCreaturePosition(cid))
		
		if not house then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� n�o est� dentro de nenhuma casa!")
			return true
		end
		if getHouseInfo(house, false).owner ~= getPlayerGUID(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� n�o � o dono desta casa!")
			return true
		end
		if isHouseProtected(house) == true then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "A sua casa j� est� protegida!")
			return true
		end
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� ativou a prote��o na sua casa! Agora apenas voc� poder� mexer nos items!")
		setHouseProtection(house, true)
		
	elseif parame == "off" then
		local house = getHouseFromPos(getCreaturePosition(cid))
		
		if not house then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� n�o est� dentro de nenhuma casa!")
			return true
		end
		if getHouseInfo(house, false).owner ~= getPlayerGUID(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� n�o � o dono desta casa!")
			return true
		end
		
		if isHouseProtected(house) == false then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "A prote��o na sua casa j� est� desativada!")
			return true
		end
		
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voc� desativou a prote��o na sua casa! Agora qualquer player poder� mover os itens.")
		setHouseProtection(house, false)
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Digite !protecthouse on para ligar a prote��o ou !protecthouse off para deslig�-la.")
		return true
	end
	
	return true
end
