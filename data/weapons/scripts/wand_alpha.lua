w = {
	[1] = {ef = 36, sh = 3, dmg = COMBAT_FIREDAMAGE},
	[2] = {ef = 42, sh = 28, dmg = COMBAT_ICEDAMAGE},
	[3] = {ef = 45, sh = 38, dmg = COMBAT_POISONDAMAGE},
	[4] = {ef = 17, sh = 31, dmg = COMBAT_DEATHDAMAGE},
	[5] = {ef = 11, sh = 35, dmg = COMBAT_ENERGYDAMAGE},
	[6] = {ef = 31, sh = 35, dmg = COMBAT_PHYSICALDAMAGE},
	[7] = {ef = 49, sh = 37, dmg = COMBAT_HOLYDAMAGE}
}

function onUseWeapon(cid, var)
	min, max = 650, 790 -- dano minimo e maximo
	target = getCreatureTarget(cid)
	if target ~= 0 then
		wx = w[math.random(1, #w)]
		doSendDistanceShoot(getThingPos(cid), getThingPos(target), wx.sh)
		addEvent(doAreaCombatHealth, 100, cid, wx.dmg, getThingPos(target), 0, -min, -max, wx.ef)
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
	return true
end
