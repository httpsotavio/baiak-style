local config = {
    acc_name = "Account Manager", -- Nome do account manager
    max_account_managers = 1 -- Número máximo de Account Managers permitidos
}

function onLogin(cid)
    if getPlayerName(cid) == config.acc_name then
        local account_managers_online = 0
        local ip = getPlayerIp(cid)
        for _, pid in ipairs(getPlayersOnline()) do
            if getPlayerName(pid) == config.acc_name then
                local player_ip = getPlayerIp(pid)
                if player_ip == ip then
                    account_managers_online = account_managers_online + 1
                end
            end
        end
        if account_managers_online > config.max_account_managers then
            doRemoveCreature(cid)
            return false
        end
    end
    return true
end
