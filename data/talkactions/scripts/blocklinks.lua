local blockedLinks = {'baiak-gold', 'KELTERA-B@I@K', 'FENIX-B3I3K,COM', 'kingdomwar com', 'BAIAKWARS.WEBHOPE.ME<=IP', 'DRAGONBAIA COM', '.ddns.net', '66.70.238.140', 'Ba@ak-War', '167.114.108.174', '.servegame.com', 'baiak-go.gotdns.ch', 'gotdns.ch', 'baiak-go', '144.217.170.197', 'BAIAKEN-OT.DDNS.NET', 'BAIAKEN', 'baiaken', 'baiak-reaper.ddns.net', 'baiaken-rox', 'BAIAKEN-R0X.C0M', 'BAIAKEN-R0X.C0M<=IP)'}

local muteStorage = 16246
local muteTime = 100

local blockedLinksData = {}
local separator = "[ !\t%$%^%+%-%.%%_,<>]*"
for _, linkText in pairs(blockedLinks) do
    local data = {}
    data.link = linkText

    data.preg = ".*"
    for c in string.gmatch(linkText, ".") do
        if(c == '.') then
            data.preg = data.preg .. ".*"
        else
            data.preg = data.preg .. c .. separator
        end
    end
    data.preg = data.preg .. ".*"

    table.insert(blockedLinksData, data)
end

function isLegalMessage(words)
    for _, blockedLink in pairs(blockedLinksData) do
        if(string.match(words, blockedLink.preg) ~= nil) then
            return false, blockedLink.link
        end
    end
    return true, ""
end

function onSay(cid, words, param, channel)
    words = words .. " " .. param
    local legalMessage, forbiddenLink = isLegalMessage(
    string.lower(words))

    if(not legalMessage) then
        local muteStorageValue = getPlayerStorageValue(cid, muteStorage)
        if(muteStorageValue > os.time()) then
            doPlayerSendCancel(cid, "Você está mutado por "..convertTime(muteStorageValue - os.time())..".")
            return true
        end

        if(channel == CHANNEL_DEFAULT) then
            doCreatureSay(cid, "@#@#!", TALKTYPE_SAY)
            doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
        end

        doMutePlayer(cid, muteTime)
        setPlayerStorageValue(cid, muteStorage, muteTime)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Proibido pronunciar: "..forbiddenLink..".\nVocê foi mutado por "..muteTime..".")
        return true
    end
    return false
end