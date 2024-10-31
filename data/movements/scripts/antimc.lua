local function ipExists(toPos, fromPos)
	local ip = {}
    local players = getPlayersInArea(toPos, fromPos)
    if players then
        for _, player in ipairs(players) do
        	table.insert(ip, getPlayerIp(player))
            local playerIP = getPlayerIp(player)
            if playerIP == ip then
                return true
            end
        end
    end
end

local configAntiMC = {
	kick = false, temple = true,
	areas = {
		[1] = {{x = 3520, y = 223, z = 14}, {x = 3549, y = 254, z = 14}}, -- Castle 24H Andar 1
		[2] = {{x = 3532, y = 236, z = 13}, {x = 3549, y = 252, z = 13}}, -- Castle 24H Andar 2
		[3] = {{x = 3530, y = 242, z = 15}, {x = 3579, y = 299, z = 15}}, -- Castle 24H Andar 3
		[4] = {{x = 3328, y = 306, z = 9}, {x = 3392, y = 353, z = 9}}, -- Castle 48H
		[6] = {{x = 14769, y = 15024, z = 7}, {x = 14785, y = 15038, z = 7}}, -- Evento Dice
	}
}

function onStepIn(cid, item, toPosition, fromPosition)
	for _, config in pairs(configAntiMC.areas) do
		if ipExists(config[1], config[2]) then
			doTeleportThing(cid, fromPosition)
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
			doPlayerSendCancel(cid, "Não é possível entrar nesta área com este IP.")
			return false
		end
	end
    return true
end
