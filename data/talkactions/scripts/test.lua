function onSay(cid, words, param, channel)
	realCastle.open()
	addEvent(function()
		realCastle.close()
	end, 120000)
	return true
end
