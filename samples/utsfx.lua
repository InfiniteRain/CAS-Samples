-----------------------------------------------------------------------------------
-- Simple UT+Quake sounds by Infinite Rain, based on a sample by Unreal Software --
-----------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.utsfx = {
	player = {},
	firstBlood = false
}

-------------------------------------------------------
-- Table which holds a functions, later to be hooked --
-------------------------------------------------------
CSample.utsfx.hook = {
	-- On join, creating a data table for this player.
	join = function(player)
		CSample.utsfx.player[player] = {
			timer = 0,
			level = 0
		}
	end,
	
	-- On leave, removing the data table of this player.
	leave = function(player)
		CSample.utsfx.player[player] = nil
	end,
	
	kill = function(killer, victim, weapon)
		-- Was last kill more than 3 secs ago?
		if os.clock() - CSample.utsfx.player[killer].timer > 3 then
			-- Yes, more than 3 secs ago! Reset level!
			CSample.utsfx.player[killer].level = 0
		end
		
		-- Increase the level of the killer.
		CSample.utsfx.player[killer].level = CSample.utsfx.player[killer].level + 1
		-- Reset the timer.
		CSample.utsfx.player[killer].timer = os.clock()
		
		-- First blood.
		if not CSample.utsfx.firstBlood then
			CSample.utsfx.firstBlood = true
			cas.game.playSound("fun/firstblood.wav")
			cas.game.messageToChat(killer:getName() .. " sheds FIRST BLOOD by killing ".. victim:getName() .."!")
		end
		
		-- Humilation.
		local level = CSample.utsfx.player[killer].level
		if weapon == cas.item.type.knife then
			cas.game.playSound("fun/humiliation.wav")
			cas.game.messageToChat(killer:getName() .. " HUMILATED ".. victim:getName())
		else
			if level == 2 then
				cas.game.playSound("fun/doublekill.wav")
				cas.game.messageToChat(killer:getName() .. " has made a DOUBLE KILL!")
			elseif level == 3 then
				cas.game.playSound("fun/multikill.wav")
				cas.game.messageToChat(killer:getName() .. " has made a MULTI KILL!")
			elseif level == 4 then
				cas.game.playSound("fun/ultrakill.wav")
				cas.game.messageToChat(killer:getName() .. " has made an ULTRA KILL!")
			elseif level == 5 then
				cas.game.playSound("fun/monsterkill.wav")
				cas.game.messageToChat(killer:getName() .. " has made an MO-O-O-O-ONSTERKILL-ILL-ILL!")
			elseif level > 5 then
				cas.game.playSound("fun/unstoppable.wav")
				cas.game.messageToChat(killer:getName() .. " is UNSTOPPABLE!")
			end
		end
	end,
	
	startround = function(mode)
		-- Prepare to fight sound on startround.
		cas.game.playSound("fun/prepare.wav")
		CSample.utsfx.firstBlood = false
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.utsfx.joinHook = cas.hook.new("join", CSample.utsfx.hook.join)
CSample.utsfx.leaveHook = cas.hook.new("leave", CSample.utsfx.hook.leave)
CSample.utsfx.killHook = cas.hook.new("kill", CSample.utsfx.hook.kill)
CSample.utsfx.startroundHook = cas.hook.new("startround", CSample.utsfx.hook.startround)