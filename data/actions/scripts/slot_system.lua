local cfg = {
	-- [item id]
	[33537] = {
		attribute = SlotSystem.attributes.crit_chance, -- atributo ( chance critica )
		gain = {1, 2}, -- o quanto que pode ganhar
		max = 5, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_DIST, WEAPON_FIST} -- em que armas pode ser atribuido
	},

	[33656] = {
		attribute = SlotSystem.attributes.crit_damage, -- atributo ( dano critico )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 5, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_DIST, WEAPON_FIST} -- em que armas pode ser atribuido
	},

	[37753] = {
		attribute = SlotSystem.attributes.life_leech, -- atributo ( roubo de vida )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 10, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_DIST, WEAPON_FIST} -- em que armas pode ser atribuido
	},

	[37754] = {
		attribute = SlotSystem.attributes.mana_leech, -- atributo ( roubo de mana )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 10, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_DIST, WEAPON_FIST} -- em que armas pode ser atribuido
	},

	[33682] = {
		attribute = SlotSystem.attributes.health, -- atributo ( vida extra )
		gain = {25, 50}, -- o quanto que pode ganhar
		max = 20, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		slotType = {CONST_SLOT_HEAD, CONST_SLOT_ARMOR, CONST_SLOT_LEGS, CONST_SLOT_FEET} -- em que slots pode ser atribuido
	},

	[33683] = {
		attribute = SlotSystem.attributes.mana, -- atributo ( mana extra )
		gain = {25, 50}, -- o quanto que pode ganhar
		max = 20, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		slotType = {CONST_SLOT_HEAD, CONST_SLOT_ARMOR, CONST_SLOT_LEGS, CONST_SLOT_FEET} -- em que slots pode ser atribuido
	},

	[39983] = {
		attribute = SlotSystem.attributes.health_regen, -- atributo ( regen de vida )
		gain = {50, 100}, -- o quanto que pode ganhar
		max = 20, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		--weaponType = {WEAPON_SHIELD}, -- em que armas pode ser atribuido
		slotType = {CONST_SLOT_NECKLACE} -- em que slots pode ser atribuido
	},

	[39984] = {
		attribute = SlotSystem.attributes.mana_regen, -- atributo ( regen de mana )
		gain = {50, 50}, -- o quanto que pode ganhar
		max = 20, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		--weaponType = {WEAPON_SHIELD}, -- em que armas pode ser atribuido
		slotType = {CONST_SLOT_NECKLACE} -- em que slots pode ser atribuido
	},

	[39985] = {
		attribute = SlotSystem.attributes.protect_all, -- atributo ( protection all )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 5, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_SHIELD}, -- em que armas pode ser atribuido
		slotType = {CONST_SLOT_RING} -- em que slots pode ser atribuido
	},

	[39987] = {
		attribute = SlotSystem.attributes.damage, -- atributo ( dano extra )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 10, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_SWORD, WEAPON_CLUB, WEAPON_DIST, WEAPON_AXE} -- em que armas pode ser atribuido
	},

	[40081] = {
		attribute = SlotSystem.attributes.skills, -- atributo ( skills )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 15, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_SHIELD} -- em que armas pode ser atribuido
	},

	[40082] = {
		attribute = SlotSystem.attributes.mag_level, -- atributo ( magic level )
		gain = {1, 1}, -- o quanto que pode ganhar
		max = 15, -- maximo que pode ser adicionado
		success_chance = 50, -- chance de sucesso
		weaponType = {WEAPON_WAND, WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE, WEAPON_SHIELD} -- em que armas pode ser atribuido
	}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local it = cfg[item.itemid]
	if (not it) then
		return true
	end

	if (itemEx.itemid < 4) then
		doPlayerSendCancel(cid, 'Voc� s� pode usar isso em items.')
		doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
		return true
	end

	local slotInfo = SlotSystem:getSlotInfoById(itemEx.itemid)
	local itemInfo = getItemInfo(itemEx.itemid)
	if (not slotInfo or not itemInfo) then
		doPlayerSendCancel(cid, 'Esse item n�o tem slots.')
		doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
		return true
	end

	local canAdd = it.weaponType and isInArray(it.weaponType, itemInfo.weaponType)
	if (not canAdd) then
		canAdd = it.slotType and isInArray(it.slotType, itemInfo.wieldPosition)
	end

	if (not canAdd) then
		doPlayerSendCancel(cid, 'N�o pode ser atribu�do a esse tipo de item.')
		doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
		return true
	end

	if (toPosition.x == 65535 and (toPosition.y == slotInfo.inventory_slot or
		(isInArray({5, 6}, slotInfo.inventory_slot) and isInArray({5, 6}, toPosition.y)))) then
		doPlayerSendCancel(cid, 'Voc� precisa desequipar o item primeiro.')
		doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
		return true
	end

	local usedSlots = SlotSystem:getItemUsedSlots(itemEx.uid)
	for i = 1, usedSlots do
		local pos_effect = {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y - 1, z = getPlayerPosition(cid).z}
		local info = SlotSystem:getItemSlotAttribute(itemEx.uid, i)
		if (info and info.attr == it.attribute) then
			if (info.value >= it.max) then
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'Esse slot j� est� no m�ximo.')
				doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
				return true
			end

			--doRemoveItem(item.uid, 1)
			local addValue = math.random(it.gain[1], it.gain[2])
			if (addValue <= 0 or it.success_chance < math.random(1, 100)) then
				doSendAnimatedText(toPosition, 'Fail...', 180)
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'O item falhou...')
				doSendMagicEffect(pos_effect,354 ) 
				return true
			end

			SlotSystem:setItemSlotAttribute(itemEx.uid, i, it.attribute, math.min(it.max, info.value + addValue))
			doSendAnimatedText(toPosition, 'Success!', 66)
			doSendMagicEffect(pos_effect,356 ) 
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'Slot aplicado com sucesso.')
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
			return true
		end
	end

	local freeSlotsCount = SlotSystem:getItemFreeSlotsCount(itemEx.uid)
	if (freeSlotsCount <= 0) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'Esse item n�o tem slots dispon�veis.')
		doSendMagicEffect(getThingPosition(cid), CONST_ME_POFF)
		return true
	end

	--doRemoveItem(item.uid, 1)
	local pos_effect = {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y - 1, z = getPlayerPosition(cid).z}
	local addValue = math.random(it.gain[1], it.gain[2])
	if (addValue <= 0 or it.success_chance < math.random(1, 100)) then
		doSendAnimatedText(toPosition, 'Fail...', 180)
		doSendMagicEffect(pos_effect,354 ) 
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'O item falhou...')
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	end

	usedSlots = usedSlots + 1
	SlotSystem:setItemSlotAttribute(itemEx.uid, usedSlots, it.attribute, math.min(it.max, addValue))
	SlotSystem:setItemUsedSlots(itemEx.uid, usedSlots)

	doSendAnimatedText(toPosition, 'Success!', 66)
	doSendMagicEffect(pos_effect,356 ) 
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'Slot aplicado com sucesso.')
	doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
	return true
end
