local accepted_ip_list = {"127.0.0.1"} -- Lista dos players permitidos a usar MC, exemplo: {"200.85.3.60", "201.36.5.222"}
local freeBlessMaxLevel = 100
local temple = { x = 152, y = 53, z = 7}
local save = {}

function saveRepeat(cid)
	if not isPlayer(cid) then return true end
	doPlayerSave(cid)
	doPlayerSendTextMessage(cid,19, 'O progresso do seu personagem foi salvo.')
	save[cid] = addEvent(saveRepeat, math.random(30,43) *30*1000, cid)
	if (getPlayerGroupId(cid) > 4) then return true end
	doSendMagicEffect(getThingPos(cid), 11)
end

local function existMonsterByName(name,cid)
	if type(name) ~= "string" then error("argument must be a string!") end
	if string.find(name:lower(),"adm") or string.find(name:lower(),"tutor") or string.find(name:lower()," gm") or string.find(name:lower(), "gm ") or string.find(name:lower()," cm") or string.find(name:lower(), "cm ") or string.find(name:lower(),"support") or string.find(name:lower(),"suporte") then
		if getPlayerAccess(cid) < 2 then
			return true
		end
	end
	local monsters = io.open("data/monster/monsters.xml","r")
	local str = monsters:read("*all")
	monsters:close();
	if string.find(str:lower(),'"'..name:lower()..'"') then return true end
	return false
end

local function delete(name)
	local query = db.query or db.executeQuery
	query("DELETE FROM players WHERE name = '"..name.."'")
end

local function antiMC(p)
	if not isPlayer(cid) then return true end
	if #getPlayersByIp(getPlayerIp(p.pid)) >= p.max then
		if not isPlayer(cid) then return true end
		doRemoveCreature(p.pid)
	end
	return true
end

local function effectAnel(cid)
	if isPlayer(cid) then
		if getPlayerSlotItem(cid,9) and getPlayerSlotItem(cid,9).uid > 0 and getPlayerSlotItem(cid,9).itemid == 7697 then
			doSendMagicEffect(getThingPos(cid), 36)
		end
		addEvent(effectAnel, 3000, cid)
	end
	return true
end

