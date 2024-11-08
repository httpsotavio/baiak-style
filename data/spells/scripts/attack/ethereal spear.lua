local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ROYALSPEAR)

function onGetFormulaValues(cid, level, skill, attack, factor)
        return -(((skill + 23) / 6) + (level / 7)), -((skill + 25) + (level / 8))
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onCastSpell(cid, var)
        return doCombat(cid, combat, var)
end