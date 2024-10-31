caveExclusiva = {
	config = {
		timeUse = 15, -- Tempo em horas para poder usar a Cave Exclusiva novamente.
		rentTime = 10800,
		-- rentTime = 180 * 60, -- 180 3 Horas
		buyItemID = 11720,
		caveStats = true,
		timeLeftMessageInCave = "Seu tempo de cave exclusiva acabou.", -- Mensagem quando acabar o tempo e o player estiver dentro da cave
		signs = {
			useSigns = true,
			signID = 1815,
			signLook = "Esta cave pertence a %s, estará livre novamente em %s."	-- 1° [%s] = Variavel para nome do player, 2° [%s] = Variavel para horário em que estara livre novamente
		},
		prefixStorageTime = 10002,
	},

	caves = {
		[9851] = {
			gStor = 7330,
			caveName = "Spider Fiery",
			enterPos = {x=2600, y=261, z=15},
			signPos = {x=2317, y=444, z=7}
		},
		[9852] = {
			gStor = 7331,
			caveName = "Triple Medusa",
			enterPos = {x=2598, y=363, z=15},
			signPos = {x=2321, y=444, z=7}
		},
		[9853] = {
			gStor = 7332,
			caveName = "Toad Turtle",
			enterPos = {x=2596, y=446, z=15},
			signPos = {x=2325, y=444, z=7}
		},
		[9854] = {
			gStor = 7333,
			caveName = "Sea Serpent Ice",
			enterPos = {x=2594, y=539, z=15},
			signPos = {x=2329, y=444, z=7}
		},
		[9855] = {
			gStor = 7334,
			caveName = "Undead Darkshadow",
			enterPos = {x=2591, y=625, z=15},
			signPos = {x=2333, y=444, z=7}
		},
		[9856] = {
			gStor = 7335,
			caveName = "Spider Fiery",
			enterPos = {x=2766, y=445, z=15},
			signPos = {x=2337, y=444, z=7}
		},
		[9857] = {
			gStor = 7336,
			caveName = "Triple Medusa",
			enterPos = {x=2765, y=535, z=15},
			signPos = {x=2340, y=444, z=7}
		},
		[9858] = {
			gStor = 7337,
			caveName = "Toad Turtle",
			enterPos = {x=2763, y=620, z=15},
			signPos = {x=2343, y=444, z=7}
		},
		[9859] = {
			gStor = 7338,
			caveName = "Sea Serpent Ice",
			enterPos = {x=2942, y=441, z=15},
			signPos = {x=2346, y=444, z=7}
		},
		-- Metade
		[9860] = {
			gStor = 7339,
			caveName = "Mini Serpent Ice",
			enterPos = {x=2063, y=414, z=15},
			signPos = {x=2317, y=455, z=7}
		},
		[9861] = {
			gStor = 7340,
			caveName = "Magician Mage",
			enterPos = {x=2941, y=621, z=15},
			signPos = {x=2321, y=455, z=7}
		},
		[9862] = {
			gStor = 7341,
			caveName = "Baylor",
			enterPos = {x=2761, y=710, z=15},
			signPos = {x=2325, y=455, z=7}
		},
		[9863] = {
			gStor = 7342,
			caveName = "Haunter",
			enterPos = {x=2761, y=795, z=15},
			signPos = {x=2329, y=455, z=7}
		},
		[9864] = {
			gStor = 7343,
			caveName = "Earth Kelpie",
			enterPos = {x=2934, y=709, z=15},
			signPos = {x=2333, y=455, z=7}
		},
		[9865] = {
			gStor = 7344,
			caveName = "Toad Turtle",
			enterPos = {x=2934, y=796, z=15},
			signPos = {x=2337, y=455, z=7}
		},
		[9866] = {
			gStor = 7345,
			caveName = "Sea Serpent Ice",
			enterPos = {x=3100, y=709, z=15},
			signPos = {x=2340, y=455, z=7}
		},
		[9867] = {
			gStor = 7346,
			caveName = "Spider Fiery",
			enterPos = {x=3099, y=794, z=15},
			signPos = {x=2343, y=455, z=7}
		},
		[9868] = {
			gStor = 7347,
			caveName = "Triple Medusa",
			enterPos = {x=3263, y=750, z=15},
			signPos = {x=2346, y=455, z=7}
		},																									
	},
	

	storages = {
		cave = 35070,
		inCave = 35071,
		time = 35072
	}
}

