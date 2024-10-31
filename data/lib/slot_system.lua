SlotSystem = {
	base_attribute = 'slot_attribute_',
	count_attribute = 'used_slots',

	-- atributos dos items, tambem sao usados como usados como storages no jogador
	attributes = {
		crit_chance = 'SS_critchance',
		crit_damage = 'SS_critdamage',
		life_leech = 'SS_lifeleech',
		mana_leech = 'SS_manaleech',
		health = 'SS_health',
		mana = 'SS_mana',
		health_regen = 'SS_healthregen',
		mana_regen = 'SS_manaregen',
		protect_all = 'SS_protectall',
		damage = 'SS_damage',
		skills = 'SS_skills',
		mag_level = 'SS_maglevel'
	},

	items_slots = {
	--[Helmet]--
	[17067] = {inventory_slot = CONST_SLOT_HEAD, slots_count = 2}, -- Donate Mage Hat
	[17072] = {inventory_slot = CONST_SLOT_HEAD, slots_count = 2}, -- Donate Knight Helmet
	[15221] = {inventory_slot = CONST_SLOT_HEAD, slots_count = 2}, -- Donate Paladin Helmet

	--[Armor]--
	[17068] = {inventory_slot = CONST_SLOT_ARMOR, slots_count = 2}, -- Donate Mage Robe
	[17073] = {inventory_slot = CONST_SLOT_ARMOR, slots_count = 2}, -- Donate Knight Armor
	[14957] = {inventory_slot = CONST_SLOT_ARMOR, slots_count = 2}, -- Donate Paladin Armor

	--[Legs]--
	[17069] = {inventory_slot = CONST_SLOT_LEGS, slots_count = 2}, -- Donate Mage Legs
	[17074] = {inventory_slot = CONST_SLOT_LEGS, slots_count = 2}, -- Donate Knight Legs
	[14959] = {inventory_slot = CONST_SLOT_LEGS, slots_count = 2}, -- Donate Paladin Legs

	--[Boots]--
	[23734] = {inventory_slot = CONST_SLOT_FEET, slots_count = 2}, -- Donate Mage Shoes
	[17075] = {inventory_slot = CONST_SLOT_FEET, slots_count = 2}, -- Donate Knight Boots
	[43465] = {inventory_slot = CONST_SLOT_FEET, slots_count = 2}, -- Donate Paladin Boots

	--[Amuleto]--
	[7889] = {inventory_slot = CONST_SLOT_NECKLACE, slots_count = 2}, -- Blessing Amulet
	[2131] = {inventory_slot = CONST_SLOT_NECKLACE, slots_count = 2}, -- Bleesing Skull Amulet

	--[Ring]--
	[17077] = {inventory_slot = CONST_SLOT_RING, slots_count = 1}, -- Donate Mage Ring
	[13633] = {inventory_slot = CONST_SLOT_RING, slots_count = 1}, -- Donate Knight Ring
	[43459] = {inventory_slot = CONST_SLOT_RING, slots_count = 1}, -- Donate Paladin Ring

	--[Shield]--
	[17079] = {inventory_slot = CONST_SLOT_LEFT, slots_count = 1}, -- Donate Knight Shield
	[15724] = {inventory_slot = CONST_SLOT_LEFT, slots_count = 1}, -- Donate Paladin Shield

	--[Spellbook]--
	[15732] = {inventory_slot = CONST_SLOT_LEFT, slots_count = 1}, -- Donate Mage SpellBook

	--[Sword]--
	[17138] = {inventory_slot = CONST_SLOT_RIGHT, slots_count = 2}, -- Donate Knight Sword

	--[Club]--
	[35044] = {inventory_slot = CONST_SLOT_RIGHT, slots_count = 2}, -- Donate Knight Club

	--[Axe]--
	[33574] = {inventory_slot = CONST_SLOT_RIGHT, slots_count = 2}, -- Donate Knight Axe

	--[Distance]--
	[13696] = {inventory_slot = CONST_SLOT_RIGHT, slots_count = 2}, -- Donate Paladin Bow

	--[Wand]--
	[13566] = {inventory_slot = CONST_SLOT_RIGHT, slots_count = 2}, -- Donate Mage Wand
	}
}

