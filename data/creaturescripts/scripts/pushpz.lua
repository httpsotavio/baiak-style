function onPush(cid, target)
	if getPlayerAccess(cid) > 4 then
	return true
	else
    if getTilePzInfo(getThingPos(cid)) or getTilePzInfo(getThingPos(target)) then
		doPlayerSendCancel(cid, "Voc� n�o pode empurrar players em protection zone.")
        return false
		end
    end
	return true
end