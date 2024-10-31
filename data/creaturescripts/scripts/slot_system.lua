local cfg = {
	crit_base_multiplier = 1.2, -- multiplicador do critical base
}

function onLogin(cid)
	registerCreatureEvent(cid, "SlotSystem_equip")
	registerCreatureEvent(cid, "SlotSystem_unequip")
	registerCreatureEvent(cid, "SlotSystem_combat")
	registerCreatureEvent(cid, "SlotSystem_statschangeex")
	registerCreatureEvent(cid, "SlotSystem_think")
	registerCreatureEvent(cid, "SlotSystem_look")
	SlotSystem:onLogin(cid)
	return true
end

function onEquipItem(cid, item, slot)
	SlotSystem:onEquipItem(cid, item, slot)
end

function onUnequipItem(cid, item, slot)
	SlotSystem:onUnEquipItem(cid, item, slot)
end

function onCombat(cid, target)
	if (isMonster(target)) then
		registerCreatureEvent(target, "SlotSystem_statschangeex")
	end
	return true
end

function onStatsChangeEx(cid, attacker, statType, combat, value, origin, inherited)
	if (inherited) then
		return value
	end

	-- is damage
	if (statType == STATSCHANGE_HEALTHLOSS or statType == STATSCHANGE_MANALOSS) then
		local attackerIsPlayer = isPlayer(attacker)
		if (attackerIsPlayer) then
			local damagePercent = SlotSystem:getPlayerAttributeValue(attacker, SlotSystem.attributes.damage)
			if (damagePercent > 0) then
				value = value + (value * (damagePercent / 100))
			end
			
			-- SPELL DAMAGE
			local storage = getPlayerStorageValue(attacker, STORAGE_SPELL_DAMAGE) or 0
			if storage and tonumber(storage) > 0 then
				value = value + (value * (getPlayerStorageValue(attacker, STORAGE_SPELL_DAMAGE) / 100))
				-- doSendAnimatedText(getThingPos(attacker), "inject", 100)
			end			
			-- SPELL SCROLL
			local storage = getPlayerStorageValue(attacker, STORAGE_SCROLL_VIP) or 0
			if storage and tonumber(storage) > 0 then
				value = value + (value * (getPlayerStorageValue(attacker, STORAGE_SCROLL_VIP) / 100))
				-- doSendAnimatedText(getThingPos(attacker), "+Damage", 140)
			end			
			-- Damage = reborn
			local storage = getPlayerStorageValue(attacker, INCREASE_DAMAGE_REBORN) or 0
			if storage and tonumber(storage) > 0 then
				value = value + (value * (getPlayerStorageValue(attacker, INCREASE_DAMAGE_REBORN) / 100))
				-- doSendAnimatedText(getThingPos(attacker), "+Damage", 140)
			end			
			-- Damage = reborn
			local storage = getPlayerStorageValue(attacker, SHENLONG_DAMAGE) or 0
			if storage and tonumber(storage) > 0 then
				value = value + (value * (getPlayerStorageValue(attacker, SHENLONG_DAMAGE) / 100))
				-- doSendAnimatedText(getThingPos(attacker), "+Damage", 140)
			end

			local critChance = SlotSystem:getPlayerAttributeValue(attacker, SlotSystem.attributes.crit_chance)
			if (critChance >= math.random(1, 100)) then
				value = value * cfg.crit_base_multiplier
				doSendAnimatedText(getThingPosition(attacker), "Critical!", 108)

				local critDamage = SlotSystem:getPlayerAttributeValue(attacker, SlotSystem.attributes.crit_damage)
				if (critDamage > 0) then
					value = value + (value * (critDamage / 100))
				end
			end
		end

		if (isPlayer(cid)) then
			local protectAll = SlotSystem:getPlayerAttributeValue(cid, SlotSystem.attributes.protect_all)
			if (protectAll > 0) then
				value = value - (value * (protectAll / 100))
			end
		end

		if (attackerIsPlayer) then
			local lifeLeech = SlotSystem:getPlayerAttributeValue(attacker, SlotSystem.attributes.life_leech)
			if (lifeLeech > 0) then
				local leechValue = math.abs(value * (lifeLeech / 100))
				doTargetCombatHealth(attacker, attacker, COMBAT_HEALING, leechValue, leechValue, 0xFFFF, false, ORIGIN_NONE)
			end

			local manaLeech = SlotSystem:getPlayerAttributeValue(attacker, SlotSystem.attributes.mana_leech)
			if (manaLeech > 0) then
				local leechValue = math.abs(value * (manaLeech / 100))
				doTargetCombatMana(attacker, attacker, leechValue, leechValue, 0xFFFF, false, ORIGIN_NONE)
			end
		end
	end
	return value
end

local RegenTimerTable = {}
function onThink(cid, interval)
	if (not isPlayer(cid)) then
		return true
	end

	local guid = getPlayerGUID(cid)
	RegenTimerTable[guid] = (RegenTimerTable[guid] or 0) + interval
	if (RegenTimerTable[guid] >= 1000) then
		RegenTimerTable[guid] = RegenTimerTable[guid] - 1000

		local healthRegen = SlotSystem:getPlayerAttributeValue(cid, SlotSystem.attributes.health_regen)
		if (healthRegen > 0) then
			doCreatureChangeHealth(cid, healthRegen)
		end

		local manaRegen = SlotSystem:getPlayerAttributeValue(cid, SlotSystem.attributes.mana_regen)
		if (manaRegen > 0) then
			doCreatureChangeMana(cid, manaRegen)
		end
	end
	return true
end

function onLook(cid, thing, position, lookDistance)
	if (thing.itemid > 3) then
		local description, details = getThingDescription(thing.uid, lookDistance, cid)
		local slotsDescription = SlotSystem:getItemSlotsDescription(thing.uid)
		if (slotsDescription ~= '') then
			description = description .. '\nSlots: ' .. slotsDescription
		end

		local freeSlots = SlotSystem:getItemFreeSlotsCount(thing.uid)
		if (freeSlots > 0) then
			description = description .. '\nSlot Vazio: [' .. freeSlots .. ' slot' .. (freeSlots > 1 and 's' or '') .. ']'
		end

		if (details) then
			description = description .. details
		end

		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You see " .. description)
		return false
	end
	return true
end
