----------------------------------------------------------------------------------
-- Simple hitzone script by Infinite Rain, based on a sample by Unreal Software --
----------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.hitzone = {
	image = false
}

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.hitzone.hook = {
	-- Dispose of the image instance on round start.
	startround = function(mode)
		CSample.hitzone.image = false
	end,
	
	-- Summons the image on serveraction.
	serveraction = function(player, action)
		-- Summons/creates the image.
		if not CSample.hitzone.image then
			CSample.hitzone.image = cas.mapImage.new("gfx/cs2d.bmp", "floor")
				:setPosition(player:getX(), player:getY()) -- Sets position.
				:setHitzone(true, "greenblood", -92/2, -92/2, 92, 92) -- Sets hitzone.
		else
			if CSample.hitzone.image:isTweenMove() then
				CSample.hitzone.image:stopTweenMove()
			end
		
			CSample.hitzone.image:setPosition(player:getX(), player:getY())
		end
		
		-- Moves the image.
		CSample.hitzone.image:tweenMove(5000, player:getX() + 300, player:getY() + 300)
	end,
	
	-- On hitzone damage.
	hitzone = function(image, player, object, weapon, x, y)
		-- Displaying info.
		cas.game.messageToChat("Hit ".. tostring(image) .." (pl:".. player:getName() .." obj:".. (object and object:getTypeName() or "false")
							 .." wpn:".. weapon:getName() .." @ ".. x ..",".. y ..")")
		-- Fire on hit.
		cas.game.fireEffect(x, y, 5, 3)
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.hitzone.startroundHook = cas.hook.new("startround", CSample.hitzone.hook.startround)
CSample.hitzone.serveractionHook = cas.hook.new("serveraction", CSample.hitzone.hook.serveraction)
CSample.hitzone.hitzoneHook = cas.hook.new("hitzone", CSample.hitzone.hook.hitzone)

