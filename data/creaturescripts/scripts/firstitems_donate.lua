function onLogin(cid)
	if not isPlayer(cid) then return true end
	if getPlayerGroupId(cid) == 1 and getPlayerStorageValue(cid, 30001) == -1 then
		if isSorcerer(cid) then
			local bag = doPlayerAddItem(cid, 7739, 1) -- Donate Backpack
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 11253, 1) -- Aura
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 5952, 1) -- Outfit Vip
			doAddContainerItem(bag, 1954, 1) -- Promote Tp
			doAddContainerItem(bag, 6527, 500) -- Event Coin
			doAddContainerItem(bag, 11138, 1) -- Donate Doll
			doAddContainerItem(bag, 9971, 500) -- Gold Ingot
			doAddContainerItem(bag, 12575, 100) -- Dodge Stone
			doAddContainerItem(bag, 12396, 100) -- Critical Stone
			doAddContainerItem(bag, 7590, 1) -- Great Mana Potion
			doAddContainerItem(bag, 6574, 1) -- Chocolate dos Deuses

			doPlayerAddItem(cid, 12641, 1) -- Helmet
			doPlayerAddItem(cid, 12642, 1) -- Armor
			doPlayerAddItem(cid, 12643, 1) -- Legs
			doPlayerAddItem(cid, 12644, 1) -- Boots
			doPlayerAddItem(cid, 12645, 1) -- Shield
			doPlayerAddItem(cid, 12661, 1) -- Wand
			doPlayerAddItem(cid, 12658, 1) -- Ring
			doPlayerAddItem(cid, 2131, 1) -- Colar
			doPlayerAddItem(cid, 12608, 1) -- Cursed

			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isDruid(cid) then
			local bag = doPlayerAddItem(cid, 7739, 1) -- Donate Backpack
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 11253, 1) -- Aura
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 5952, 1) -- Outfit Vip
			doAddContainerItem(bag, 1954, 1) -- Promote Tp
			doAddContainerItem(bag, 6527, 500) -- Event Coin
			doAddContainerItem(bag, 11138, 1) -- Donate Doll
			doAddContainerItem(bag, 9971, 500) -- Gold Ingot
			doAddContainerItem(bag, 12575, 100) -- Dodge Stone
			doAddContainerItem(bag, 12396, 100) -- Critical Stone
			doAddContainerItem(bag, 7590, 1) -- Great Mana Potion
			doAddContainerItem(bag, 6574, 1) -- Chocolate dos Deuses

			doPlayerAddItem(cid, 12641, 1) -- Helmet
			doPlayerAddItem(cid, 12642, 1) -- Armor
			doPlayerAddItem(cid, 12643, 1) -- Legs
			doPlayerAddItem(cid, 12644, 1) -- Boots
			doPlayerAddItem(cid, 12645, 1) -- Shield
			doPlayerAddItem(cid, 12661, 1) -- Wand
			doPlayerAddItem(cid, 12658, 1) -- Ring
			doPlayerAddItem(cid, 2131, 1) -- Colar
			doPlayerAddItem(cid, 12608, 1) -- Cursed

			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isPaladin(cid) then
			local bag = doPlayerAddItem(cid, 7739, 1) -- Donate Backpack
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 11253, 1) -- Aura
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 5952, 1) -- Outfit Vip
			doAddContainerItem(bag, 1954, 1) -- Promote Tp
			doAddContainerItem(bag, 6527, 500) -- Event Coin
			doAddContainerItem(bag, 11138, 1) -- Donate Doll
			doAddContainerItem(bag, 9971, 500) -- Gold Ingot
			doAddContainerItem(bag, 12575, 100) -- Dodge Stone
			doAddContainerItem(bag, 12396, 100) -- Critical Stone
			doAddContainerItem(bag, 8472, 1) -- Great Spirit Mana
			doAddContainerItem(bag, 6574, 1) -- Chocolate dos Deuses

			doPlayerAddItem(cid, 6096, 1) -- Helmet
            doPlayerAddItem(cid, 6095, 1) -- Armor
			doPlayerAddItem(cid, 5918, 1) -- Legs
			doPlayerAddItem(cid, 5462, 1) -- Boots
			doPlayerAddItem(cid, 2527, 1) -- Shield
			doPlayerAddItem(cid, 12621, 1) -- Bow
			doPlayerAddItem(cid, 6300, 1) -- Ring
			doPlayerAddItem(cid, 2131, 1) -- Colar
			doPlayerAddItem(cid, 12608, 1) -- Cursed

			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isKnight(cid) then
			local bag = doPlayerAddItem(cid, 7739, 1) -- Donate Backpack
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 7437, 1) -- Club
			doAddContainerItem(bag, 11253, 1) -- Aura
			doAddContainerItem(bag, 7391, 1) -- Sword
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 5952, 1) -- Outfit Vip
			doAddContainerItem(bag, 1954, 1) -- Promote Tp
			doAddContainerItem(bag, 7620, 1) -- Mana Potion
			doAddContainerItem(bag, 6527, 500) -- Event Coin
			doAddContainerItem(bag, 11138, 1) -- Donate Doll
			doAddContainerItem(bag, 9971, 500) -- Gold Ingot
			doAddContainerItem(bag, 12575, 100) -- Dodge Stone
			doAddContainerItem(bag, 12396, 100) -- Critical Stone
			doAddContainerItem(bag, 8472, 1) -- Great Spirit Mana
			doAddContainerItem(bag, 6574, 1) -- Chocolate dos Deuses
			doAddContainerItem(bag, 8473, 1) -- Ultimate Health Potion

			doPlayerAddItem(cid, 2501, 1) -- Helmet
            doPlayerAddItem(cid, 2503, 1) -- Armor
			doPlayerAddItem(cid, 2504, 1) -- Legs
			doPlayerAddItem(cid, 12649, 1) -- Boots
	        doPlayerAddItem(cid, 8906, 1) -- Shield
		    doPlayerAddItem(cid, 7456, 1) -- Axe
			doPlayerAddItem(cid, 12659, 1) -- Ring
			doPlayerAddItem(cid, 2131, 1) -- Colar
			doPlayerAddItem(cid, 12608, 1) -- Cursed

			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa
		end
	end
 	return TRUE
end