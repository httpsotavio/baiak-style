local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENCHANTEDSPEAR)

function onGetFormulaValues(cid, level, skill, attack, factor)
        return -(((skill + 19) / 4) + (level / 5)), -((skill + 22) + (level / 6))
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onCastSpell(cid, var)
        return doCombat(cid, combat, var)
end