function caveExclusiva.getCaveOwner(self, cave)
	if (not self.caves[cave]) then return 0 end
	if (tonumber(getGlobalStorageValue(self.caves[cave].gStor)) > 0) then
		return getGlobalStorageValue(self.caves[cave].gStor)
	end
	return 0
end

function caveExclusiva.setPlayerCaveOwner(self, cave, value)
	if (not self.caves[cave]) then return true end
	setGlobalStorageValue(self.caves[cave].gStor, value)
	return true
end

function caveExclusiva.getCaveRemainingTime(self, cave)
	if (not self.caves[cave]) then return 0 end
	if (getGlobalStorageValue(self.config.prefixStorageTime + cave) > 0) then
		return getGlobalStorageValue(self.config.prefixStorageTime + cave) - os.time()
	end
	return 0
end

function caveExclusiva.setCaveRemainingTime(self, cave, time)
	if (not self.caves[cave]) then return true end
	setGlobalStorageValue(self.config.prefixStorageTime + cave, time + os.time())
end

function caveExclusiva.turnPlayerIsInCave(self, player)
	setPlayerStorageValue(player, self.storages.inCave, 1)
	return true
end

function caveExclusiva.playerIsInCave(self, player)
	if (tonumber(getPlayerStorageValue(player, self.storages.inCave)) > 0) then return true end
	return false
end

function caveExclusiva.stripPlayer(self, cid)
	if (caveExclusiva:playerIsInCave(cid)) then
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, self.config.timeLeftMessageInCave)
		setPlayerStorageValue(cid, self.storages.inCave, 0)
	end
	return true
end

function caveExclusiva.check(self)
	for k, v in pairs(self.caves) do
		if (caveExclusiva:getCaveOwner(k) > 0) then
			local caveOwner = caveExclusiva:getCaveOwner(k)
			local remainingTime = caveExclusiva:getCaveRemainingTime(k)
			if (remainingTime <= 0) then
				if (getPlayerByGUID(caveOwner) ~= nil and getPlayerByGUID(caveOwner) > 0) then
					local cid = getPlayerByGUID(caveOwner)
					caveExclusiva:stripPlayer(cid)
					caveExclusiva:turnPlayerCave(cid, 0)
				end
				caveExclusiva:setCaveRemainingTime(k, 0)
				caveExclusiva:setCaveOwner(k, 0)
			end
		end
	end
end

function caveExclusiva.checkPlayerLogin(cid)
	if (caveExclusiva:getPlayerCave(cid) > 0) then
		local cave = caveExclusiva:getPlayerCave(cid)
		if (caveExclusiva.caves[cave] and caveExclusiva:getCaveOwner(cave) == getPlayerGUID(cid) and caveExclusiva:getCaveRemainingTime(cave) > 0) then
			return true
		end
		caveExclusiva:stripPlayer(cid)
		caveExclusiva:turnPlayerCave(cid, 0)
	end
	return true
end

function caveExclusiva.setCaveOwner(self, cave, ownerId)
	if (not self.caves[cave]) then return true end
	if (ownerId ~= 0) then
		caveExclusiva:setCaveRemainingTime(cave, self.config.rentTime)
	end
	caveExclusiva:setPlayerCaveOwner(cave, ownerId)
	return true
end

function caveExclusiva.clearAll(self)
	for k, v in pairs(self.caves) do
		caveExclusiva:setCaveOwner(k, 0)
		caveExclusiva:setCaveRemainingTime(k, 0)
	end
end

function caveExclusiva.turnPlayerCave(self, cid, cave)
	if (isPlayer(cid)) then
		setPlayerStorageValue(cid, self.storages.cave, cave)
	end
	return true
end

function caveExclusiva.getPlayerCave(self, cid)
	if (getPlayerStorageValue(cid, self.storages.cave) > 0) then return getPlayerStorageValue(cid, self.storages.cave) end
	return 0
end