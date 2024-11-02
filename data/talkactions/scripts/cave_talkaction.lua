local exhausted = 5 -- Segundos

function onSay(cid, words, param, channel)

	if exhaustion.get(cid, 400) then
		doPlayerSendCancel(cid, "Você poderá usar este comando novamente após ".. exhaustion.get(cid, 400) .." segundos.")
		return true
	end
	exhaustion.set(cid, 400, exhausted)	

	if (string.lower(param) == "time") then
		if (caveExclusiva:getPlayerCave(cid) > 0) then
			local timeLeft = caveExclusiva:getCaveRemainingTime(caveExclusiva:getPlayerCave(cid))
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Você possui ".. getTimeString(timeLeft) .." restantes.")
			return true
		end
		doPlayerSendCancel(cid, "Você não é dono de nenhuma cave.")
		return true
	end

	if (string.lower(param) == "stats") then
		local info = {}
		table.insert(info, "-----> Cave Exclusiva Stats <-----\n")
		for cave, tab in pairs(caveExclusiva.caves) do
			table.insert(info, "* Cave: "..tab.caveName.."\n")
			local caveOwner = caveExclusiva:getCaveOwner(cave)
			if (caveOwner > 0) then
				caveOwner = getPlayerNameByGUID(caveOwner)
			else
				caveOwner = "Livre"
			end
			table.insert(info, "* Dono: "..caveOwner.."\n")
			local remainingTime = caveExclusiva:getCaveRemainingTime(cave)
			if (remainingTime <= 0) then
				remainingTime = "0"
			else
				remainingTime = getTimeString(tonumber(remainingTime))
			end
			table.insert(info, "* Tempo: "..remainingTime.."\n\n")
		end
		doShowTextDialog(cid, 8981, table.concat(info))
		return true
	end

	doPlayerSendCancel(cid, "Use o parametro time ou stats.")
	return true
end