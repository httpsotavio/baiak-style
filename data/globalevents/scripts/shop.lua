local SHOP_MSG_TYPE = MESSAGE_EVENT_ORANGE
local SQL_interval = 30
--- ### Outfits List ###
local maleOutfits = { 
	["Citizen"] = {128}, 
	["Hunter"] = {129}, 
	["Mage"] = {130}, 
	["Knight"] = {131}, 
	["Noblewoman"] = {132},
	["Summoner"] = {133}, 
	["Warrior"] = {134}, 
	["Barbarian"] = {143}, 
	["Druid"] = {144}, 
	["Wizard"] = {145}, 
	["Oriental"] = {146}, 
	["Pirate"] = {151}, 
	["Assassin"] = {152}, 
	["Beggar"] = {153}, 
	["Shaman"] = {154}, 
	["Norsewoman"] = {251}, 
	["Nightmare"] = {268}, 
	["Jester"] = {273}, 
	["Brotherhood"] = {278}, 
	["Demonhunter"] = {289}, 
	["Yalaharian"] = {325}, 
	["Warmaster"] = {335}, 
	["Wayfarer"] = {367},
	["Afflicted"] = {431},
    ["Ancient Aucar"] = {1598},
    ["Battle Mage"] = {1070},
    ["Cave Explorer"] = {575},
    ["Citizen of Issavi"] = {1199},
    ["Crystal Warlord"] = {513},
    ["Decaying Defender"] = {1663},
    ["Deepling"] = {464},
    ["Demon"] = {542},
    ["Discoverer"] = {1095},
    ["Dragon Slayer"] = {1289},
    ["Dream Warden"] = {578},
    ["Dream Warrior"] = {1147},
    ["Elementalist"] = {433},
    ["Festive"] = {931},
    ["Formal Dress"] = {1461},
    ["Glooth Engineer"] = {618},
    ["Golden"] = {1211},
    ["Hand of the Inquisition"] = {1244},
    ["Insectoid"] = {466},
    ["Makeshift Warrior"] = {1043},
    ["Orcsoberfest Garb"] = {1252},
    ["Percht Raider"] = {1162},
    ["Poltergeist"] = {1271},
    ["Rascoohan"] = {1372},
    ["Revenant"] = {1323},
    ["Rift Warrior"] = {845},
    ["Royal Bounacean Advisor"] = {1437},
    ["Royal Costume"] = {1456},
    ["Soil Guardian"] = {514},
    ["Recruiter"] = {745},
    ["Arbalester"] = {1450},
    ["Arena Champion"] = {885},
    ["Armoured Archer"] = {1619},
    ["Beastmaster"] = {636},
    ["Breezy Garb"] = {1246},
    ["Ceremonial Garb"] = {694},
    ["Champion"] = {632},
    ["Chaos Acolyte"] = {664},
    ["Conjurer"] = {635},
    ["Darklight Evoker"] = {1676},
    ["Death Herald"] = {666},
    ["Dragon Knight"] = {1445},
    ["Entrepreneur"] = {471},
    ["Evoker"] = {724},
    ["Fencer"] = {1576},
    ["Flamefury Mage"] = {1681},
    ["Forest Warden"] = {1416},
    ["Frost Tracer"] = {1613},
    ["Ghost Blade"] = {1490},
    ["Grove Keeper"] = {909},
    ["Guidon Bearer"] = {1187},
    ["Herbalist"] = {1022},
    ["Herder"] = {1280},
    ["Jouster"] = {1332},
    ["Lupine Warden"] = {900},
    ["Mercenary"] = {1057},
    ["Merry Garb"] = {1383},
    ["Moth Cape"] = {1339},
    ["Nordic Chieftain"] = {1501},
    ["Owl Keeper"] = {1174},
    ["Pharaoh"] = {955},
    ["Philosopher"] = {874},
    ["Puppeteer"] = {696},
    ["Ranger"] = {683},
    ["Retro Citizen"] = {975},
    ["Retro Hunter"] = {973},
    ["Retro Knight"] = {971},
    ["Retro Mage"] = {969},
}
local femaleOutfits = { 
	["Citizen"] = {136}, 
	["Hunter"] = {137}, 
	["Mage"] = {138}, 
	["Knight"] = {139}, 
	["Noblewoman"] = {140}, 
	["Summoner"] = {141}, 
	["Warrior"] = {142}, 
	["Barbarian"] = {147}, 
	["Druid"] = {148}, 
	["Wizard"] = {149}, 
	["Oriental"] = {150}, 
	["Pirate"] = {155}, 
	["Assassin"] = {156}, 
	["Beggar"] = {157}, 
	["Shaman"] = {158}, 
	["Norsewoman"] = {252}, 
	["Nightmare"] = {269}, 
	["Jester"] = {270}, 
	["Brotherhood"] = {279}, 
	["Demonhunter"] = {288}, 
	["Yalaharian"] = {324}, 
	["Warmaster"] = {336},
	["Wayfarer"] = {366},
	["Afflicted"] = {430},
    ["Ancient Aucar"] = {1597},
    ["Battle Mage"] = {1069},
    ["Cave Explorer"] = {574},
    ["Citizen of Issavi"] = {1200},
    ["Crystal Warlord"] = {512},
    ["Decaying Defender"] = {1662},
    ["Deepling"] = {463},
    ["Demon"] = {541},
    ["Discoverer"] = {1094},
    ["Dragon Slayer"] = {1288},
    ["Dream Warden"] = {577},
    ["Dream Warrior"] = {1146},
    ["Elementalist"] = {432},
    ["Festive"] = {929},
    ["Formal Dress"] = {1460},
    ["Glooth Engineer"] = {610},
    ["Golden"] = {1210},
    ["Hand of the Inquisition"] = {1243},
    ["Insectoid"] = {465},
    ["Makeshift Warrior"] = {1042},
    ["Orcsoberfest Garb"] = {1251},
    ["Percht Raider"] = {1161},
    ["Poltergeist"] = {1270},
    ["Rascoohan"] = {1371},
    ["Revenant"] = {1322},
    ["Rift Warrior"] = {846},
    ["Royal Bounacean Advisor"] = {1436},
    ["Royal Costume"] = {1457},
    ["Soil Guardian"] = {516},
    ["Recruiter"] = {746},
    ["Arbalester"] = {1449},
    ["Arena Champion"] = {884},
    ["Armoured Archer"] = {1618},
    ["Beastmaster"] = {637},
    ["Breezy Garb"] = {1245},
    ["Ceremonial Garb"] = {695},
    ["Champion"] = {633},
    ["Chaos Acolyte"] = {665},
    ["Conjurer"] = {634},
    ["Darklight Evoker"] = {1675},
    ["Death Herald"] = {667},
    ["Dragon Knight"] = {1444},
    ["Entrepreneur"] = {472},
    ["Evoker"] = {725},
    ["Fencer"] = {1575},
    ["Flamefury Mage"] = {1680},
    ["Forest Warden"] = {1415},
    ["Frost Tracer"] = {1612},
    ["Ghost Blade"] = {1489},
    ["Grove Keeper"] = {908},
    ["Guidon Bearer"] = {1186},
    ["Herbalist"] = {1021},
    ["Herder"] = {1279},
    ["Jouster"] = {1331},
    ["Lupine Warden"] = {899},
    ["Mercenary"] = {1056},
    ["Merry Garb"] = {1382},
    ["Moth Cape"] = {1338},
    ["Nordic Chieftain"] = {1500},
    ["Owl Keeper"] = {1173},
    ["Pharaoh"] = {956},
    ["Philosopher"] = {873},
    ["Puppeteer"] = {697},
    ["Ranger"] = {684},
    ["Retro Citizen"] = {974},
    ["Retro Hunter"] = {972},
    ["Retro Knight"] = {970},
    ["Retro Mage"] = {968},
}

