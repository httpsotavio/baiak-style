exaltationForge = {
    container = 1741,
    [49230] = {playerPos = {x= 140, y= 40, z= 7}, containerPos = {x= 140, y= 39, z= 7}},
    [49231] = {playerPos = {x= 142, y= 40, z= 7}, containerPos = {x= 142, y= 39, z= 7}},
    [49232] = {playerPos = {x= 144, y= 40, z= 7}, containerPos = {x= 144, y= 39, z= 7}},
    [49233] = {playerPos = {x= 146, y= 40, z= 7}, containerPos = {x= 146, y= 39, z= 7}},

    forgeLevel = {
        [0] = 99,
        [1] = 80,
        [2] = 70,
        [3] = 60,
        [4] = 50,
        [5] = 40,
        [6] = 30,
        [7] = 20,
        [8] = 10,
        [9] = 9,
        [10] = 8,
        [11] = 7,
        [12] = 6,
        [13] = 5,
        [14] = 4,
        [15] = 3,
    },

    attributes = {
        ["extraattack"] = 5,
    },
    message = {
        fail = "{Tier System} Voc� falhou em sua melhoria.",
        maxlevel = "{Tier System} O item %s j� est� no seu n�vel maximo.",
        downgrade = "{Tier System} Seu item %s regrediu para o n�vel +%s.",
        notupgradeable = "{Tier System} O item %s n�o pode ser melhorado.",
        tierdifferent= "{Tier System} Os itens precisam ter o mesmo n�vel de tier.",
        itemsdifferent = "{Tier System} Os itens precisam coincidir um com o outro.",
        toolrange = "{Tier System} Voc� s� pode usar a forja com items de n�vel +%s-.",
        erase = "{Tier System} O item %s teve seus leveis perdidos por falta de sorte.",
        broadcast = "{Tier System} O jogador [%s] obteve sucesso na supremacia do item %s.\nParabens!",
        needitems = "{Tier System} Voc� precisa depositar 2 itens para que seja poss�vel usar a alavanca.",
        success = "{Tier System} O item %s foi melhorado para o n�vel %s. Pr�ximo n�vel com %s%% de change de ser melhorado.",
        successMaxLevel = "{Tier System} O item %s foi melhorado para o n�vel %s."
    },
}

function isEquipment(item)
    local weaponType = getItemWeaponType(item)
    return weaponType and weaponType > 0 and weaponType <= 7
end

function getItemTier(itemuid)
    if (getItemAttribute(itemuid, "tier")) then
        return getItemAttribute(itemuid, "tier")
    end
    return 0
end

function setItemTier(itemuid, value)
    doItemSetAttribute(itemuid, "tier", value)
end

function getItemExtraDamage(itemuid)
    return getItemTier() * 2
end