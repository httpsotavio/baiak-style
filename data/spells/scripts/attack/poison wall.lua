local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1496)

local area = createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	if BlockRunesInArea(cid) then
		doPlayerSendCancel(cid, "Você não pode jogar runas nesta area.")
		return false
	end
	ret = doCombat(cid, combat, var)
	if ret then
		local mWall = getTileItemById(variantToPosition(var), 1496).uid
		--doItemSetAttribute(mWall, "description", string.format("Poison Wall de: %s.", getCreatureName(cid)))
	end	
	return ret
end
