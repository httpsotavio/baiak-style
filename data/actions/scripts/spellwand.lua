function onUse(cid, item, frompos, itemEx, topos)
    if (itemEx.itemid == item.itemid) then
        local str = ""
        for itemId, itemData in pairs(SpellWand_Items) do
            str = str .. "["..getItemNameById(itemId):gsub("%a", string.upper, 1) .. "]: " .. itemData.price .. "\n"
        end
        doShowTextDialog(cid, 6533, "-----------------------------\n                      [Item Name]: Price\n-----------------------------\n".. str)
        return true
    end

    local itemData = SpellWand_Items[itemEx.itemid]
    if (itemData) then
        local count = getPlayerItemCount(cid, itemEx.itemid)
        if count > 0 then
            local totalPrice = itemData.price * count
            doPlayerRemoveItem(cid, itemEx.itemid, count)
            doPlayerSetBalance(cid, getPlayerBalance(cid) + totalPrice)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você vendeu "..count.." "..getItemNameById(itemEx.itemid).." por "..totalPrice.." gold coins. Todo o dinheiro foi depositado em seu banco")
            doSendMagicEffect(frompos, CONST_ME_MAGIC_RED)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você não possui nenhum(a) "..getItemNameById(itemEx.itemid).." para vender.")
            doSendMagicEffect(frompos, CONST_ME_POFF)
        end
    else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "O item "..getItemNameById(itemEx.itemid).." não está na lista de vendas, use a spellwand nela mesma para ver a lista de items disponíveis.")
        doSendMagicEffect(frompos, CONST_ME_POFF)
    end
    return true
end
