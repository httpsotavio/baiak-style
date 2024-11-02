function onSay(cid, words, param)
	local param = param.explode(param, ',')
	if param and #param == 2 then
		local onlinePlayers = getPlayersOnline()
		for _, pid in pairs(onlinePlayers) do
			doPlayerAddItem(pid, param[1], param[2])
		end
	end
	doBroadcastMessage("O Deus Tibiano acaba de conceder a todos os jogadores online "..param[2].." "..getItemInfo(param[1]).name..".")
return true
end