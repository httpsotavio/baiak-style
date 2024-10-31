local tableItems = {
    [23723] = {
        effect = CONST_ME_GIFT_WRAPS,
        rewards = { -- shaggy ogre bag
            {chance = 30, itemReward = 2160, itemCount = 1},
            {chance = 50, itemReward = 2152, itemCount = 1}
        }
    },
    [28405] = { -- gold dust
        effect = CONST_ME_GIFT_WRAPS,
        rewards = {
            {chance = 30, itemReward = 2160, itemCount = 1},
            {chance = 50, itemReward = 2152, itemCount = 1}
        }
    },
    [35067] = { -- bag you desire
        effect = CONST_ME_GIFT_WRAPS,
        rewards = {
            {chance = 30, itemReward = 2160, itemCount = 1},
            {chance = 50, itemReward = 2152, itemCount = 1}
        }
    },
    [44448] = { -- tibiora's box replica
        effect = CONST_ME_GIFT_WRAPS,
        rewards = {
            {chance = 30, itemReward = 2160, itemCount = 1},
            {chance = 50, itemReward = 2152, itemCount = 1}
        }
    },
    [44798] = { -- sanguine bag
        effect = CONST_ME_GIFT_WRAPS,
        rewards = {
            {chance = 30, itemReward = 2160, itemCount = 1},
            {chance = 50, itemReward = 2152, itemCount = 1}
        }
    }
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local random = math.random(100)
    local playerPos = getPlayerPosition(cid)

    local accessTable = tableItems[item.itemid]
    local received = false

    if accessTable then
        for _, reward in pairs(accessTable.rewards) do
            if random <= reward.chance then
                received = true
                doSendMagicEffect(playerPos, accessTable.effect)
                doPlayerAddItem(cid, reward.itemReward, reward.itemCount)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Parabéns, você achou "..reward.itemCount.."x "..getItemNameById(reward.itemReward).."!")
                break
            end
        end
    end

    if not received then
        return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Você não encontrou nada.")
    end
    return true
end
