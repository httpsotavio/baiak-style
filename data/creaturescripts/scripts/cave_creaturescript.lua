function onLogin(cid)
	caveExclusiva.checkPlayerLogin(cid)
	registerCreatureEvent(cid, "caveExclusivaDeath")
	return true
end

function onDeath(cid, corpse, deathList)
	if getPlayerStorageValue(cid, caveExclusiva.storages.inCave) > 0 then
		setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
	end
	return true
end