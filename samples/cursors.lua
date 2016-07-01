---------------------------------------------------------------------------------
-- Simple cursor script by Infinite Rain, based on a sample by Unreal Software --
---------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.cursor = {
	updateRate = 150,
	player = {}
}

--------------------------------------
-- Timer which requests client data --
--------------------------------------
CSample.cursor.timer = cas.timer.new(function()
	for _, player in pairs(cas.player.getPlayers()) do
		player:requestClientData("cursoronmap")
	end
end):startConstantly(CSample.cursor.updateRate)

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.cursor.hook = {
	-- On join, creating a data table for this player.
	join = function(player)
		CSample.cursor.player[player] = {
			cursor = cas.mapImage.new("gfx/sprites/flare2.bmp", "supertop")
				:setColor(cas.color.yellow)
				:setBlend("light")
				:setAlpha(0.5)
				:setScale(0.3, 0.3)
		}
	end,
	
	-- On leave, removing the data table of this player.
	leave = function(player)
		CSample.cursor.player[player] = nil
	end,
	
	-- On startround, since all the images are removed, re-drawing them.
	startround = function(mode)
		for key, value in pairs(cas.player.getPlayers()) do
			CSample.cursor.player[value].cursor = cas.mapImage.new("gfx/sprites/flare2.bmp", "supertop")
				:setColor(cas.color.yellow)
				:setBlend("light")
				:setAlpha(0.5)
				:setScale(0.3, 0.3)
		end
	end,
	
	clientdata = function(player, mode, data1, data2)
		if mode == "cursoronmap" then
			if not player:isBot() then
				if CSample.cursor.player[player].cursor:isTweenMove() then
					CSample.cursor.player[player].cursor:stopTweenMove()
				end
				
				CSample.cursor.player[player].cursor:tweenMove(CSample.cursor.updateRate, data1, data2)
			end
		end
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.cursor.hook.joinHook = cas.hook.new("join", CSample.cursor.hook.join)
CSample.cursor.hook.leaveHook = cas.hook.new("leave", CSample.cursor.hook.leave)
CSample.cursor.hook.startroundHook = cas.hook.new("startround", CSample.cursor.hook.startround)
CSample.cursor.hook.clientdataHook = cas.hook.new("clientdata", CSample.cursor.hook.clientdata)