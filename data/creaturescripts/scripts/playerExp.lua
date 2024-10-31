local rates = {
    guild = 1.2,
    vip = 1.1
}

local moreExp = {
    guildDomi = "[Guild War] Sua Guild tem "..((rates.guild) * 100).."% a mais de experiencia.",
    guildNo_Domi = "[Guild War] Domine o Castle e ganhe "..((rates.guild) * 100).."% a mais de experiencia!",

    playerVip = "[Premium Account] Você tem "..((rates.vip - 1) * 100).."% a mais de experiencia do que um Jogador Free Account.",
    playerNo_Vip = "[Free Account] Ganhe "..((rates.vip - 1) * 100).."% a mais de experiencia se tornando Premium Account."
}

function onLogin(cid)
    if not isPlayer(cid) then
        return true
    end

    local expRate = 1.0
    if realCastle.isDominating(cid) then
        expRate = expRate * rates.guild
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, moreExp.guildDomi)
    else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, moreExp.guildNo_Domi)
    end
    
    if isPremium(cid) then
        expRate = expRate * rates.vip
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, moreExp.playerVip)
    else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, moreExp.playerNo_Vip)
    end

    doPlayerSetExperienceRate(cid, expRate)
    return true
end
