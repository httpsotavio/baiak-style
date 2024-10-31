local positions = {
	{x = 158, y = 47, z = 7},
	{x = 159, y = 47, z = 7},
	{x = 160, y = 47, z = 7},
	{x = 160, y = 48, z = 7},
	{x = 160, y = 49, z = 7},
	{x = 159, y = 49, z = 7},
	{x = 158, y = 49, z = 7},
	{x = 158, y = 48, z = 7},
	{x = 157, y = 46, z = 7},
	{x = 158, y = 46, z = 7},
	{x = 159, y = 46, z = 7},
	{x = 160, y = 46, z = 7},
	{x = 161, y = 47, z = 7},
	{x = 161, y = 48, z = 7},
	{x = 161, y = 49, z = 7},
	{x = 161, y = 50, z = 7},
	{x = 160, y = 50, z = 7},
	{x = 159, y = 50, z = 7},
	{x = 158, y = 50, z = 7},
	{x = 157, y = 50, z = 7},
	{x = 157, y = 49, z = 7},
	{x = 157, y = 48, z = 7},
	{x = 157, y = 47, z = 7},
}

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
doTeleportThing(cid, positions[math.random(1, #positions)])
return true
end