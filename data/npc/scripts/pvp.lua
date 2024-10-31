local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onThink()                          npcHandler:onThink()                        end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid)        end

local price = {id = 2160, amount = 100} -- Item que vai precisar para pagar e a quantidade
local config = {
    time = 24, -- Tempo em Dias
    storage = 72145 -- Storage
}

function onCreatureSay(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    if msgcontains(msg, 'pvp on') or msgcontains(msg, 'on') then
        if getPlayerStorageValue(cid, config.storage) == -1 then
            if getPlayerItemCount(cid, price[1].id) >= price[1].amount then
                doPlayerRemoveItem(cid, price[1].id, price[1].amount)
                setPlayerStorageValue(cid, storage, 1)
                npcHandler:say("Você acabou de ativar o seu PvP", cid)
                talkState[cid] = 0
            else
                npcHandler:say("Você não possui x"..price[1].amount.." "..getItemInfo(price[1].id).name.." volte mais tarde.", cid)
                talkState[cid] = 0
            end
        end
    end

    if msgcontains(msg, 'pvp off') or msgcontains(msg, 'off') then
        if getPlayerStorageValue(cid, config.storage) == 1 then
            if getPlayerItemCount(cid, price[1].id) >= price[1].amount then
                doPlayerRemoveItem(cid, price[1].id, price[1].amount)
                setPlayerStorageValue(cid, storage, -1)
                npcHandler:say("Você acabou de ativar o seu PvP", cid)
                talkState[cid] = 0
            else
                npcHandler:say("Você não possui x"..price[1].amount.." "..getItemInfo(price[1].id).name.." volte mais tarde.", cid)
                talkState[cid] = 0
            end
        end
    end                
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())