local keywordHandler = KeywordHandler:new() 
local npcHandler = NpcHandler:new(keywordHandler) 
NpcSystem.parseParameters(npcHandler) 
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end 
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end 
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end 
function onThink() npcHandler:onThink() end 
function creatureSayCallback(cid, type, msg) 
if(not npcHandler:isFocused(cid)) then 
return false 
end 
local talkState = {}
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
local shopWindow = {}
local moeda = 6527 -- id da sua moeda vip
local t = {
    [8601] = {price = 475}, -- Knight Party
    [5803] = {price = 475}, -- Paladin Party
    [2112] = {price = 475}, -- Sorcerer Party
    [2349] = {price = 475}, -- Druid Party
    [5468] = {price = 400}, -- Remover Skulls
    [38008] = {price = 225}, -- Addon Doll
    [6546] = {price = 375}, -- Remover Mortes
    [5802] = {price = 375}, -- Remover Frags
    [2156] = {price = 300} -- Red Gem
}
    
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
    if  t[item] and not doPlayerRemoveItem(cid, moeda, t[item].price) then
          selfSay("You don't have "..t[item].price.." "..getItemNameById(moeda), cid)
             else
        doPlayerAddItem(cid, item)
        selfSay("Here are you.", cid)
       end
    return true
end
if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
            for var, ret in pairs(t) do
                    table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = 0, name = getItemNameById(var)})
                end
            openShopWindow(cid, shopWindow, onBuy, onSell)
          end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())