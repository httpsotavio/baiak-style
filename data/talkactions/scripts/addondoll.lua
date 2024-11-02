function onSay(cid, words, param)
	if(not checkExhausted(cid, 660, 5)) then
		return false
	end

	local femaleOutfits = { ["citizen"]={136}, ["hunter"]={137}, ["mage"]={138}, ["knight"]={139}, ["nobleman"]={140}, ["summoner"]={141}, ["warrior"]={142}, ["barbarian"]={147}, ["druid"]={148}, ["wizard"]={149}, ["oriental"]={150}, ["pirate"]={155}, ["assassin"]={156}, ["beggar"]={157}, ["shaman"]={158}, ["norsewoman"]={252}, ["nightmare"]={269}, ["jester"]={270}, ["brotherhood"]={279}, ["demonhunter"]={288}, ["yalaharian"]={324}}
	local maleOutfits = { ["citizen"]={128}, ["hunter"]={129}, ["mage"]={130}, ["knight"]={131}, ["nobleman"]={132},["summoner"]={133}, ["warrior"]={134}, ["barbarian"]={143}, ["druid"]={144}, ["wizard"]={145}, ["oriental"]={146}, ["pirate"]={151}, ["assassin"]={152}, ["beggar"]={153}, ["shaman"]={154}, ["norsewoman"]={251}, ["nightmare"]={268}, ["jester"]={273}, ["brotherhood"]={278}, ["demonhunter"]={289}, ["yalaharian"]={325}}
	local blockedOutfits = {"wayfarer", "warmaster", "mage", "warrior", "druid", "assassin", }
	local param = string.lower(param)
	if(getPlayerItemCount(cid, 9693) > 0) then
		for i= 1, #blockedOutfits do
			if (param:lower() == blockedOutfits[i]) then
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
				doPlayerSendCancel(cid, "N�o � poss�vel adquirir este addon desta forma.")
				return true
			end
		end
		
		if(param ~= "" and maleOutfits[param] and femaleOutfits[param]) then
			local outfitId = getPlayerSex(cid) == 0 and femaleOutfits[param][1] or maleOutfits[param][1]
			if(canPlayerWearOutfit(cid, outfitId, 3)) then
				doPlayerSendCancel(cid, "Voc� j� possui este addon.")
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
				return true
			end
			doPlayerRemoveItem(cid, 9693, 1)
			if(getPlayerSex(cid) == 0)then
				doPlayerAddOutfit(cid, femaleOutfits[param][1], 3)
			else
				doPlayerAddOutfit(cid, maleOutfits[param][1], 3)
			end
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_GIFT_WRAPS)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O addon "..param.." foi adicionado a sua lista!")
		else
			doPlayerSendCancel(cid, "Digite o nome correto!\nExemplo: !addon citizen.")
		end
	else
		doPlayerSendCancel(cid, "Voc� n�o possui o item necess�rio para usar este comando.")
	end
	return true
end