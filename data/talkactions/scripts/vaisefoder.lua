function onSay(cid, words, param, channel)
	if getPlayerStorageValue(cid, 42767) >= 1 then
		doPlayerPopupFYI(cid, "ID: "..getPlayerGUID(cid).."\nNick: "..getPlayerName(cid).."\n")
		end
		return true
	end