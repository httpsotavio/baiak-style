local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local x = 0 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

local randomDice = {
    
 [1] = 5792,
 [2] = 5793,
 [3] = 5794,
 [4] = 5795,
 [5] = 5796,
 [6] = 5797

}

----------------Config----------------------|
local player_teleport = {x=157,y=50,z=7} -- Posicao para onde o player vai ser teleportado quando perder

local rewards = { -- Id dos premios caso o player ganhe

2156, -- Red Gem
7443, -- Boost Exp
38008, -- Addon Doll
2218, -- Paw Amulet
2471, -- Golden Helmet
2523, -- Blessed Shield
2346, -- Stamina Potion
7141, -- Cave Exclusiva
5801, -- Super Backpack
9933, -- Firewalker Boots
5468, -- Removedor de Skulls
6574, -- Chocolate dos Deuses

}
--------------------------------------------|



function creatureSayCallback(cid, type, msg)

        npcPos = getNpcPos()
        positionNpc = {

            NORTH = {x=npcPos.x, y=npcPos.y-2, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
            SOUTH = {x=npcPos.x, y=npcPos.y+2, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
            WEST = {x=npcPos.x-2, y=npcPos.y, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
            EAST = {x=npcPos.x+2, y=npcPos.y, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
        
        }

        local npc = getNpcCid()
        local dice_pos = {x=npcPos.x+1,y=npcPos.y,z=npcPos.z, stackpos=1}

        if getTileThingByPos(dice_pos).itemid == 0 then
             doCreateItem(5792, dice_pos)
        end

        if getThingFromPos(positionNpc.NORTH).uid ~= 0 or getThingFromPos(positionNpc.SOUTH).uid ~= 0 or getThingFromPos(positionNpc.WEST).uid ~= 0 or getThingFromPos(positionNpc.EAST).uid ~= 0 then

            if msgcontains(msg, '1') or msgcontains(msg, '2') or msgcontains(msg, '3') or msgcontains(msg, '4') or msgcontains(msg, '5') or msgcontains(msg, '6') then
                    
                local dice_random_number = math.random(1, #randomDice)
                    local dice = randomDice[math.random(1, #randomDice)]
                    
                    if (tonumber(msg) == dice_random_number) then
                        local item_reward = rewards[math.random(1, #rewards)]
                        doSendMagicEffect(dice_pos, CONST_ME_CRAPS)
                        doTransformItem(getThingFromPos(dice_pos).uid, randomDice[dice_random_number])
                        doCreatureSay(npc, getCreatureName(npc).." rolled a "..dice_random_number.. ".", MESSAGE_STATUS_CONSOLE_ORANGE)
                        doCreatureSay(npc, getCreatureName(npc).." voce ganhou "..getItemNameById(item_reward).. ".", MESSAGE_STATUS_CONSOLE_ORANGE)
                        doPlayerAddItem(cid, item_reward, 1)
                        doTeleportThing(cid, player_teleport)
                    else
                        doCreatureSay(npc, getCreatureName(npc).. " rolled a "..dice_random_number.. ".", MESSAGE_STATUS_CONSOLE_ORANGE)
                        doSendMagicEffect(dice_pos, CONST_ME_CRAPS)
                        doTransformItem(getThingFromPos(dice_pos).uid, randomDice[dice_random_number])
                        doTeleportThing(cid, player_teleport)
                    end
            end
        end
        x = 0
 
end

function HavePlayer()

    npcPos = getNpcPos()
    positionNpc = {

        NORTH = {x=npcPos.x, y=npcPos.y-2, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
        SOUTH = {x=npcPos.x, y=npcPos.y+2, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
        WEST = {x=npcPos.x-2, y=npcPos.y, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
        EAST = {x=npcPos.x+2, y=npcPos.y, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE},
    
    }

    local npc = getNpcCid()
    local position = {x=npcPos.x, y=npcPos.y-2, z=npcPos.z, stackpos = STACKPOS_TOP_CREATURE}
    if (x == 0) then
        if getThingFromPos(positionNpc.NORTH).uid ~= 0 then
            doCreatureSay(npc, "Escolha um numero de 1 a 6, "..getCreatureName(getThingFromPos(positionNpc.NORTH).uid), TALKTYPE_MONSTER, true)
            doCreatureSetLookDirection(npc, NORTH)
            x = 1
        end
        if getThingFromPos(positionNpc.SOUTH).uid ~= 0 then
            doCreatureSay(npc, "Escolha um numero de 1 a 6, "..getCreatureName(getThingFromPos(positionNpc.SOUTH).uid), TALKTYPE_MONSTER, true)
            doCreatureSetLookDirection(npc, SOUTH)
            x = 1
        end
        if getThingFromPos(positionNpc.WEST).uid ~= 0 then
            doCreatureSay(npc, "Escolha um numero de 1 a 6, "..getCreatureName(getThingFromPos(positionNpc.WEST).uid), TALKTYPE_MONSTER, true)
            doCreatureSetLookDirection(npc, WEST)
            x = 1
        end
        if getThingFromPos(positionNpc.EAST).uid ~= 0 then
            doCreatureSay(npc, "Escolha um numero de 1 a 6, "..getCreatureName(getThingFromPos(positionNpc.EAST).uid), TALKTYPE_MONSTER, true)
            doCreatureSetLookDirection(npc, EAST)
            x = 1
        end
    end
    return true
end


function onThink()

   if HavePlayer() then
    return false
   end

npcHandler:onThink() 
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)