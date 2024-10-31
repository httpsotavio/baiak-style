local positions = {
	{x = 744, y = 40, z = 6},
	{x = 744, y = 41, z = 6},
	{x = 744, y = 42, z = 6},
	{x = 744, y = 43, z = 6},
	{x = 744, y = 44, z = 6},
	{x = 743, y = 40, z = 6},
	{x = 743, y = 41, z = 6},
	{x = 743, y = 42, z = 6},
	{x = 743, y = 43, z = 6},
	{x = 743, y = 44, z = 6},
	{x = 743, y = 45, z = 6},
	{x = 742, y = 42, z = 6},
	{x = 742, y = 43, z = 6},
	{x = 742, y = 44, z = 6},
	{x = 742, y = 45, z = 6},
	{x = 742, y = 46, z = 6}
}

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
doTeleportThing(cid, positions[math.random(1, #positions)])
return true
end