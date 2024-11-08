local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
	npcHandler:onThink()
end

function greetCallback(cid)
	talkState[cid] = 0
	return true
end

function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) then
		return false
	end
	if talkState[cid] == nil or talkState[cid] == 0 then
		Count_Points = tonumber(msg)
		if isInArray(Points_Trade.Points, Count_Points) then
			npcHandler:say("Ent�o voc� quer um documento de transfer�ncia no valor de ".. Count_Points .." Premium Points, certo?", cid)
			talkState[cid] = 1
		else
			npcHandler:say("Escolha um numero entre {".. table.concat(Points_Trade.Points, ', ') .."}.", cid)
			talkState[cid] = 0
		end
	elseif talkState[cid] == 1 then
		if msgcontains(msg, 'yes') then
		 if getPlayerPoints(cid) >= Count_Points then
			local Document = doCreateItemEx(Points_Trade.Document_ItemID)
			doItemSetAttribute(Document, "name", "".. Count_Points .." Premium Points Transfer document\nEste item deve ser negociado apenas por trade, n�o aceite de outra forma")
			doItemSetAttribute(Document, "points", Count_Points)
			doPlayerAddItemEx(cid, Document)
			npcHandler:say("Voc� obteve um documento de transfer�ncia que vale ".. Count_Points .." premium points, use ele no trade com alguem.", cid)
			talkState[cid] = 0
		else
			npcHandler:say("Desculpe, mas voce nao tem ".. Count_Points .." Premium Points.", cid)
			talkState[cid] = 0
		end
		else
			npcHandler:say("Ok, volte mais tarde.", cid)
			talkState[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|. Eu posso te vender um documento que � poss�vel transferir Premium Points ingame.\n{Dica do NPC: Este documento deve ser passado apenas por trade, se algu�m tentar negociar de outra forma ela vai te roubar.}\n{S� � poss�vel gerar um documento de transfer�ncia se voc� possuir algum ponto no servidor, caso contr�rio voc� n�o consegue gerar o documento.}\nPara comprar o documento digite a quantidade de pontos que deseja colocar no documento para transfer�ncia.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())