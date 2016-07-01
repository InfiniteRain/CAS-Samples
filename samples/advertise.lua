---------------------------------------------------------------------------------
-- Simple advertising by Infinite Rain, based on the sample by Unreal Software --
---------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.advertisiment = {}

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.advertisiment.hook = {
	-- On join. Displays welcome message.
	join = function(player)
		player:messageToChat("Welcome to my server, ".. player:getName() .."!")
	end,
	
	-- Every minute. Displays advertisiment message.
	minute = function()
		cas.game.messageToChat("This server is powered by:")
		cas.game.messageToChat("www.UnrealSoftware.de & www.CS2D.com")
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.advertisiment.joinHook = cas.hook.new("join", CSample.advertisiment.hook.join)
CSample.advertisiment.minuteHook = cas.hook.new("minute", CSample.advertisiment.hook.minute)