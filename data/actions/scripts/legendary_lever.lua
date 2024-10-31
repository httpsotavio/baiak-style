--[[
customKey = 2090,
discardLog = true,
]]

if not protectedLevers then
	protectedLevers = {
		[17320] = { -- Roleta da esquerda
			customKey = 43446,
			winPosition = {x = 279, y = 134, z = 14},
			items = {
				[7424] = {rate = 0.01},
				[10000] = {rate = 0.02},
				[8978] = {rate = 0.03},
				[2816] = {rate = 0.05},
				[8300] = {rate = 0.06},
				[2328] = {rate = 0.06, count = 5},
				[6543] = {rate = 0.08, count = 5},
				[6545] = {rate = 0.09, count = 5},
				[7489] = {rate = 0.09},
				[8305] = {rate = 0.10},
				[12739] = {rate = 0.12},
				[12372] = {rate = 0.14, count = 15},
				[12601] = {rate = 0.15, count = 15}
			}
		},
		[17321] = { -- Roleta do meio
			customKey = 43444,
			winPosition = {x = 294, y = 134, z = 14},
			items = {
				[43446] = {rate = 0.02}, -- Chave do Site
				[44448] = {rate = 0.02}, -- Tibiora's box Replica
				[35067] = {rate = 0.02}, -- Bag You Desire
				[13775] = {rate = 0.03}, -- Super Cursed
				[40706] = {rate = 0.03}, -- Donate Doll
				[7739] = {rate = 0.3}, -- Donate Backpack
				[15721] = {rate = 0.3}, -- Promote Tp
				[39987] = {rate = 0.04, count = 1}, -- Critical Hit
				[39983] = {rate = 0.04, count = 1}, -- Regen Health
				[33683] = {rate = 0.04, count = 1}, -- Increase Mana
				[12396] = {rate = 0.04, count = 3}, -- Critical Stone
				[9971] = {rate = 0.05, count = 15}, -- Kk's
				[35057] = {rate = 0.5} -- Perfect Paladin Shield
			}
		},
		[17322] = { -- Roleta do castle48h
			customKey = 43445,
			winPosition = {x = 308, y = 134, z = 14},
			items = {
				[7424] = {rate = 0.02},
				[8851] = {rate = 0.02},
				[8931] = {rate = 0.02},
				[12599] = {rate = 0.05},
				[8300] = {rate = 0.06},
				[2328] = {rate = 0.06, count = 5},
				[6545] = {rate = 0.08, count = 5},
				[6543] = {rate = 0.09},
				[8305] = {rate = 0.10, count = 5},
				[12739] = {rate = 0.10},
				[7489] = {rate = 0.11},
				[12372] = {rate = 0.14, count = 15},
				[12601] = {rate = 0.15, count = 15}
			}
		},
	}
end

function onUse(cid, item)
	local obj = protectedLevers[item.actionid]
	if not obj then
		return true
	end

	if getGameState() == GAMESTATE_STARTUP then
		doPlayerSendCancel(cid, 'Legendary levers have been disabled for serversave.')
		return true
	end
	loadLegendaryChances()
	legendLever:random(cid, obj, item)
	return true
end
