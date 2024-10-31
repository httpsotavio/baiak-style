local storage = 19387
local tempo = 10 * 60
local minutes = 2

local bosses = {
    ["King Treiner"] = {}
}

function onAttack(cid, target)
    local bid = bosses[getCreatureName(target)]
    if isMonster(target) and bid then
        local currentStorageValue = tonumber(getPlayerStorageValue(cid, storage)) or 0
        doPlayerSetStorageValue(cid, storage, currentStorageValue + 1)

        if getPlayerStorageValue(cid, storage) >= tempo then
            doPlayerAddStamina(cid, minutes)
            doPlayerSetStorageValue(cid, storage, 0)
        end
    end
    return true
end
