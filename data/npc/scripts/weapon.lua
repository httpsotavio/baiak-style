local talkState = {}
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)        		npcHandler:onCreatureAppear(cid)      		end
function onCreatureDisappear(cid)       	npcHandler:onCreatureDisappear(cid)     	end
function onCreatureSay(cid, type, msg)    	npcHandler:onCreatureSay(cid, type, msg)  	end
function onThink()              			npcHandler:onThink()            			end
function onPlayerEndTrade(cid)        		npcHandler:onPlayerEndTrade(cid)      		end
function onPlayerCloseChannel(cid)      	npcHandler:onPlayerCloseChannel(cid)    	end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local msg = msg:lower()
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if not talkState[talkUser] then
		talkState[talkUser] = 1 
	end

	local priceToReload = 100000
	local exerciseWeapon = {
		[2445] = {priceToBuy = 750000000},
		[7763] = {priceToBuy = 750000000},
		[7772] = {priceToBuy = 750000000},
		[7773] = {priceToBuy = 750000000},
		[7775] = {priceToBuy = 750000000},
	}

	local shopWindow = {}
	if talkState[talkUser] == 1 then
		if msgcontains(msg, "recarregar") or msgcontains(msg, "reload") then
			selfSay("Eu posso recarregar a sua {Exercise Weapon}, você quer isso?", cid)
			talkState[talkUser] = 2
		elseif msgcontains(msg, "comprar") or msgcontains(msg, "trade") then
			selfSay("Aqui está o meu estoque das Exercise Weapons.", cid)
			local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
				if exerciseWeapon[item] and getPlayerMoney(cid) >= exerciseWeapon[item].priceToBuy then
					doPlayerAddItem(cid, item)
					doPlayerRemoveMoney(cid, exerciseWeapon[item].priceToBuy)
					selfSay("Aqui está a sua {"..getItemInfo(item).name.."}.", cid)
				else
					selfSay("Você precisa de {"..exerciseWeapon[item].priceToBuy.." golds} para comprar este item.", cid)
				end
				return true
			end
			for var, ret in pairs(exerciseWeapon) do
				table.insert(shopWindow, {id = var, subType = 0, buy = ret.priceToBuy, sell = 0, name = getItemNameById(var)})
			end
			openShopWindow(cid, shopWindow, onBuy, onSell)
		end
	elseif talkState[talkUser] == 2 then
		if msgcontains(msg, "sim") or msgcontains(msg, "yes") then
			selfSay("Certo, me informe quantas {cargas} você deseja e o nome de sua exercise weapon. {Exemplo: 100 Exercise Weapon [Axe]}.\nLembrando que cada carga custa {"..priceToReload.."} gold coins.", cid)
			talkState[talkUser] = 3
		end
	elseif talkState[talkUser] == 3 then
		local searchItem = false
		local amount, itemName = msg:match("(%d+)%s(.+)")
		for itemId, skill in pairs(Dummy_TypeSkills) do
			if itemName == getItemInfo(itemId).name:lower() then
				searchItem = true
				local item = getPlayerItemById(cid, true, getItemIdByName(itemName))
				if item and getItemAttribute(item.uid, "charges") then
					local totalPrice = priceToReload * amount
					 if totalPrice > 0 and getPlayerMoney(cid) >= totalPrice then
					 	doPlayerRemoveMoney(cid, totalPrice)
					 	selfSay("Você recarregou {"..amount.."} unidades em sua {"..itemName.."}.", cid)
					 	doItemSetAttribute(item.uid, "charges", getItemAttribute(item.uid, "charges") + amount)
					 	talkState[talkUser] = 1
					 else
					 	selfSay("Você precisa de {"..totalPrice.."} gold coins para recarregar este item.", cid)
					 	talkState[talkUser] = 1
					 end
				else
					selfSay("Não é possível recarregar o item {"..itemName.."}.", cid)
				end
			end
		end

		if not searchItem then
			selfSay("O {nome} da Exercise Weapon que você escolheu {não existe} em minha loja. Tente digitar a quantidade de carga que dejesa e o nome correto, por exemplo: {100 Exercise Weapon [Axe]}", cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())