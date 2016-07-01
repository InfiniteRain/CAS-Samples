-------------------------------------------------------------------------------------------------
-- Simple understroyable objects script by Infinite Rain, based on a sample by Unreal Software --
-------------------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.understroyable = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.understroyable.hook = {
	objectdamage = function()
		-- No damage.
		return 1
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.understroyable.objectdamageHook = cas.hook.new("objectdamage", CSample.understroyable.hook.objectdamage)