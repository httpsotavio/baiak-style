	local updatel = {x = 152, y = 73, z = 15}

function onStepIn(cid, item, position, fromPosition)
doTeleportThing(cid, updatel)
doPlayerSendCancel(cid,"Veja como usar o sistema na pagina War Entrosa em nosso website www.baiak-frost.com!")
return TRUE
end