-- CONST_SLOT_FIRST = 1
-- CONST_SLOT_HEAD = CONST_SLOT_FIRST
-- CONST_SLOT_NECKLACE = 2
-- CONST_SLOT_BACKPACK = 3
-- CONST_SLOT_ARMOR = 4
-- CONST_SLOT_RIGHT = 5
-- CONST_SLOT_LEFT = 6
-- CONST_SLOT_LEGS = 7
-- CONST_SLOT_FEET = 8
-- CONST_SLOT_RING = 9
-- CONST_SLOT_AMMO = 10
-- CONST_SLOT_LAST = CONST_SLOT_AMMO

-- Os nomes dos atributos podem ser mudados aqui (NOTA: N�O remova as chaves '%d')
local attributesNames = {
	[SlotSystem.attributes.crit_chance]   = 'Crit. Chance: %d%%',
	[SlotSystem.attributes.crit_damage]   = 'Crit. Damage: %d%%',
	[SlotSystem.attributes.life_leech]    = 'Life Leech: %d%%',
	[SlotSystem.attributes.mana_leech]    = 'Mana Leech: %d%%',
	[SlotSystem.attributes.health]        = 'Add Health: +%d',
	[SlotSystem.attributes.mana]          = 'Add Mana: +%d',
	[SlotSystem.attributes.health_regen]  = 'Health: +%d/s',
	[SlotSystem.attributes.mana_regen]    = 'Mana: +%d/s',
	[SlotSystem.attributes.protect_all]   = 'Protect All: %d%%',
	[SlotSystem.attributes.damage]        = 'Damage: %d%%',
	[SlotSystem.attributes.skills]        = 'Skills: +%d',
	[SlotSystem.attributes.mag_level]     = 'Mag. Level: +%d'
}

ORIGIN_NONE = 0
ORIGIN_SPELL = 1
ORIGIN_CONDITION = 2
ORIGIN_MELEE = 3
ORIGIN_DISTANCE = 4
ORIGIN_WAND = 5

STAT_FIRST = 0
STAT_MAXHEALTH = 0
STAT_MAXMANA = 1
STAT_SOUL = 2
STAT_LEVEL = 3
STAT_MAGICLEVEL = 4
STAT_LAST = 4

function SlotSystem:getSlotInfoById(id)
	return self.items_slots[id]
end

function SlotSystem:getItemUsedSlots(uid)
	return math.max(0, tonumber(getItemAttribute(uid, self.count_attribute)) or 0)
end

function SlotSystem:setItemUsedSlots(uid, count)
	doItemSetAttribute(uid, self.count_attribute, count)
end

function SlotSystem:getItemSlotAttribute(uid, n)
	local attr = getItemAttribute(uid, self.base_attribute .. n)
	if (not attr) then
		return nil
	end

	local name, value = tostring(attr):match('(.+)|(%d+)')
	if (not name or not value) then
		return nil
	end
	return {attr = name, value = tonumber(value)}
end

function SlotSystem:setItemSlotAttribute(uid, n, attr, value)
	doItemSetAttribute(uid, self.base_attribute .. n, attr .. '|' .. value)
end

function SlotSystem:getPlayerAttributeValue(cid, attr)
	return math.max(0, tonumber(getCreatureStorage(cid, attr)) or 0)
end

function SlotSystem:setPlayerAttributeValue(cid, attr, value)
	doCreatureSetStorage(cid, attr, value)
end

function SlotSystem:addPlayerAttributeValue(cid, attr, value)
	self:setPlayerAttributeValue(cid, attr, self:getPlayerAttributeValue(cid, attr) + value)
end

function SlotSystem:resetPlayerAttributes(cid)
	for _, attr in pairs(self.attributes) do
		doCreatureSetStorage(cid, attr, nil)
	end
end

