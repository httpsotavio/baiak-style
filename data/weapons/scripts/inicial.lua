local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_CAKE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_CAKE)
local baseDamage, maxDamage = 400, 450
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -baseDamage, 0, -maxDamage)

function onUseWeapon(cid, var)
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
	return doCombat(cid, combat, var)
end