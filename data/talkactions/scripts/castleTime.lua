function onSay(cid, words, param)
    if(not checkExhausted(cid, 660, 5)) then
        return false
    end

    if realCastle.isOpen() then
        if getPlayerGuildId(cid) == 0 or not isInRange(getThingPos(cid), {x = 3308, y = 251, z = 9}, {x = 3412, y = 371, z = 9}) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Você precisa ser membro de alguma guild e estar dentro do Guild War para usar este comando.")
            return true
        end

        local winnerGuild = getPlayerGuildId(cid)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sua guild estar com um tempo de domínio equivalente a "..realCastle.getCacheDominanceTime(winnerGuild).." segundos.")
    else
        doPlayerSendCancel(cid, "O Guild War não está aberto para invasão, este comando é desnecessário nesta situação.")
    end
    return true
end