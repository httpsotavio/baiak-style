function onThink(interval, lastExecution)
  -- Configura��es
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Est� preso?
Sem sa�da??
Pregui�a de andar? 
D� um teleportez�o, se liga:
!tp templo, !tp depot, !tp trainer]]
}

  -- Fim de Configura��es

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end