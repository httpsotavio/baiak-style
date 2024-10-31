local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
local baseDamage, maxDamage = 550, 675
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -baseDamage, 0, -maxDamage)

function onUseWeapon(cid, var)
	local playerWeapon = getPlayerWeapon(cid, true)
	if (playerWeapon and playerWeapon.uid > 0) then
		print("extra dmg: ".. (maxDamage / 100) * getItemTier(playerWeapon))
		setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -baseDamage, 0, -maxDamage + ((maxDamage / 100) * getItemTier(playerWeapon)))
	end
	return doCombat(cid, combat, var)
end