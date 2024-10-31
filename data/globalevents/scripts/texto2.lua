local config = {
    positions = {

		["voltar"] = { x = , y = , z = 7 },
	},

	itens = {
		{pos = {x = , y = 42, z = 7}, text=""},
		{pos = {x = , y = 42, z = 7}, text=""},
		{pos = {x = , y = 42, z = 7}, text=""},
		{pos = {x = , y = 42, z = 7}, text=""},
		{pos = {x = , y = 51, z = 7}, text=""},
    }
}

function onThink(cid, interval, lastExecution)
	doSendDistanceShoot({x = 159, y = 48, z = 7}, {x = 156, y = 45, z = 7}, 31)
	doSendDistanceShoot({x = , y = , z = 7}, {x = , y = , z = 7}, 31)
	doSendDistanceShoot({x = , y = , z = 7}, {x = , y = 55, z = 7}, 30)
	doSendDistanceShoot({x = , y = 53, z = 7}, {x = , y = 55, z = 7}, 41)
	doSendDistanceShoot({x = , y = 55, z = 7}, {x = , y = 53, z = 7}, 27)
	doSendDistanceShoot({x = , y = 55, z = 7}, {x = , y = 53, z = 7}, 26)
	for _, text in next, config.itens do
		local color = text.color or 204
		doSendAnimatedText(text.pos,text.text,color)
	end
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, 31)
    end
    return true
end  
