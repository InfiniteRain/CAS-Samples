--------------------------------------------------------------------------------------
-- Simple spawn equip script by Infinite Rain, based on a sample by Unreal Software --
--------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.spawnEquip = {
	-- List of items the player shall spawn with.
	itemList = {cas.item.type.m3, cas.item.type.he}
}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.spawnEquip.hook = {
	-- On spawn hook, equips the items.
	spawn = function()
		return CSample.spawnEquip.itemList
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.spawnEquip.spawnHook = cas.hook.new("spawn", CSample.spawnEquip.hook.spawn)