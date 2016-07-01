------------------------------------------------------------------------------------------
-- Simple registered only script by Infinite Rain, based on a sample by Unreal Software --
------------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.regonly = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.regonly.hook = {
	-- On team join, check if the player is registered.
	team = function(player, team)
		if team > 0 then
			if not player:getUSGN() then
				player:messageToChat(cas.color.red, "Only registered users are allowed to join a team on this server!@C")
				player:messageToChat(cas.color.red, "Please login or register!@C")
				
				return 1
			end
		end
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.regonly.teamHook = cas.hook.new("team", CSample.regonly.hook.team)