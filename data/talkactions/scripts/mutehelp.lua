function onSay(cid, words, param)
	if param == '' then
		return doPlayerSendCancel(cid, 'Informe o nome do jogador e o tempo em segundos.')
	end
	
	local default = 600
	local tmp = string.explode(param, ',')

	local target = getPlayerByNameWildcard(tmp[1])

	if not target or (isPlayerGhost(target) and getPlayerGhostAccess(target) > getPlayerGhostAccess(cid)) then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,t[1].." não estã online.")
		return true
	end
	
	local time = tonumber(tmp[2])
	if not time or time < 1 then
		time = default
	end

	if time > 100000 and getPlayerAccess(cid) < 4 then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"Você não pode mutar por mais de 100000 segundos.")
		return true
	end

	doPlayerSendTextMessage(target, MESSAGE_STATUS_CONSOLE_RED, " foi mutado por "..time.." segundos.")
	doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,t[1].." foi mutado por "..time.." segundos.")

	setPlayerStorageValue(target, 455010, os.time() + (tonumber(tmp[2]) or default))
	doPlayerSendCancel(cid, 'O jogador ' .. tmp[1] .. ' foi mutado.')
	return true
end