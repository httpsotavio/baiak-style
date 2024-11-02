local cfg = {
	
	["the energy boss"] = {topos = {x = 4222, y = 112, z = 15}, createpos = {x = 4220, y = 56, z = 15}},
    ["the fire boss"] = {topos = {x = 4163, y = 461, z = 14}, createpos = {x = 4188, y = 125, z = 14}},
    ["giant frost lord"] = {topos = {x = 4721, y = 57, z = 15}, createpos = {x = 4591, y = 152, z = 15}},
    ["hellish ghalapago"] = {topos = {x = 4584, y = 184, z = 15}, createpos = {x = 4553, y = 158, z = 15}},
    ["the death boss"] = {topos = {x = 4266, y = 60, z = 14}, createpos = {x = 4514, y = 397, z = 15}},

}

local function removeTeleport(pos)
	local tp = getTileItemById(pos,1387)
	if tp and tp.uid > 0 then
		doRemoveItem(tp.uid)
	end
end

function onDeath(cid, corpse, deathList)
local nme = getCreatureName(cid):lower()

    if cfg[nme] then
    	doCreateTeleport(1387,cfg[nme].topos, cfg[nme].createpos)
        --Events:sendTeleportCountdown(cfg[nme].createpos, 60)
    	addEvent(removeTeleport,60000,cfg[nme].createpos)
    	doCreatureSay(cid,"O teleport abriu e vai sumir em 1 minuto",TALKTYPE_ORANGE_1)
    end
    return true
end
    