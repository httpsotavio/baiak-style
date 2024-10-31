Dummy_TypeSkills = {
	[7763] = {skill= SKILL_SWORD, skillName = "Sword Fighting", shoot= CONST_ANI_WHIRLWINDSWORD},
	[7772] = {skill= SKILL_AXE, skillName = "Axe Fighting", shoot= CONST_ANI_WHIRLWINDAXE},
	[7775] = {skill= SKILL_CLUB, skillName = "Club Fighting", shoot= CONST_ANI_WHIRLWINDCLUB},
	[7773] = {skill= SKILL_DISTANCE, skillName = "Distance Fighting", shoot= CONST_ANI_FLASHARROW},
	[2445] = {skill= SKILL_MAGLEVEL, skillName = "Magic Level", shoot= CONST_ANI_CAKE},
}

Dummy_Config = {
	FreeDummies = {7171, 7173},
	PremiumDummies = {7172},
	SkillRate = getConfigValue("rateSkill"),
	MagicRate = getConfigValue("rateMagic"),
}

function start_train(cid, start_pos, itemid, fpos, bonusDummy)
	if isPlayer(cid) then
		local playerPos = getThingPos(cid)
		if playerPos and getTilePzInfo(playerPos) then
			if getPlayerItemCount(cid, itemid) >= 1 then
				local exercise = getPlayerItemById(cid, true, itemid)
				if exercise then
					if getItemAttribute(exercise.uid, "charges") then
						local charges_n = getItemAttribute(exercise.uid, "charges")
						if charges_n >= 1 then
							doItemSetAttribute(exercise.uid, "charges", (charges_n - 1))

							local voc = getPlayerVocation(cid)
							if Dummy_TypeSkills[itemid].skill == SKILL_MAGLEVEL then
								if not bonusDummy then
									doPlayerAddSpentMana(cid, math.ceil(500*Dummy_Config.MagicRate))
								else
									doPlayerAddSpentMana(cid, math.ceil(500*Dummy_Config.MagicRate)*1.1)
								end
							else
								if not bonusDummy then
									doPlayerAddSkillTry(cid, Dummy_TypeSkills[itemid].skill, 1*Dummy_Config.SkillRate)
								else
									doPlayerAddSkillTry(cid, Dummy_TypeSkills[itemid].skill, (1*Dummy_Config.SkillRate)*1.1)
								end
							end
							doSendMagicEffect(fpos, CONST_ME_BLOCKHIT)
							if Dummy_TypeSkills[itemid].shoot then
								doSendDistanceShoot(playerPos, fpos, Dummy_TypeSkills[itemid].shoot)
							end

							setPlayerStorageValue(cid, "isTraining", 1)
							local training = addEvent(start_train, getVocationInfo(voc).attackSpeed, cid, start_pos, itemid, fpos)
							if getDistanceBetween(playerPos, fpos) >= 6 then
								stopEvent(training)
								setPlayerStorageValue(cid, "isTraining", 0)
								doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você se distanciou de mais do Dummy e o treino foi finalizado.")
							end
						else
							stopEvent(training)
							setPlayerStorageValue(cid, "isTraining", 0)
							doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "A sua "..getItemInfo(itemid).name.." ficou sem carga. Recarregue no NPC Charge Weapon.")
						end
					else
						stopEvent(training)
						setPlayerStorageValue(cid, "isTraining", 0)
						doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "A sua "..getItemInfo(itemid).name.." está sem carga. Recarregue no NPC Charge Weapon.")
					end
				end
			end
		else
			stopEvent(training)
			setPlayerStorageValue(cid, "isTraining", 0)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você saiu da área de treino e ele foi finalizado.")
		end
	else
		stopEvent(training)
		setPlayerStorageValue(cid, "isTraining", 0)
	end
	return true
end