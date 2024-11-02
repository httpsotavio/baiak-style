local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_GREENSTAR)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, 0, 0, 1.0, 0)

local xCombat = createCombatObject()
setCombatParam(xCombat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 4, 700, -2)
addDamageCondition(condition, 6, 800, -1)
setCombatCondition(xCombat, condition)

function onUseWeapon(cid, var)
	local ret = doCombat(cid, combat, var)
	if(ret == false) then
		return false
	end

	local target = variantToNumber(var)
	if(target ~= 0) then
		-- chance to poison the enemy
		local chance = math.random(0, 100)
		if(chance > 90) then
			ret = doCombat(cid, xCombat, var)
		end
	end

	local playerWeapon1 = getPlayerSlotItem(cid, CONST_SLOT_RIGHT)
	if (playerWeapon1 and playerWeapon1.uid and playerWeapon1.uid > 0) then
		if (isEquipment(playerWeapon1.uid)) then
			if (isCreature(variantToNumber(var))) then
				doTargetCombatHealth(cid, variantToNumber(var), COMBAT_NONE, (5 * getItemTier(playerWeapon1.uid)), (5 * getItemTier(playerWeapon1.uid)), 0xFFFF, false, ORIGIN_NONE)
			end
		end
	end
	local playerWeapon2 = getPlayerSlotItem(cid, CONST_SLOT_LEFT)
	if (playerWeapon2 and playerWeapon2.uid and playerWeapon2.uid > 0) then
		if (isEquipment(playerWeapon2.uid)) then
			if (isCreature(variantToNumber(var))) then
				doTargetCombatHealth(cid, variantToNumber(var), COMBAT_NONE, (5 * getItemTier(playerWeapon2.uid)), (5 * getItemTier(playerWeapon2.uid)), 0xFFFF, true)
			end
		end
	end
	return ret
end
