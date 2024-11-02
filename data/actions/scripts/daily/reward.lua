local exit_daily = {x = 1016, y = 588, z = 9}
local reward = {
	[0] = {id = 2346, amount = 1, chance = 10}, -- Stamina Refiller
	[1] = {id = 5468, amount = 1, chance = 15}, -- Remover Skull
	[1] = {id = 5802, amount = 1, chance = 15}, -- Remover Frags
	[1] = {id = 6546, amount = 1, chance = 15}, -- Remover Mortes		
	[2] = {id = 7141, amount = 1, chance = 20}, -- Cave Exclusiva
	[3] = {id = 7443, amount = 1, chance = 40}, -- Boost Exp
	[4] = {id = 38008, amount = 1, chance = 50}, -- Addon Doll
	[5] = {id = 9971, amount = 5, chance = 65}, -- 150k
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (item.actionid == 45362) then
		if getPlayerFreeCap(cid) < 105.00 then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Voc� precisa ter mais que '105.00 oz' para abrir o ba�, por seguran�a.")
		end
		
		if getPlayerStorageValue(cid, 45358) - os.time() >= 0 then
			doTeleportThing(cid, exit_daily)
			doSendMagicEffect(getCreaturePosition(cid), 12)
			return doPlayerSendTextMessage(cid, 27, "Seu tempo para Daily ainda n�o expirou! Voc� n�o deveria estar nesta SALA!!")
		end
		
		local rand = math.random(1,100)
		for i = 0, #reward do
			if (reward[i].chance > rand) then
				if doPlayerAddItem(cid, reward[i].id, reward[i].amount) then
					doTeleportThing(cid, exit_daily)
					doSendMagicEffect(toPosition, CONST_ME_MAGIC_GREEN)
					setPlayerStorageValue(cid, 45358, os.time()+20*60*60)
					return doPlayerSendTextMessage(cid, 27, "Voc� finalizou a Daily Quest e recebeu um item. Poder� fazer a Daily novamente em: ".. convertTime(getPlayerStorageValue(cid, 45358) - os.time()) ..".")
				else
					return doPlayerPopupFYI(cid, "                                  [+] Daily Quest [+]\n\nVoc� est� sem espa�o em sua backpack. Libere espa�o.\nSe continuar clicando poder� perder sua DAILY!")
				end
			end
		end
	end
    return true
end