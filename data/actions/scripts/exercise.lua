function onUse(cid, item, fromPosition, itemEx, toPosition)
	local start_pos = getPlayerPosition(cid)
	local item_pos = getThingPos(itemEx.uid)

	if start_pos and getTilePzInfo(start_pos) then
		if getPlayerStorageValue(cid, "isTraining") == 1 then
			doSendMagicEffect(start_pos, CONST_ME_POFF)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você já está treinando.")
			return true
		end

		local exercise = getPlayerItemById(cid, true, item.itemid)
		if exercise then
			if isInArray(Dummy_Config.PremiumDummies, itemEx.itemid) then
				if getDistanceBetween(start_pos, item_pos) > 1 then
					doSendMagicEffect(start_pos, CONST_ME_POFF)
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Aproxime-se mais do Dummy.")
					return true
				end
				if getItemAttribute(exercise.uid, "charges") and getItemAttribute(exercise.uid, "charges") >= 1 then
					doSendMagicEffect(start_pos, CONST_ME_HITAREA)
					start_train(cid, start_pos, item.itemid, item_pos, true)
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Seu treino começou.\nSkill: ["..Dummy_TypeSkills[item.itemid].skillName.."].")
				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "A sua "..getItemInfo(item.itemid).name.." está sem carga. Recarregue no NPC Charge Weapon.")
				end
				
			elseif isInArray(Dummy_Config.FreeDummies, itemEx.itemid) then
				if getDistanceBetween(start_pos, item_pos) > 1 then
					doSendMagicEffect(start_pos, CONST_ME_POFF)
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Aproxime-se mais do Dummy.")
					return true
				end
				if getItemAttribute(exercise.uid, "charges") and getItemAttribute(exercise.uid, "charges") >= 1 then
					doSendMagicEffect(start_pos, CONST_ME_HITAREA)
					start_train(cid, start_pos, item.itemid, item_pos, false)
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Seu treino começou.\nSkill: ["..Dummy_TypeSkills[item.itemid].skillName.."].")
				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "A sua "..getItemInfo(item.itemid).name.." está sem carga. Recarregue no NPC Charge Weapon].")
				end
			end
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "A sua posição atual não corresponde com a área de treino do Dummy.")
	end
	return true
end