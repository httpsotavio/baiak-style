function onThink(interval, lastExecution)
  -- Configurações
    local cor = 20 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Frags skull:
Red skull = 100 frags no dia
Black skull = Sem limites]]
}

  -- Fim de Configurações

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end