--------------------------------------------------------------------------------
-- Simple tween script by Infinite Rain, based on a sample by Unreal Software --
--------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.tween = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.tween.hook = {
	-- After each second, perform tween action.
	second = function()
		-- If the image wasn't yet loaded, then load the image.
		if not CSample.tween.image then
			CSample.tween.image = cas.mapImage.new("gfx/sprites/flare2.bmp", "supertop")
				:setColor(cas.color.yellow)
				:setBlend("light")
				:tweenRotateConstantly(5)
		end
		
		if cas.player.idExists(1) then
			local player = cas.player.getInstance(1)
			if player:getHealth() > 0 then
				-- Stopping the tween functions before starting them again.
				if CSample.tween.image:isTweenMove() then
					CSample.tween.image:stopTweenMove()
				end
				if CSample.tween.image:isTweenColor() then
					CSample.tween.image:stopTweenColor()
				end
				if CSample.tween.image:isTweenScale() then
					CSample.tween.image:stopTweenScale()
				end
				
				-- Initiating the tween functions.
				CSample.tween.image
					:tweenMove(1000, player:getX(), player:getY())
					:tweenColor(1000, cas.color.new(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
					:tweenScale(1000, math.random(1,3)/2.0, math.random(1,3)/2.0)
			end
		end
	end,
	
	-- On start round, dispose of unneeded image object.
	startround = function()
		CSample.tween.image = nil
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.tween.secondHook = cas.hook.new("second", CSample.tween.hook.second)
CSample.tween.startroundHook = cas.hook.new("startround", CSample.tween.hook.startround)