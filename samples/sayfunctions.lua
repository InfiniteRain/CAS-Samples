----------------------------------------------------------------------------------------
-- Simple say functions script by Infinite Rain, based on a sample by Unreal Software --
----------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.sayFunctions = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.sayFunctions.hook = {
	-- On say, check for say functions.
	say = function(player, text)
		if text == "time" then
			player:messageToChat(os.date("Time: %I:%M %p"))
		elseif text == "date" then
			player:messageToChat(os.date("Date: %A, %d %b %Y"))
		elseif text == "slap me" then
			player:slap()
		elseif text == "idlers" then
			local idlerFound = false
			for _, idler in pairs(player:getLivingPlayers()) do
				if idler:getIdleTime() > 10 then
					player:messageToChat(idler:getName() .. " is idle for " .. idler:getIdleTime() .." second!")
					idlerFound = true
				end
			end
			
			if not idlerFound then
				player:messageToChat("No idlers were found!")
			end
		elseif text == "the way" then
			player:playSound("fun/thats_the_way.wav")
		elseif text == "lets go" then
			player:playSound("hostage/hos2.wav")
		elseif text == "zombies!" then
			player:playSound("player/zm_spray.wav")
		elseif text == "mystery" then
			player:playSound("env/mystery.wav")
		end
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.sayFunctions.sayHook = cas.hook.new("say", CSample.sayFunctions.hook.say)