local mounts = {
	["Widow Queen"] = {368},
	["Racing Bird"] = {369},
	["War Bear"] = {370},
	["Black Sheep"] = {371},
	["Midnight Panther"] = {372},
	["Draptor"] = {373},
	["Titanica"] = {374},
	["Tin Lizzard"] = {375},
	["Blazebringer"] = {376},
	["Rapid Boar"] = {377},
	["Stampor"] = {378},
	["Undead Cavebear"] = {379},
	["Donkey"] = {387},
	["Tiger Slug"] = {388},
	["Uniwheel"] = {389},
	["Crystal Wolf"] = {390},
	["War Horse"] = {392},
	["Kingly Deer"] = {401},
	["Tamed Panda"] = {402},
	["Dromedary"] = {405},
	["Scorpion King"] = {406},
	["Horse Brown"] = {421},
	["Armoured War Horse"] = {426},
	["Shadow Draptor"] = {427},
	--[""] = {437},
	--[""] = {438},
	["Ladybug"] = {447},
	["Manta Ray"] = {450},
	["Ironblight"] = {502},
	["Magma Crawler"] = {503},
	["Dragonling"] = {506},
	["Gnarlhound"] = {515},
	["Crimson Ray"] = {521},
	["Steelbeak"] = {522},
	["Water Buffalo"] = {526},
	["Tombstinger"] = {546},
	["Platesaurian"] = {547},
	["Ursagrodon"] = {548},
	["The Hellgrip"] = {559},
	["Noble Lion"] = {571},
	["Desert King"] = {572},
	["Shock Head"] = {580},
	["Walker"] = {606},
	["Azudocus"] = {621},
	["Carpacosaurus"] = {622},
	["Death Crawler"] = {624},
	["Flamesteed"] = {626},
	["Jade Lion"] = {627},
	["Jade Pincer"] = {628},
	["Nethersteed"] = {629},
	["Tempest"] = {630},
	["Winter King"] = {631},
	["Doombringer"] = {644},
	["Woodland Prince"] = {647},
	["Hailstorm Fury"] = {648},
	["Siegebreaker"] = {649},
	["Poisonbane"] = {650},
	["Blackpelt"] = {651},
	["Golden Dragonfly"] = {669},
	["Steel Bee"] = {670},
	["Copper Fly"] = {671},
	--[""] = {672},
	["Highland Yak"] = {673},
	["Glacier Vagabond"] = {674},
	["Glooth Glider"] = {682},
	--[""] = {685},
	["Black Stag"] = {686},
	["Emperor Deer"] = {687},
	["Flying Divan"] = {688},
	["Magic Carpet"] = {689},
	["Floating Kashmir"] = {690},
	["Ringtail Waccoon"] = {691},
	["Night Waccoon"] = {692},
	["Emerald Waccoon"] = {693},
	["Flitterkatzen"] = {726},
	["Venompaw"] = {727},
	["Batcat"] = {728},
	["Sea Devil"] = {734},
	["Coralripper"] = {735},
	["Plumfish"] = {736},
	["Gorongra"] = {738},
	["Noctungra"] = {739},
	["Silverneck"] = {740},
	["Slagsnare"] = {761},
	["Nightstinger"] = {762},
	["Razorcreep"] = {763},
	["Rift Runner"] = {848},
	["Nightdweller"] = {849},
	["Frostflare"] = {850},
	["Cinderhoof"] = {851},
	["Mouldpincer"] = {868},
	["Leafscuttler"] = {869},
	["Bloodcurl"] = {870},
	["Sparkion"] = {883},
	["Swamp Snapper"] = {886},
	["Mould Shell"] = {887},
	["Reed Lurker"] = {888},
	["Neon Sparkid"] = {889},
	["Vortexion"] = {890},
	["Ivory Fang"] = {901},
	["Shadow Claw"] = {902},
	["Snow Pelt"] = {903},
	["Jackalope"] = {905},
	["Wolpertinger"] = {906},
	["Dreadhare"] = {907},
	["Stone Rhino"] = {937},
	["Gold Sphinx"] = {950},
	["Emerald Sphinx"] = {951},
	["Shadow Sphinx"] = {952},
	["Jungle Saurian"] = {959},
	["Ember Saurian"] = {960},
	["Lagoon Saurian"] = {961},
	["Blazing Unicorn"] = {1017},
	["Arctic Unicorn"] = {1018},
	["Prismatic Unicorn"] = {1019},
	["Cranium Spider"] = {1025},
	["Cave Tarantula"] = {1026},
	["Gloom Widow"] = {1027},
	["Mole"] = {1049},
	["Marsh Toad"] = {1052},
	["Sanguine Frog"] = {1053},
	["Toxic Toad"] = {1054},
	["Ebony Tiger"] = {1091},
	["Feral Tiger"] = {1092},
	["Jungle Tiger"] = {1093},
	["Fleeting Knowledge"] = {1101},
	["Boreal Owl"] = {1104},
	["Snowy Owl"] = {1105},
	["Tawny Owl"] = {1106},
	["Hibernal Moth"] = {1150},
	["Lacewing Moth"] = {1151},
	["Cold Percht Sleigh"] = {1163},
	["Bright Percht Sleigh"] = {1164},
	["Dark Percht Sleigh"] = {1165},
	["Festive Snowman"] = {1167},
	["Caped Snowman"] = {1168},
	["Muffled Snowman"] = {1169},
	["Rabbit Rickshaw"] = {1179},
	["Bunny Dray"] = {1180},
	["Cony Cart"] = {1181},
	["River Crocovile"] = {1183},
	["Swamp Crocovile"] = {1184},
	["Nightmarish Crocovile"] = {1185},
	["Gryphon"] = {1191},
	["Jousting Eagle"] = {1208},
	["Cerberus Champion"] = {1209},
	["Cold Percht Sleigh Variant"] = {1229},
	["Bright Percht Sleigh Variant"] = {1230},
	["Dark Percht Sleigh Variant"] = {1231},
	["Finished Cold Percht Sleigh"] = {1232},
	["Finished Bright Percht Sleigh"] = {1233},
	["Finished Dark Percht Sleigh"] = {1234},
	["Battle Badger"] = {1247},
	["Ether Badger"] = {1248},
	["Zaoan Badger"] = {1249},
	["Blue Rolling Barrel"] = {1257},
	["Red Rolling Barrel"] = {1258},
	["Green Rolling Barrel"] = {1259},
	["Floating Sage"] = {1264},
	["Floating Scholar"] = {1265},
	["Floating Augur"] = {1266},
	["Haze"] = {1269},
	["Antelope"] = {1281},
	["Snow Strider"] = {1284},
	["Dusk Pryer"] = {1285},
	["Dawn Strayer"] = {1286},
	["Benevolent Coral Rhea"] = {1310},
	["Benevolent Eventide Nandu"] = {1311},
	["Benevolent Savanna Ostrich"] = {1309},
	["Coral Rhea"] = {1325},
	["Eventide Nandu"] = {1326},
	["Savanna Ostrich"] = {1324},
	["Phantasmal Jade"] = {1321},
	["Voracious Hyaena"] = {1333},
	["Cunning Hyaena"] = {1334},
	["Scruffy Hyaena"] = {1335},
	["White Lion"] = {1336},
	["Merry Mammoth"] = {1379},
	["Holiday Mammoth"] = {1380},
	["Festive Mammoth"] = {1381},
	["Void Watcher"] = {1389},
	["Rune Watcher"] = {1390},
	["Rift Watcher"] = {1391},
	["Phant"] = {1417},
	["Singeing Steed"] = {1431},
	["Hyacinth"] = {1439},
	["Peony"] = {1440},
	["Dandelion"] = {1441},
	["Rustwurm"] = {1446},
	["Bogwurm"] = {1447},
	["Gloomwurm"] = {1448},
	["Emerald Raven"] = {1453},
	["Mystic Raven"] = {1454},
	["Radiant Raven"] = {1455},
	["Topaz Shrine"] = {1491},
	["Jade Shrine"] = {1492},
	["Obsidian Shrine"] = {1493},
	["Poppy Ibex"] = {1526},
	["Mint Ibex"] = {1527},
	["Cinnamon Ibex"] = {1528},
	["Ripptor"] = {1577},
	["Parade Horse"] = {1578},
	["Jousting Horse"] = {1579},
	["Tourney Horse"] = {1580},
	["Tangerine Flecked Koi"] = {1608},
	["Ink Spotted Koi"] = {1609},
	["Brass Speckled Koi"] = {1610},
	["Frostbringer"] = {1615},
	["Winterstride"] = {1616},
	["Icebreacher"] = {1617},
	["Boisterous Bull"] = {1672},
	["Surly Steer"] = {1673},
	["Obstinate Ox"] = {1674},
	["Darkfire Devourer"] = {1677},
	["Spirit of Purity"] = {1682},
	["Doom Skull"] = {1685},
	["Magma Skull"] = {1686},
	["Corpsefire Skull"] = {1687}
}

