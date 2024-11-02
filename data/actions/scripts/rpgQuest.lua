local blood1 = {x = 4633, y = 159, z = 15}
local blood2 = {x = 4630, y = 162, z = 15}
local poison1 = {x = 4636, y = 162, z = 15}
local poison2 = {x = 4633, y = 165, z = 15}

local function removeTeleport()
	local tp = getTileItemById({x = 4633, y = 160, z = 15},1387)
	if tp and tp.uid and tp.uid > 0 then
		doRemoveItem(tp.uid)
	end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local rat1 = getTileItemById(blood1,2813)
	local rat2 = getTileItemById(blood2,2813)
	local scorpion1 = getTileItemById(poison1,2897)
	local scorpion2 = getTileItemById(poison2,2897)
	if getGlobalStorageValue(722535) < os.time() then
		if rat1 and rat1.uid and rat1.uid > 0 and rat2 and rat2.uid and rat2.uid > 0 and scorpion1 and scorpion1.uid and scorpion1.uid > 0 and scorpion2 and scorpion2.uid and scorpion2.uid > 0 then
			setGlobalStorageValue(722535,os.time()+5)
			doSendMagicEffect(blood1,56)
			doSendMagicEffect(blood2,56)
			doSendMagicEffect(poison1,56)
			doSendMagicEffect(poison2,56)
			doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)
			addEvent(function()
				rat1 = getTileItemById(blood1,2813)
				rat2 = getTileItemById(blood2,2813)
				scorpion1 = getTileItemById(poison1,2897)
				scorpion2 = getTileItemById(poison2,2897)
				doSendMagicEffect({x = 4633, y = 160, z = 15},29)
				doCreateTeleport(1387,{x = 4565, y = 157, z = 15},{x = 4633, y = 160, z = 15})
				addEvent(removeTeleport,200000)
				doSendMagicEffect(poison1,6)
				doSendMagicEffect(poison2,6)
				doSendMagicEffect(blood1,6)
				doSendMagicEffect(blood2,6)
				doRemoveItem(rat1.uid)
				doRemoveItem(rat2.uid)
				doRemoveItem(scorpion1.uid)
				doRemoveItem(scorpion2.uid)
			end,2000)
		else
			doPlayerSendCancel(cid,"Alguma coisa está errada...")
			doCreateMonster("Elder Rat",getThingPos(cid))
			doCreateMonster("Venon Verminor", getThingPos(cid))			
			doCreatureSay(cid,"Grrr",TALKTYPE_MONSTER_SAY)
		end
	else
		doPlayerSendCancel(cid,"Aguarde...")
	end
	return true
end
