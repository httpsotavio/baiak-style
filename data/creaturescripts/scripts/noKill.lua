function onDeath(cid, corpse, deathlist)
    if isPlayer(cid) then
        if isInRange(getPlayerPosition(cid), realCastle.frompos, realCastle.topos) then
            for i = 1, #deathlist do
                local pid = deathlist[i]
                if isInRange(getPlayerPosition(pid), realCastle.frompos, realCastle.topos) then
                    if isPlayer(pid) then
                        db.executeQuery('UPDATE `killers` SET `unjustified` = `unjustified` - 1 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` ='.. getPlayerGUID(pid) ..');')
                    end
                end
            end
        end
    end
    return true
end

function onLogin(cid)
    registerCreatureEvent(cid, "noAreaKillLogin")
    registerCreatureEvent(cid, "noAreaKillDeath")
    return true
end