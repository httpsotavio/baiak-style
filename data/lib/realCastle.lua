realCastle = {
	open_storage = 722374,
	guild_storage = 722375,
	date_storages = {722376,722377,722378},
	frompos = {x = 3308, y = 251, z = 9},
	topos = {x = 3412, y = 371, z = 9},
	dominanceStorage = 9941742,
}

function realCastle.getAlmostDominantGuild()
	local query = db.getResult("SELECT `id` FROM `guilds` ORDER BY `dominationTime` DESC LIMIT 1")
	if (query:getID() ~= -1) then
		local gid = query:getDataInt("id")
		return {gid = gid}
	end
	return 0
end


function realCastle.clearGuildTimes()
	db.executeQuery("UPDATE `guilds` SET  `dominationTime` = 0;")
end

function realCastle.countDominance(guildid)
	if (getGlobalStorageValue(realCastle.guild_storage) == guildid) then
		local cacheTime = getGlobalStorageValue(realCastle.dominanceStorage)
		setGlobalStorageValue(realCastle.dominanceStorage, cacheTime + 1)
		addEvent(function()
			realCastle.countDominance(guildid)
		end, 1000)
	end
end

function realCastle.clearCacheTime()
	setGlobalStorageValue(realCastle.dominanceStorage, 0)
end

function realCastle.getCacheDominanceTime(guildId)
	if (getGlobalStorageValue(realCastle.guild_storage) == guildId) then
		return getGlobalStorageValue(realCastle.dominanceStorage)
	end
	return 0
end

function realCastle.getDominanceTime(guildId)
	local val = 0
	local query = db.getResult("SELECT `dominationTime` FROM `guilds` WHERE `id` = '".. guildId.."';")
	if (query:getID() ~= -1) then
		local dTime = query:getDataInt("dominationTime")
		if (dTime <= 0) then return 0 end
		val = val + dTime
	end
	return val
end

function realCastle.save()
	local guildId = getGlobalStorageValue(realCastle.guild_storage)
	local dominationTime = getGlobalStorageValue(realCastle.dominanceStorage)
	if (guildId > 0 and dominationTime > 0) then
		db.executeQuery("UPDATE `guilds` SET `dominationTime` = `dominationTime` + '"..dominationTime.."' WHERE `id` = '" ..guildId.."';")
	end
end

realCastle.removePlayers = function()
	local castle_area = getPlayersInArea(realCastle.frompos,realCastle.topos)
	if castle_area then
		for _, pid in pairs(castle_area) do
			doTeleportThing(pid,getTownTemplePosition(1))
			doPlayerPopupFYI(pid,"O domínio de sua guild sobre o castelo acabou e uma nova batalha está se iniciando.")
		end
	end
end

realCastle.open = function()
	realCastle.clearCacheTime()
	realCastle.clearGuildTimes()
	setGlobalStorageValue(realCastle.open_storage, 1)
	setGlobalStorageValue(realCastle.guild_storage, 0)
	realCastle.removePlayers()
end

realCastle.close = function()
	realCastle.save()
	setGlobalStorageValue(realCastle.open_storage, -1)
	setGlobalStorageValue(realCastle.guild_storage, 0)
	realCastle.clearCacheTime()
	local players = getPlayersInArea({x = 3328, y = 306, z = 9}, {x = 3392, y = 353, z = 9})
	if players then
		for _, pid in pairs(players) do
			if realCastle.isDominating(pid) then
				doPlayerAddItem(pid, 2089, 1)
			end
			doTeleportThing(pid,getTownTemplePosition(1))
		end
	end
	local winnerGuild = realCastle.getAlmostDominantGuild()
	if (winnerGuild == 0) then
		doBroadcastMessage("[Guild War] A batalha terminou e nenhuma guild dominou o castelo! Amanhã às 21:00 vocês podem tentar novamente!")
		return true
	end
	if realCastle.getDominanceTime(winnerGuild.gid) > 1 then
		db.executeQuery("UPDATE `guilds` SET  `real_castle` = REPLACE(`real_castle`, 1, 0);")
		db.executeQuery("UPDATE `guilds` SET `real_castle` = 1 WHERE `id` = '" .. winnerGuild.gid .."';")
		doBroadcastMessage("[Guild War] A batalha terminou e a guild vencedora foi ["..getGuildNameByID(winnerGuild.gid).."], que dominou o castelo pelo total de "..realCastle.getDominanceTime(winnerGuild.gid).." segundos!")
		setGlobalStorageValue(realCastle.dominanceStorage, 0)
		doSaveServer()
	else
		doBroadcastMessage("[Guild War] A batalha terminou e nenhuma guild dominou o castelo! Amanhã às 21:00 vocês podem tentar novamente!")
		return true
	end
end

realCastle.broadcast = function(message)
	local players = getPlayersInArea(realCastle.frompos, realCastle.topos)
	if players then
		for _, pid in pairs(players) do
			doPlayerSendTextMessage(pid,MESSAGE_STATUS_WARNING,message)
		end
	end
end

realCastle.domain = function(cid)
	realCastle.save()
	local guild_id = getPlayerGuildId(cid)
	setGlobalStorageValue(realCastle.guild_storage, guild_id)
	realCastle.clearCacheTime()
	realCastle.countDominance(guild_id)
	realCastle.broadcast("[Guild War] O jogador "..getPlayerName(cid).." da guild ["..getPlayerGuildName(cid).."] dominou o castelo! " .."O atual tempo de dominância da guild é de "..realCastle.getDominanceTime(guild_id).." segundo(s).")
end

realCastle.isCacheDominating = function(guildid)
	if (getGlobalStorageValue(realCastle.guild_storage) == guildid) then return true end
	return false
end

realCastle.isDominating = function(cid)
	if (getPlayerGroupId(cid) > 3) then return true end
	local guild_id = getPlayerGuildId(cid)
	local query = db.getResult("SELECT `id` FROM `guilds` WHERE `real_castle` = 1;")
	if (query:getID() ~= -1) then
		local gid = query:getDataInt("id")
		return guild_id == gid
	end
	setGlobalStorageValue(realCastle.guild_storage, guild_id)
	return false
end

realCastle.isOpen = function()
	return getGlobalStorageValue(realCastle.open_storage) == 1
end