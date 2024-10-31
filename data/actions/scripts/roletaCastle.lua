local RoletaSlots= {
    Perda = true, -- Se o player vai ter chance de perder.
    playerPos = {x= 3360, y= 276, z= 8},
    Qntd = {2089, 1}, -- Quantidade de cada item necess�rio para ligar a roleta. O primeiro valor � para a quantidade de item e o segundo � para quantidade de item que ser� removido.
    Storage = 534872, -- N�o mexa. Caso queira fazer mais de uma roleta, basta alterar o valor da storage sempre adcionando +1 na ultima casa decimal.
    Item_Perda = 2638, -- ID do item que vai fazer com que o player perca caso seja sorteado. (Esse item precisa existir na tabela Items logo abaixo.)
    Effects = {
        Player = 144, -- Efeito que vai sair do Player caso ele ganhe.
        Premio = 268, -- Efeito que vai sair em cima do Pr�mio caso o Player ganhe.
        Perda = 311, -- Efeito que vai sair em cima do item caso o Player perca.
    },
    Items = { -- Lista dos items que ser�o sorteados
        [1] = {id= 2638, count= 1, chance= 20}, -- Item de Perda
        [2] = {id= 6546, count= 1, chance= 10}, -- Remover Mortes
        [3] = {id= 5802, count= 1, chance= 10}, -- Remover Frags
        [4] = {id= 5468, count= 1, chance= 10}, -- Remover Skull
        [5] = {id= 38008, count= 1, chance= 10}, -- Addon Doll
        [6] = {id= 2453, count= 1, chance= 10}, -- Assault Wand
        [7] = {id= 8925, count= 1, chance= 10}, -- Assault Axe
        [8] = {id= 2444, count= 1, chance= 10}, -- Assault Club
        [9] = {id= 7438, count= 1, chance= 10}, -- Assault Bow
        [10] = {id= 2390, count= 1, chance= 10}, -- Assault Sword
        [11] = {id= 7141, count= 1, chance= 10}, -- Cave Exclusiva
        [12] = {id= 7443, count= 1, chance= 10}, -- Boost Exp
        [13] = {id= 2346, count= 1, chance= 10}, -- Stamina Potion
        [14] = {id= 8601, count= 1, chance= 10}, -- Knight Party
        [15] = {id= 5803, count= 1, chance= 10}, -- Paladin Party
        [16] = {id= 2349, count= 1, chance= 10}, -- Druid Party
        [17] = {id= 2112, count= 1, chance= 10}, -- Sorcerer Party
        [18] = {id= 2154, count= 1, chance= 10}, -- Yellow gem
    },
    Items_Pos = {
        [1] = {x = 3357, y = 274, z = 8}, -- Posi��o da Extremidade Esquerda
        [2] = {x = 3358, y = 274, z = 8}, -- Posi��o Esquerda
        [3] = {x = 3359, y = 274, z = 8}, -- Posi��o Esquerda
        [4] = {x = 3360, y = 274, z = 8}, -- Posi��o do Pr�mio (Meio)
        [5] = {x = 3361, y = 274, z = 8}, -- Posi��o Direita
        [6] = {x = 3362, y = 274, z = 8}, -- Posi��o Direita
        [7] = {x = 3363, y = 274, z = 8} -- Posi��o da Extremidade Direita
    },
}

--[[ N�o Mexa ]]--
local slot1, slot2, slot3, slot4, slot5, slot6, slot7
local function cleanTile(item, i)
    doCleanTile(RoletaSlots.Items_Pos[i], true)
    doCreateItem(item, 1, RoletaSlots.Items_Pos[i])
end

local function resetSlots()
    slot1, slot2, slot3, slot4, slot5, slot6, slot7 = nil, nil, nil, nil, nil, nil, nil
end

