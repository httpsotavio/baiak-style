local config = {
positions = {
["1"] = {x = 2321, y = 481, z = 7},
["2"] = {x = 2324, y = 481, z = 7},
["3"] = {x = 2327, y = 481, z = 7},
["4"] = {x = 2330, y = 481, z = 7},
["5"] = {x = 2333, y = 481, z = 7},
["6"] = {x = 2336, y = 481, z = 7},
["7"] = {x = 2339, y = 481, z = 7},
["8"] = {x = 2342, y = 481, z = 7},
["9"] = {x = 2345, y = 481, z = 7},

["10"] = {x = 2321, y = 489, z = 7},
["11"] = {x = 2324, y = 489, z = 7},
["12"] = {x = 2327, y = 489, z = 7},
["13"] = {x = 2330, y = 489, z = 7},
["14"] = {x = 2333, y = 489, z = 7},
["15"] = {x = 2336, y = 489, z = 7},
["16"] = {x = 2339, y = 489, z = 7},
["17"] = {x = 2342, y = 489, z = 7},
["18"] = {x = 2345, y = 489, z = 7},

-- Pedras
["1 "] = {x = 2322, y = 482, z = 7},
["2 "] = {x = 2325, y = 482, z = 7},
["3 "] = {x = 2328, y = 482, z = 7},
["4 "] = {x = 2331, y = 482, z = 7},
["5 "] = {x = 2334, y = 482, z = 7},
["6 "] = {x = 2337, y = 482, z = 7},
["7 "] = {x = 2340, y = 482, z = 7},
["8 "] = {x = 2343, y = 482, z = 7},
["9 "] = {x = 2346, y = 482, z = 7},

["10 "] = {x = 2322, y = 488, z = 7},
["11 "] = {x = 2325, y = 488, z = 7},
["12 "] = {x = 2328, y = 488, z = 7},
["13 "] = {x = 2331, y = 488, z = 7},
["14 "] = {x = 2334, y = 488, z = 7},
["15 "] = {x = 2337, y = 488, z = 7},
["16 "] = {x = 2340, y = 488, z = 7},
["17 "] = {x = 2343, y = 488, z = 7},
["18 "] = {x = 2346, y = 488, z = 7},

}
}

function onThink(cid, interval, lastExecution)
for text, pos in pairs(config.positions) do
doSendAnimatedText(pos, text, 202)
end

return TRUE
end 
