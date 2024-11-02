local itemBlock = {1741} 
function onThrow(cid, item, fromPosition, toPosition)
    if isInArray(itemBlock, item.itemid) then
        return false   
    end
    return true 
end