local function raffle(item)
    if slot6 ~= nil then
        slot7 = slot6
        cleanTile(2623, 7)
        doCreateItem(slot7.id, slot7.count, RoletaSlots.Items_Pos[7])
    end
    if slot5 ~= nil then
        slot6 = slot5
        cleanTile(2619, 6)
        doCreateItem(slot6.id, slot6.count, RoletaSlots.Items_Pos[6])
    end
    if slot4 ~= nil then
        slot5 = slot4
        cleanTile(2612, 5)
        doCreateItem(slot5.id, slot5.count, RoletaSlots.Items_Pos[5])
    end
    if slot3 ~= nil then
        slot4 = slot3
        cleanTile(10968, 4)
        doCreateItem(slot4.id, slot4.count, RoletaSlots.Items_Pos[4])
    end
    if slot2 ~= nil then
        slot3 = slot2
        cleanTile(2623, 3)
        doCreateItem(slot3.id, slot3.count, RoletaSlots.Items_Pos[3])
    end
    if slot1 ~= nil then
        slot2 = slot1
        cleanTile(2619, 2)
        doCreateItem(slot2.id, slot2.count, RoletaSlots.Items_Pos[2])
    end
    slot1 = {id = item.id, count = item.count}
    cleanTile(2612, 1)
    doCreateItem(slot1.id, slot1.count, RoletaSlots.Items_Pos[1])
end

--[[ Mexa apenas nas mensagens ]]--
local function result(uid)
    if isPlayer(uid) then
        if RoletaSlots.Perda and slot4.id == RoletaSlots.Item_Perda then
            doSendMagicEffect(getCreaturePosition(uid), CONST_ME_POFF)
            doSendMagicEffect(RoletaSlots.Items_Pos[4], RoletaSlots.Effects.Perda)
            doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, "[Roleta]: Voc� n�o conseguiu obter nada desta vez.")
        else
            doPlayerAddItem(uid, slot4.id, slot4.count)
            doSendMagicEffect(getCreaturePosition(uid), RoletaSlots.Effects.Player)
            doSendMagicEffect(RoletaSlots.Items_Pos[4], RoletaSlots.Effects.Premio)
            doBroadcastMessage("[Roleta]: O Jogador "..getPlayerName(uid).." acabou de ganhar ["..slot4.count.."] ["..getItemNameById(slot4.id).."] na roleta do Rei.")
        end
        addEvent(function()
            mayNotMove(uid, false)
            setGlobalStorageValue(RoletaSlots.Storage, 0)
            for i = 1, #RoletaSlots.Items_Pos do
                if i == 4 then
                    cleanTile(10968, i)
                else
                    cleanTile(10968, i)
                end
            end
        end, 500)
    end
end

--[[ Mexa apenas nas mensagens ]]--
function onUse(cid, item, fromPosition, itemEx, toPosition)
    if getGlobalStorageValue(RoletaSlots.Storage) ~= 1 then
        local playerPos = getPlayerPosition(cid)
        if playerPos.x ~= RoletaSlots.playerPos.x or playerPos.y ~= RoletaSlots.playerPos.y or playerPos.z ~= RoletaSlots.playerPos.z then
            doSendMagicEffect(playerPos, CONST_ME_POFF)
            return doPlayerSendCancel(cid, "Voc� precisa se posicionar antes.")
        end

        if getPlayerItemCount(cid, RoletaSlots.Qntd[1]) >= RoletaSlots.Qntd[2] then
            doPlayerRemoveItem(cid, RoletaSlots.Qntd[1], RoletaSlots.Qntd[2])
        else
            doSendMagicEffect(playerPos, CONST_ME_POFF)
            return doPlayerSendCancel(cid, "Voc� precisa ter "..RoletaSlots.Qntd[2].." "..getItemNameById(RoletaSlots.Qntd[1]).." em sua backpack.")
        end

        local loop = 0
        local rand = math.random(10, 30)
        for i = 1, #RoletaSlots.Items_Pos do
            if i == 4 then
                cleanTile(10968, i)
            else
                cleanTile(10968, i)
            end
        end

        resetSlots()
        while rand >= loop do
            local roll = math.random(1, 100)
            index = math.random(#RoletaSlots.Items)
            if roll <= RoletaSlots.Items[index].chance then
                local item = RoletaSlots.Items[index]
                loop = loop + 1
                addEvent(raffle, loop * 1000, item)
            end
        end
        addEvent(result, (rand + 2) * 1000, cid)
    else
        return doPlayerSendCancel(cid, "[Roleta]: A roleta j� est� em funcionamento.")
    end
    mayNotMove(cid, true)
    setGlobalStorageValue(RoletaSlots.Storage, 1)
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "[Roleta]: Voc� acabou de ligar a roleta.")
    doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)
    return true
end