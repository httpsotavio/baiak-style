local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -775, 0, -800)

function onUseWeapon(cid, var)
return doCombat(cid, combat, var)
end