function onSay(cid, words, param, channel)
	if(not checkExhausted(cid, 660, 5)) then
		return false
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[Balance]:\n\nVoce tem em seu Banco: "..doNumberFormat(getPlayerBalance(cid)).." gold coins.\nVoce tem em sua Backpack: "..doNumberFormat(getPlayerMoney(cid)).." gold coins.")
	return true
end