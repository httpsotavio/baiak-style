function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor) 
	local tpos = {x=3360,y=301,z=9} -- {x=1,y=1,z=1} is the position you teleport to
	if (isPlayer(cid)) then
		if (not realCastle.isDominating(cid)) then
			doTeleportThing(cid, tpos)
		end
	end

	return true 
end