function onLogin(cid)
	caveExclusiva:check(cid)

	--[Autoloot]--
	--[Autoloot Power]--
	if getPlayerStorageValue(cid, 04421001) == -1 or 0 then
		doPlayerSetStorageValue(cid, 04421001, 1)
	end
	--[Autoloot Gold]--
	if getPlayerStorageValue(cid, 04421011) == -1 or 0 then
		doPlayerSetStorageValue(cid, 04421011, 1)
	end

	if getCreatureOutfit(cid).lookType == 306 and getPlayerStorageValue(cid, 121219) ~= 1 then
		doCreatureChangeOutfit(cid, getPlayerSex(cid) == 0 and {lookType = 136} or {lookType = 128})
	end
	
	if(getBooleanFromString(getConfigValue('accountManager')) == false) then
		if (getCreatureName(cid) == "Account Manager") then
			return doRemoveCreature(cid, true)
		end
	end
	
	if getPlayerSlotItem(cid,9) and getPlayerSlotItem(cid,9).uid > 0 and getPlayerSlotItem(cid,9).itemid == 7697 then
		effectAnel(cid)
	end

	local loss = getConfigValue('deathLostPercent')
	if(loss ~= nil) then
		doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	end
	
	local accountManager = getPlayerAccountManager(cid)
	if(accountManager == MANAGER_NONE) then
		local lastLogin, str = getPlayerLastLoginSaved(cid)
		if(lastLogin > 0) then
	end

	elseif(accountManager == MANAGER_NAMELOCK) then
		addEvent(valid(doCreatureSay), 500, cid, "Hello, it appears that your character has been locked for name violating rules, what new name would you like to have?", TALKTYPE_PRIVATE_NP, true, cid)
	elseif(accountManager == MANAGER_ACCOUNT) then
		addEvent(valid(doCreatureSay), 500, cid, "Hello, type {account} to manage your account. If you would like to start over, type {cancel} anywhere.", TALKTYPE_PRIVATE_NP, true, cid)
	else
		addEvent(valid(doCreatureSay), 500, cid, "Hello, type {account} to create an account or {recover} to recover an account.", TALKTYPE_PRIVATE_NP, true, cid)
	end

	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end
	if getPlayerStorageValue(cid, 54304) > 0 then
     	doPlayerSetStorageValue(cid, 54304, 0)
 	end

	local name = getCreatureName(cid)
	if existMonsterByName(name,cid) then
		if getPlayerAccountId(cid) == 4 then return true end
		doPlayerPopupFYI(cid,"Voc� n�o pode criar um char com nome de monstro. Deletando...")
		addEvent(delete,5100,name)
		addEvent(doRemoveCreature,5000,cid)
	end
	
    if (InitArenaScript ~= 0) then
    InitArenaScript = 1
    -- make arena rooms free
        for i = 42300, 42309 do
            setGlobalStorageValue(i, 0)
            setGlobalStorageValue(i+100, 0)
        end
    end
	
	if(getPlayerOperatingSystem(cid) >= CLIENTOS_OTCLIENT_LINUX) then
		registerCreatureEvent(cid, "ExtendedOpcode")
	end
                            
	if getPlayerStorageValue(cid, 48902) == -1 then
        setPlayerStorageValue(cid, 48902, 0) 
    end

	if getPlayerName(cid) == "Account Manager" and #getPlayersByIp(getPlayerIp(cid)) > 10 then
		return false
	end
	
	-- Blessing Amulet
	if getPlayerSlotItem(cid, 2).itemid == 7889 then
		doPlayerAddBlessing(cid, 1)
		doPlayerAddBlessing(cid, 2)
		doPlayerAddBlessing(cid, 3)
		doPlayerAddBlessing(cid, 4)
		doPlayerAddBlessing(cid, 5)
		doSendMagicEffect(getPlayerPosition(cid), 49)
	else
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)	
	end

	-- Blessing Skull Amulet
	if getPlayerSlotItem(cid, 2).itemid == 2131 then
		doPlayerAddBlessing(cid, 1)
		doPlayerAddBlessing(cid, 2)
		doPlayerAddBlessing(cid, 3)
		doPlayerAddBlessing(cid, 4)
		doPlayerAddBlessing(cid, 5)
		doSendMagicEffect(getPlayerPosition(cid), 49)
	else
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)	
	end
	
	if getPlayerStorageValue(cid, 48903) == -1 and getPlayerStorageValue(cid, 48902) == -1 then
		setPlayerStorageValue(cid, 48903, 0) 
		setPlayerStorageValue(cid, 48902, 0) 
	end
	
	-- CheckGems
	local gemid = getPlayerStorageValue(cid, 71473)
	if (getPlayerStorageValue(cid, 45783) > 0) and (checkGemTimeFinish(cid, gemid)) then
		deAtiveGem(cid, gemid)
	end
	
	if (gemid > 0) and (not checkGemTimeFinish(cid, gemid)) then
		local pedra = pedras_add[gemid]

		if not (pedra) then
			return true  
		end
  
		local skills = pedra.skills
		doAddCondition(cid, pedras_add_c[gemid])      
		doPlayerSendTextMessage(cid, 27, "O efeito da gema m�gica foi retomado.")
		doPlayerSetExperienceRate(cid, pedra.xp)     
		sendGemEffect(cid, gemid)
	end

	if tonumber(getPlayerStorageValue(cid,722381)) and tonumber(getPlayerStorageValue(cid,722381)) > os.time() then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"Voc� est� com Autoloot BOOST ativado por mais "..timeString(tonumber(getPlayerStorageValue(cid,722381)) - os.time())..", aproveite.")
	end

	-- CheckBlessing
	if(getPlayerLevel(cid) <= freeBlessMaxLevel and not getPlayerBlessing(cid,1)) then
		for b=1, 5 do
			doPlayerAddBlessing(cid, b)
		end
		doCreatureSay(cid, 'Voce tem bless gratuita, porque seu level � menor que 100', TALKTYPE_ORANGE_1)
		doSendMagicEffect(getThingPosition(cid), CONST_ME_HOLYDAMAGE)
	elseif(getPlayerBlessing(cid,1)) then
		doCreatureSay(cid, 'Voc� j� tem bless!', TALKTYPE_ORANGE_1)
	else
		doCreatureSay(cid, 'Voc� n�o tem bless. Digite !bless cuidado pode dar exausted', TALKTYPE_ORANGE_1)
	end
	
	-- StaminaTrainer
	if getPlayerStorageValue(cid, 19387) ~= 0 then
        	setPlayerStorageValue(cid, 19387, 0) 
	end

	-- SaveCharacterSystem
	save[cid] = addEvent(saveRepeat, math.random(30,43)*30*1000, cid)
	
	local loginmsg = "[Promo��o]: [Double Points] para doa��es acima de R$20,00 e [Triple Points] acima de R$100,00. Aproveite!"
	addEvent(valid(doCreatureSay), 100, cid, loginmsg, TALKTYPE_PRIVATE, false, cid)

	-- Setar storage ao logar
	--setPlayerStorageValue(cid, "lootch", 1)
	setPlayerStorageValue(cid, 25950, -1)
	setPlayerStorageValue(cid, 1013120, 0)
	setPlayerStorageValue(cid, 1013121, 0)

	registerCreatureEvent(cid, "Dummy")
	registerCreatureEvent(cid, "monsterBoostKill")
	registerCreatureEvent(cid, "NoMoveItems")
	registerCreatureEvent(cid, "autoloot")
	registerCreatureEvent(cid, "Auto Loot")
	registerCreatureEvent(cid, "Points_Trade_Request")
	registerCreatureEvent(cid, "Points_Trade")
	registerCreatureEvent(cid, "moreExp")
	registerCreatureEvent(cid, "vipdays")
	registerCreatureEvent(cid, "pushpz")
	registerCreatureEvent(cid, "OpenChannelDialog")
	registerCreatureEvent(cid, "azazel")
	registerCreatureEvent(cid, "the triangle")
	registerCreatureEvent(cid, "NpcShout")
	registerCreatureEvent(cid, "Anti Entrosa Login")
	registerCreatureEvent(cid, "Anti Entrosa Logout")
	registerCreatureEvent(cid, "MoveItem")
	registerCreatureEvent(cid, "lootChannelJoin")
	registerCreatureEvent(cid, "lootChannelLeave")
	registerCreatureEvent(cid, "SkullAmulet")

	registerCreatureEvent(cid, "showKD")
    registerCreatureEvent(cid, "otlist")
	registerCreatureEvent(cid, "Kills")
	registerCreatureEvent(cid, "Thinks")
	registerCreatureEvent(cid, "PlayerLogin")
	registerCreatureEvent(cid, "citywar")
	registerCreatureEvent(cid, "dttDeath")
	registerCreatureEvent(cid, "dttPrepare")
	registerCreatureEvent(cid, "dttStats")
	registerCreatureEvent(cid, "dttOutfit")
	registerCreatureEvent(cid, "rewardBoss")
	registerCreatureEvent(cid, "dttLogin")
	registerCreatureEvent(cid, "dttKill")
	registerCreatureEvent(cid, "entrosaLogout")
	registerCreatureEvent(cid, "dttCombat")
	registerCreatureEvent(cid, "TeleportQuest")
	registerCreatureEvent(cid, "TeleportArena")
	registerCreatureEvent(cid, "FireStorm")
	registerCreatureEvent(cid, "FireStorm")
	registerCreatureEvent(cid, "DesertDeath")
	registerCreatureEvent(cid, "DesertCombat")
	registerCreatureEvent(cid, "Ctf")
	registerCreatureEvent(cid, "BattleDeath")
	registerCreatureEvent(cid, "BattleCombat")
	registerCreatureEvent(cid, "FullHpMana")
	registerCreatureEvent(cid, "recompensa")
	registerCreatureEvent(cid, "huntdeath")
	registerCreatureEvent(cid, "staminafiller")
	registerCreatureEvent(cid, "taskbk")
	registerCreatureEvent(cid, "Logout")
	registerCreatureEvent(cid, "GuildEvents")
	registerCreatureEvent(cid, "Mail")
	registerCreatureEvent(cid, "SaveReportBug")
	registerCreatureEvent(cid, "teleportmonster")
	registerCreatureEvent(cid, "attackguild")
	registerCreatureEvent(cid, "CombatDodge")
	registerCreatureEvent(cid, "critical")	
	registerCreatureEvent(cid, "ExataltationStats")	
  return true
end