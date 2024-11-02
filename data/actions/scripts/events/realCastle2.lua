function onUse(cid, item, frompos, item2, topos)
	if item.uid == 61469 then
		local guild = getGlobalStorageValue(realCastle.guild_storage) > 1 and "a Guild ["..getGuildNameByID(getGlobalStorageValue(realCastle.guild_storage)).."] possui o dom�nio do castelo." or "nenhuma guild possui o dom�nio do Guild War."
		--local sto = realCastle.date_storages
		--local gsto = getGlobalStorageValue
		--local time = gsto(sto[1]).."/"..gsto(sto[2]).."/"..gsto(sto[3])
		local domain = realCastle.isOpen() and "As guilds est�o batalhando pelo dom�nio do castelo" or guild
		local domain2 = getGlobalStorageValue(123123) > 1 and "a Guild ["..getGuildNameByID(getGlobalStorageValue(123123)).."] possui o dom�nio do castelo." or "nenhuma Guild possui o dom�nio do Castle24H."
		local msg = "--------[Castle24H]-------\nAtualmente "..domain2..".\n\n--------[Guild War]-------\nAtualmente "..domain..".\n\nPr�xima batalha: Amanh� �s 21:00."
		doShowTextDialog(cid,8977,msg)
		return true
	end
	if not realCastle.isOpen() then 
		doTeleportThing(cid,getTownTemplePosition(1)) 
		return true 
	end
	if not realCastle.isDominating(cid) then
		realCastle.domain(cid)
		doSendMagicEffect(getThingPos(cid), CONST_ME_CRAPS)
	else
		doPlayerSendCancel(cid,"Sua guild ganhou o dom�nio do castelo.")
	end
	return true
end
