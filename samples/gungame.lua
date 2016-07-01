-----------------------------------------------------------------------------------
-- Simple gun game script by Infinite Rain, based on a sample by Unreal Software --
-----------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.gunGame = {
	player = {},
	weapons = {
		cas.item.type.laser, 
		cas.item.type.rocketlauncher, 
		cas.item.type.grenadelauncher,
		cas.item.type.ak47, 
		cas.item.type.galil,
		cas.item.type.mp5, 
		cas.item.type.tmp, 
		cas.item.type.m3, 
		cas.item.type.p228, 
		cas.item.type.knife
	}
}

-- Game settings
cas.console.parse("sv_gamemode", 1)
cas.console.parse("mp_randomspawn", 1)
cas.console.parse("mp_infammo", 1)

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.gunGame.hook = {
	-- On join, creating a data table for this player.
	join = function(player)
		CSample.gunGame.player[player] = {
			kills = 0,
			level = 1
		}
	end,
	
	-- On leave, removing the data table of this player.
	leave = function(player)
		CSample.gunGame.player[player] = nil
	end,
	
	-- On startround, reset everyone's values.
	startround_prespawn = function(mode)
		for _, player in pairs(cas.player.getPlayers()) do
			CSample.gunGame.player[player].kills = 0
			CSample.gunGame.player[player].level = 1
		end
	end,
	
	spawn = function(player)
		-- Remove knife.
		player:strip(cas.item.type.knife)
		-- Equip with weapon for the current level.
		return CSample.gunGame.weapons[CSample.gunGame.player[player].level]
	end,
	
	kill = function(killer, victim, weapon, x, y, object)
		-- Add a kill to the killer.
		CSample.gunGame.player[killer].kills = CSample.gunGame.player[killer].kills + 1
		-- Check for the next level.
		if CSample.gunGame.player[killer].kills >= 3 then
			-- Reset kills.
			CSample.gunGame.player[killer].kills = 0
			-- Level up.
			CSample.gunGame.player[killer].level = CSample.gunGame.player[killer].level + 1
			-- Check for the win.
			if CSample.gunGame.player[killer].level > #CSample.gunGame.weapons then
				-- Congratulate the player.
				cas.game.messageToChat(cas.color.green, killer:getName() .." has won the game!")
				-- Restart the round.
				cas.console.parse("restart")
			else
				if killer:getHealth() > 0 then
					-- Equip the new weapon.
					killer:equip(CSample.gunGame.weapons[CSample.gunGame.player[killer].level])
					-- Strip the old one.
					killer:strip(CSample.gunGame.weapons[CSample.gunGame.player[killer].level - 1])
				end
			end
		end
		
		-- Display info.
		killer:messageToChat("Level: ".. CSample.gunGame.player[killer].level .."; kills: ".. CSample.gunGame.player[killer].kills)
	end,
	
	-- No buying.
	buy = function()
		return 1
	end,
	
	-- No collecting.
	walkover = function(player, item, itemType)
		if itemType:getType() >= 61 and itemType:getType() <= 68 then
			return 0
		end
		
		return 1
	end,
	
	-- No dropping.
	drop = function()
		return 1
	end,
	
	-- No death dropping.
	die = function()
		return 1
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.gunGame.joinHook = cas.hook.new("join", CSample.gunGame.hook.join)
CSample.gunGame.leaveHook = cas.hook.new("leave", CSample.gunGame.hook.leave)
CSample.gunGame.startround_prespawnHook = cas.hook.new("startround_prespawn", CSample.gunGame.hook.startround_prespawn)
CSample.gunGame.spawn = cas.hook.new("spawn", CSample.gunGame.hook.spawn)
CSample.gunGame.kill = cas.hook.new("kill", CSample.gunGame.hook.kill)
CSample.gunGame.buyHook = cas.hook.new("buy", CSample.gunGame.hook.buy)
CSample.gunGame.walkoverHook = cas.hook.new("walkover", CSample.gunGame.hook.walkover)
CSample.gunGame.dropHook = cas.hook.new("drop", CSample.gunGame.hook.drop)
CSample.gunGame.dieHook = cas.hook.new("die", CSample.gunGame.hook.die)