function SlotSystem:getItemSlotsDescription(uid)
	local str = ''

	local usedSlots = self:getItemUsedSlots(uid)
	for i = 1, usedSlots do
		local t = self:getItemSlotAttribute(uid, i)
		if (t) then
			local attrName = attributesNames[t.attr]
			if (attrName) then
				str = str .. attrName:format(t.value) .. ', '
			else
				str = str .. '|unknown|, '
			end
		end
	end
	return str:sub(1, #str - 2)
end

function SlotSystem:getItemFreeSlotsCount(uid)
	local info = self.items_slots[getThing(uid).itemid]
	if (not info) then
		return 0
	end
	return math.max(0, info.slots_count - self:getItemUsedSlots(uid))
end

function SlotSystem:sendDebugInfo(cid)
	for _, attr in pairs(self.attributes) do
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, attr .. ': ' .. self:getPlayerAttributeValue(cid, attr))
	end
end

function SlotSystem:addPlayerItemAttributes(cid, uid)
	local updateSkills = false
	local updateStats = false

	local usedSlots = self:getItemUsedSlots(uid)
	for i = 1, usedSlots do
		local t = self:getItemSlotAttribute(uid, i)
		if (t) then
			self:addPlayerAttributeValue(cid, t.attr, t.value, false)
			if (t.attr == self.attributes.health) then
				addPlayerVarStats(cid, STAT_MAXHEALTH, t.value, false)
			elseif (t.attr == self.attributes.mana) then
				addPlayerVarStats(cid, STAT_MAXMANA, t.value, false)
			elseif (t.attr == self.attributes.skills) then
				updateSkills = true
				-- loop all skills
				for j = 0, 6 do
					addPlayerVarSkills(cid, j, t.value, false)
				end
			elseif (t.attr == self.attributes.mag_level) then
				updateStats = true
				addPlayerVarStats(cid, STAT_MAGICLEVEL, t.value, false)
			end
		end
	end

	if (updateSkills) then
		sendPlayerSkills(cid)
	end

	if (updateStats) then
		sendPlayerStats(cid)
	end
end

function SlotSystem:removePlayerItemAttributes(cid, uid)
	local updateSkills = false
	local updateStats = false

	local usedSlots = self:getItemUsedSlots(uid)
	for i = 1, usedSlots do
		local t = self:getItemSlotAttribute(uid, i)
		if (t) then
			self:addPlayerAttributeValue(cid, t.attr, -t.value)
			if (t.attr == self.attributes.health) then
				addPlayerVarStats(cid, STAT_MAXHEALTH, -t.value, false)
			elseif (t.attr == self.attributes.mana) then
				addPlayerVarStats(cid, STAT_MAXMANA, -t.value, false)
			elseif (t.attr == self.attributes.skills) then
				updateSkills = true
				-- loop all skills
				for j = 0, 6 do
					addPlayerVarSkills(cid, j, -t.value, false)
				end
			elseif (t.attr == self.attributes.mag_level) then
				updateStats = true
				addPlayerVarStats(cid, STAT_MAGICLEVEL, -t.value, false)
			end
		end
	end

	if (updateSkills) then
		sendPlayerSkills(cid)
	end

	if (updateStats) then
		sendPlayerStats(cid)
	end
end

-- Callbacks
function SlotSystem:onLogin(cid)
	self:resetPlayerAttributes(cid)

	-- loop all slots
	for i = 1, 10 do
		local slotItem = getPlayerSlotItem(cid, i)
		local info = self.items_slots[slotItem.itemid]
		if (info and (info.inventory_slot == i or (info.inventory_slot == 5 and i == 6) or (info.inventory_slot == 6 and i == 5))) then
			self:addPlayerItemAttributes(cid, slotItem.uid)
		end
	end
end

function SlotSystem:onEquipItem(cid, item, slot)
	local info = self.items_slots[item.itemid]
	if (info and (info.inventory_slot == slot or (info.inventory_slot == 5 and slot == 6) or (info.inventory_slot == 6 and slot == 5))) then
		self:addPlayerItemAttributes(cid, item.uid)
	end
end

function SlotSystem:onUnEquipItem(cid, item, slot)
	local info = self.items_slots[item.itemid]
	if (info and (info.inventory_slot == slot or (info.inventory_slot == 5 and slot == 6) or (info.inventory_slot == 6 and slot == 5))) then
		self:removePlayerItemAttributes(cid, item.uid)
	end
end
