local msg = {
	['20:00:'] = {text = '[Guild War] Às 21:00 o Castle será aberto para invasões. A guild que manter dominado o Castlelo até o termino, receberá por 24hrs 20% a mais de experiência!', type = 21},
	['20:30'] = {text = '[Guild War] Às 21:00 o Castle será aberto para invasões. A guild que manter dominado o Castlelo até o termino, receberá por 24hrs 20% a mais de experiência!', type = 21},
	['20:50'] = {text = '[Guild War] Faltam apenas 10 minutos para o Castle abrir!', type = 21},
	
	['21:00'] = {text = '[Guild War] O Castle está aberto! A guild dominante ganha 20% a mais de experiência e fica com a posse por 24hrs!', type = 21},	
	['21:05'] = {text = '[Guild War] O Castle está aberto! A guild dominante ganha 20% a mais de experiência e fica com a posse por 24hrs!', type = 21},
	['21:10'] = {text = '[Guild War] O Castle está aberto! A guild dominante ganha 20% a mais de experiência e fica com a posse por 24hrs!', type = 21},

	['22:00'] = {text = '[Guild War] O Castle termina em 30 minutos.', type = 21},
	['22:20'] = {text = '[Guild War] O Castle termina em 10 minutos.', type = 21},
}

function onThink(interval, lastExecution)
	local h = msg[os.date('%X'):sub(1, 5)]
	return h and doBroadcastMessage(h.text, h.type) or true
end