function onLogout(cid)
	if getPlayerStorageValue(cid, "isTraining") == 1 then
		setPlayerStorageValue(cid, "isTraining", 0)
	end
	return true
end