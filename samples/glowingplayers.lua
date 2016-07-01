----------------------------------------------------------------------------
-- Glowing players by Infinite Rain, based on a sample by Unreal Software --
----------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.glowingPlayers = {
	imageIDs = {}
}

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.glowingPlayers.hook = {
	-- On startround, refresh every glowing image.
	startround = function(mode)
		CSample.glowingPlayers.imageIDs = {}
		for _, player in pairs(cas.player.getPlayers()) do
			table.insert(
				CSample.glowingPlayers.imageIDs, 
				cas.playerImage.new("gfx/sprites/flare2.bmp", "floor", player)
					:setColor(cas.color.yellow)
					:setBlend("light")
					:setAlpha(0.5))
		end
	end,
	
	-- On join, give the player a glowing image.
	join = function(player)
		table.insert(
				CSample.glowingPlayers.imageIDs, 
				cas.playerImage.new("gfx/sprites/flare2.bmp", "floor", player)
					:setColor(cas.color.yellow)
					:setBlend("light")
					:setAlpha(0.5))
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.glowingPlayers.startroundHook = cas.hook.new("startround", CSample.glowingPlayers.hook.startround)
CSample.glowingPlayers.joinHook = cas.hook.new("join", CSample.glowingPlayers.hook.join)
