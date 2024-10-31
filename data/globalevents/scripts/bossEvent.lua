local bossEvent = {
	bossRoom = {{x= 14905, y= 15182, z= 7}, {x= 14945, y= 15192, z= 7}},
	bossMonster = {"Azazel", "Striker Cyclope"},
	teleportPos = {create = {x= 157, y= 45, z= 7}},
}

function onTime()
	if getGlobalStorageValue("bossEvent") == 0 then
		local bossIndex = math.random(#bossEvent.bossMonster)
		local randomBoss = bossEvent.bossMonster[bossIndex]
		local randomPosition = {x = math.random(bossEvent.bossRoom[1].x, bossEvent.bossRoom[2].x), y = math.random(bossEvent.bossRoom[1].y, bossEvent.bossRoom[2].y), z = bossEvent.bossRoom[1].z}
		
		setGlobalStorageValue("bossEvent", randomBoss)
		doCreateMonster(randomBoss, randomPosition)
		doCreateTeleport(1387, randomPosition, bossEvent.teleportPos.create)
		doBroadcastMessage("O portal para a sala do boss abriu.\nO boss sumonado foi: ["..randomBoss.."], venham dete-lo!")
	else
		doBroadcastMessage("O portal da sala do boss ainda está aberto, venha derrotar o boss!")
	end
	return true
end

function onThink(interval, lastExecution)
	if getGlobalStorageValue("bossEvent") ~= 0 then
		doSendMagicEffect(bossEvent.teleportPos.create, CONST_ME_TELEPORT)
		doSendAnimatedText(bossEvent.teleportPos.create, getGlobalStorageValue("bossEvent"), 202)
	end
	return true
end