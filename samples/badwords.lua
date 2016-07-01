------------------------------------------------------------------------------------
-- Simple bad words filter by Infinite Rain, based on a sample by Unreal Software --
------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.badWords = {}

---------------------------------------------------
-- List of the bad words which shall be filtered --
---------------------------------------------------
CSample.badWords.words = {
	"hitler",
	"fuck",
	"bitch",
	"cunt",
	"ass",
	"whore",
	"nigger",
	"shit"
}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.badWords.hook = {
	-- Filter the bad words.
	say = function(player, text)
		for _, badWord in pairs(CSample.badWords.words) do
			if string.find(string.lower(text), string.lower(badWord)) ~= nil then
				cas.game.messageToChat(player:getName() .." said a bad word!")
				player:kick("Said a bad word.")
				break
			end
		end
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.badWords.sayHook = cas.hook.new("say", CSample.badWords.hook.say)