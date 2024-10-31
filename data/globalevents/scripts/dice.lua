local config = {
    npc_name = "Dice Event", -- Nome do Npc XML
    pos_respawn_npc = {x=14774,y=15026,z=7}, -- Posicao aonde o Npc vai ser criado quando o evento começar
    pos_create_teleport= {x=156,y=48,z=7,stackpos=2}, -- Posicao do Teleport quando evento começar
    pos_to_teleport = {x=14770,y=15025,z=7}, -- Para onde o teleport irá levar
    time = 7, -- Duracao do evento em minutos
    msg_start = "O Evento Dice iniciou, ficará aberto por 7 minutos!", -- Mensagem quando o evento começar
    msg_finish = "O Evento Dice encerrou!", -- Mensagem quando o evento acabar
}

function onTime()
    if not isCreature(config.pos_respawn_npc) then
        doCreateNpc(config.npc_name, config.pos_respawn_npc)
    end

    doBroadcastMessage(config.msg_start)
    doSendMagicEffect(config.pos_create_teleport, 10)
    doCreateTeleport(1387, config.pos_to_teleport, config.pos_create_teleport)

    addEvent(function()
        if getTileItemById({x= 14770, y= 15026, z= 7}, 3615).uid >= 1 then
            doSendMagicEffect({x= 14770, y= 15026, z= 7}, 10)
            doRemoveItem(getTileItemById({x= 14770, y= 15026, z= 7}, 3615).uid, 1)
        end
    end, 500)

    addEvent(function()
        doBroadcastMessage(config.msg_finish)
        local npc = getTopCreature(config.pos_respawn_npc).uid
        doRemoveCreature(npc)

        if getTileItemById(config.pos_create_teleport, 1387).uid >= 1 then
            doSendMagicEffect(config.pos_create_teleport, 10)
            doRemoveItem(getTileItemById(config.pos_create_teleport, 1387).uid, 1)
        else
            doSendMagicEffect({x= 14770, y= 15026, z= 7}, 10)
            doCreateItem(3615, 1, {x= 14770, y= 15026, z= 7})
        end
    end, 1000 * 60 * config.time)
    return true
end