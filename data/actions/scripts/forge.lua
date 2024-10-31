function onUse(cid, item, fromPosition, itemEx, toPosition)
	local message = exaltationForge.message
	local accessTable = exaltationForge[item.actionid]
	if accessTable then
		local playerPos = getPlayerPosition(cid)
		if (playerPos.x ~= accessTable.playerPos.x or playerPos.y ~= accessTable.playerPos.y or playerPos.z ~= accessTable.playerPos.z) then
			doSendMagicEffect(playerPos, CONST_ME_POFF, cid)
			doSendMagicEffect(accessTable.playerPos, 37, cid)
			doSendAnimatedText(accessTable.playerPos, "Pise", 198, cid)
			doPlayerSendCancel(cid, "Você precisa se posicionar antes.")
			return true
		end

		local container = getTileItemById(accessTable.containerPos, exaltationForge.container)
		if (isContainer(container.uid)) then
			local slot = getContainerSize(container.uid)
			if slot < 2 then
				doSendMagicEffect(playerPos, CONST_ME_POFF, cid)
				doPlayerSendCancel(cid, message.needitems)
				return true
			end

			local firstItem = getContainerItem(container.uid, 0)
			local secondItem = getContainerItem(container.uid, 1)
			if (firstItem.id ~= secondItem.id) then
            	doSendMagicEffect(playerPos, CONST_ME_POFF, cid)
            	doPlayerSendCancel(cid, message.itemsdifferent)
				return true
			end

			if (not isEquipment(firstItem.uid) or not isEquipment(secondItem.uid)) then
				doSendMagicEffect(playerPos, CONST_ME_POFF)
				doPlayerSendCancel(cid, message.notupgradeable:format(getItemNameById(firstItem.id)))
				return true
			end
			
			if (getItemTier(firstItem.uid) ~= getItemTier(secondItem.uid)) then
				doSendMagicEffect(playerPos, CONST_ME_POFF, cid)
				doPlayerSendCancel(cid, message.tierdifferent)
				return true
			end

			local oldItemTier = getItemTier(firstItem.uid)
			if (not exaltationForge.forgeLevel[oldItemTier + 1]) then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, message.toolrange)
				doSendMagicEffect(playerPos, CONST_ME_POFF, cid)
				return true
			end

			local randomChance = math.random(1,100)
			local itemChance = exaltationForge.forgeLevel[oldItemTier]
			if (itemChance >= randomChance) then
				doRemoveItem(secondItem.uid)
				setItemTier(firstItem.uid, oldItemTier + 1)
				doItemSetAttribute(firstItem.uid, "name", string.format("+[%s] %s", getItemTier(firstItem.uid), getItemNameById(firstItem.id)))
				doSendMagicEffect(getPlayerPosition(cid), 36)
				if (exaltationForge.forgeLevel[oldItemTier + 2]) then
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, message.success:format(getItemNameById(firstItem.id), (getItemTier(firstItem.uid)), exaltationForge.forgeLevel[oldItemTier + 1]))
				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, message.successMaxLevel:format(getItemNameById(firstItem.id), getItemTier(firstItem.uid)))
				end
				for key, value in pairs(exaltationForge.attributes) do
					local oldVal = getItemAttribute(firstItem.uid, key)
					if (oldVal == nil) then oldVal = 0 end
					doItemSetAttribute(firstItem.uid, key, value + oldVal)
				end
			else
				doRemoveItem(secondItem.uid)
				if getItemTier(firstItem.uid) >= 1 then
					setItemTier(firstItem.uid, oldItemTier - 1)
					doItemSetAttribute(firstItem.uid, "name", string.format("+[%s] %s", getItemTier(firstItem.uid), getItemNameById(firstItem.id)))
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, message.downgrade:format(getItemNameById(firstItem.id), (getItemTier(firstItem.uid))))
					for key, value in pairs(exaltationForge.attributes) do
						if getItemAttribute(firstItem.uid, key) ~= nil then
							doItemSetAttribute(firstItem.uid, key, getItemAttribute(firstItem.uid, key) - value)
						end
					end
				end
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, message.fail)
			end
		end
	end
	return doTransformItem(item.uid, item.itemid % 2 == 1 and item.itemid+1 or item.itemid-1)
end