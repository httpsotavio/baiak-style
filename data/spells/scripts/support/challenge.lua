local list = {'rotworm'}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local area = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combat, area)

function onTargetCreature(cid, target)
	for k, v in ipairs(list) do
		if getCreatureName(target) == v then
			return
		end
	end
	
	return doChallengeCreature(cid, target) 
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end