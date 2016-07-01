-----------------------------------------------------------------------------------
-- Simple hud text script by Infinite Rain, based on a sample by Unreal Software --
-----------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.hudText = {
	timer = 0
}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.hudText.hook = {	
	-- Second hook.
	second = function()
		CSample.hudText.timer = CSample.hudText.timer + 1
		if CSample.hudText.timer >= 5 then
			CSample.hudText.timer = 0
			collectgarbage() -- Since we did not save the instances of these hud texts, on garbage
							 -- collection cycle, they will be removed.
			for _, player in pairs(cas.player.getPlayers()) do
				cas.hudText.new(player, 320, 240, "center", cas.color.white, 
								"This is just a HUD Text sample! The text will fade to black!")
					:tweenColor(5000, cas.color.black)
				cas.hudText.new(player, 320, 260, "center", cas.color.yellow, "... and this text will become red!")
					:tweenColor(5000, cas.color.red)
				cas.hudText.new(player, 320, 280, "center", "this one will become invisible!")
					:tweenAlpha(5000, 0)
				cas.hudText.new(player, 320, 300, "center", "<-- go left")
					:tweenMove(5000, 220, 300)
				cas.hudText.new(player, 320, 320, "center", "go right -->")
					:tweenMove(5000, 420, 320)
				cas.hudText.new(player, 320, 340, "center", "go down")
					:tweenMove(5000, 320, 440)
			end
		end
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.hudText.secondHook = cas.hook.new("second", CSample.hudText.hook.second)