function onThink(interval, lastExecution)
	local result_plr = db.getResult("SELECT * FROM z_ots_comunication")
	if(result_plr:getID() ~= -1) then
		while(true) do
		
			id = tonumber(result_plr:getDataInt("id"))
			local action = tostring(result_plr:getDataString("action"))
			local delete = tonumber(result_plr:getDataInt("delete_it"))
			local cid = getPlayerByName(tostring(result_plr:getDataString("name")))
			
			if isPlayer(cid) then
			
				local itemtogive_id = tonumber(result_plr:getDataInt("param1"))
				local itemtogive_count = tonumber(result_plr:getDataInt("param2"))
				local outfit_name = string.lower(tostring(result_plr:getDataString("param3")))
				local itemvip = tonumber(result_plr:getDataInt("param4"))
				local add_item_type = tostring(result_plr:getDataString("param5"))
				local add_item_name = tostring(result_plr:getDataString("param6"))
				local points = tonumber(result_plr:getDataInt("param7"))
				local received_item = 0
				local full_weight = 0
				
				if(action == 'give_item') then
					full_weight = getItemWeightById(itemtogive_id, itemtogive_count)
					if isItemRune(itemtogive_id) == TRUE then
						full_weight = getItemWeightById(itemtogive_id, 1)
					else
						full_weight = getItemWeightById(itemtogive_id, itemtogive_count)
					end
					
					local free_cap = getPlayerFreeCap(cid)

					local new_item = doCreateItemEx(itemtogive_id, itemtogive_count)
					
					if free_cap >= 100 then
						received_item = doPlayerAddItemEx(cid, new_item)
						if received_item == RETURNVALUE_NOERROR then
							doPlayerSendTextMessage(cid, SHOP_MSG_TYPE, 'You received >> '.. add_item_name ..' << RELOGUE PARA SALVAR URGENTE.')
							db.executeQuery("DELETE FROM `z_ots_comunication` WHERE `id` = " .. id .. ";")
						        db.query("UPDATE `z_shop_history_item` SET `trans_state`='realized', `trans_real`=" .. os.time() .. " WHERE id = " .. id .. ";")
						else
							doPlayerSendTextMessage(cid, SHOP_MSG_TYPE, '>> '.. add_item_name ..' << from OTS shop is waiting for you. Please make place for this item in your backpack/hands and wait about '.. SQL_interval ..' seconds to get it.')
						end
					else
						doPlayerSendTextMessage(cid, SHOP_MSG_TYPE, '>> '.. add_item_name ..' << from OTS shop is waiting for you. It weight is '.. full_weight ..' oz., you have only '.. free_cap ..' oz. free capacity. Put some items in depot and wait about '.. SQL_interval ..' seconds to get it.')
					end
				end
				
				if(action == 'give_outfit') then
					if outfit_name ~= "" and maleOutfits[outfit_name] and femaleOutfits[outfit_name] then
						local add_outfit = getPlayerSex(cid) == 0 and femaleOutfits[outfit_name][1] or maleOutfits[outfit_name][1]
						if not canPlayerWearOutfit(cid, add_outfit, 3) then
							db.query("DELETE FROM `z_ots_comunication` WHERE `id` = " .. id .. ";")
							doSendMagicEffect(getCreaturePosition(cid), CONST_ME_GIFT_WRAPS)
                			doPlayerAddOutfit(cid, add_outfit, 3)
							doPlayerSendTextMessage(cid, SHOP_MSG_TYPE, "You received the outfit " .. add_item_name .. " of our Shop Online.")
						else
							doPlayerSendTextMessage(cid, SHOP_MSG_TYPE, "You already have this outfit. Your points were returned, thank you.")
							db.query("DELETE FROM `z_ots_comunication` WHERE `id` = " .. id .. ";")
							db.query("UPDATE `accounts` SET `premium_points` = `premium_points` + " .. points .. " WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
						end
					end
				end
				
			end
			if not(result_plr:next()) then
				break
			end
		end
		result_plr:free()
	end
	
	return true
end