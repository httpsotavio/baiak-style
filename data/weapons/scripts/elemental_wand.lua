local min, max = 700, 775
local storage = 722656

local function getMinDamage(level, magLevel)
	local min = ((level * 1.05) + (magLevel * 1.00))
	local naturalDamage = math.random(-30,45)
	min = min + naturalDamage
	if min < 700 then
		min = 700
	end
	return math.floor(min)
end

local function getMaxDamage(level, magLevel)
	local max = ((level * 1.05) + (magLevel * 1.00))
	local naturalDamage = math.random(-20,45)
	max = max + naturalDamage
	if max < 775 then
		max = 775
	end
	return math.ceil(max)
end

local effects = {
	
	[10] = {dist = CONST_ANI_ICE, hit = CONST_ME_ICEATTACK, dmg = COMBAT_ICEDAMAGE},
	[11] = {dist = CONST_ANI_EARTH, hit = CONST_ME_CARNIPHILA, dmg = COMBAT_POISONDAMAGE},
	[12] = {dist = CONST_ANI_HOLY, hit = CONST_ME_HOLYDAMAGE, dmg = COMBAT_HOLYDAMAGE},
	[13] = {dist = CONST_ANI_ENERGYBALL, hit = CONST_ME_PURPLEENERGY, dmg = COMBAT_ENERGYDAMAGE},
	[14] = {dist = CONST_ANI_CAKE, hit = CONST_ME_CAKE, dmg = COMBAT_DROWNDAMAGE},
	[15] = {dist = CONST_ANI_FIRE, hit = CONST_ME_FIREATTACK, dmg = COMBAT_FIREDAMAGE},
	[16] = {dist = CONST_ANI_SUDDENDEATH, hit = CONST_ME_MORTAREA, dmg = COMBAT_DEATHDAMAGE}

}

function onUseWeapon(cid, var)
	local level, magLevel = getPlayerLevel(cid), getPlayerMagLevel(cid)
	local min, max = getMinDamage(level, magLevel), getMaxDamage(level, magLevel)

	local sto = getCreatureStorage(cid, storage)
	if not effects[sto] then
		sto = 12;
	end
	
	local target = variantToNumber(var)
	if isCreature(target) then
		doSendDistanceShoot(getThingPos(cid), getThingPos(target), effects[sto].dist)
		doAreaCombatHealth(cid, effects[sto].dmg, getThingPos(target), 0, -min, -max, effects[sto].hit)
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
