---------------------------------------------------------------------------------------
-- Simple fast players script by Infinite Rain, based on a sample by Unreal Software --
---------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.fastPlayers = {}

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.fastPlayers.hook = {
	spawn = function(player)
		player:setSpeed(15)
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.fastPlayers.spawnHook = cas.hook.new("spawn", CSample.fastPlayers.hook.spawn)