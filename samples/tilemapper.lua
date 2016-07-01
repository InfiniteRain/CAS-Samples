--------------------------------------------------------------------------------------
-- Simple tile mapper script by Infinite Rain, based on a sample by Unreal Software --
--------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.tileMapper = {
	player = {}
}

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.tileMapper.hook = {
	-- On join, creating a data table for this player.
	join = function(player)
		CSample.tileMapper.player[player] = {
			frame = 0,
			x = 0,
			y = 0,
			mode = 0,
			infoHudText = cas.hudText.new(
				player, 
				5, 
				105, 
				"left", 
				cas.color.white,
				"Info: ", 
				cas.color.blue,
				"[F2] - Set tile [F3] - Pick tile [F4] - Get tile info")
		}
		
	end,
	
	-- On leave, removing the data table of this player.
	leave = function(player)
		CSample.tileMapper.player[player] = nil
	end,
	
	-- On serveraction, request client data and change modes.
	serveraction = function(player, action)
		if action == 1 then
			CSample.tileMapper.player[player].mode = 0
		elseif action == 2 then
			CSample.tileMapper.player[player].mode = 1
		elseif action == 3 then
			CSample.tileMapper.player[player].mode = 2
		end
		
		player:requestClientData("cursoronmap")
	end,
	
	-- On clientdata reception, perform actions.
	clientdata = function(player, mode, data1, data2)
		if mode == "cursoronmap" then
			local tileX, tileY = math.floor(data1 / 32), math.floor(data2 / 32)
			if tileX >= 0 and tileY >= 0 and tileX <= cas.map.getXSize() and tileY <= cas.map.getYSize() then
				-- Set tile.
				if CSample.tileMapper.player[player].mode == 0 then
					cas.tile.setTile(tileX, tileY, CSample.tileMapper.player[player].frame)
					player:messageToChat("Changed tile at " .. tileX .."|".. tileY ..".")
				-- Pick tile. 
				elseif CSample.tileMapper.player[player].mode == 1 then
					CSample.tileMapper.player[player].frame = cas.tile.getFrame(tileX, tileY)
					player:messageToChat("Tile frame is now ".. CSample.tileMapper.player[player].frame)
				-- Display tile info.
				elseif CSample.tileMapper.player[player].mode == 2 then
					-- Removing the old text.
					if CSample.tileMapper.player[player].tileInfoHudText then
						CSample.tileMapper.player[player].tileInfoHudText:free()
					end
					
					-- Showing the text on screen.
					CSample.tileMapper.player[player].tileInfoHudText = cas.hudText.new(
						player,
						5,
						125,
						"left",
						cas.color.white,
						"Tile on ".. tileX .."|".. tileY .." info: ",
						cas.color.blue,
						"frame: ".. cas.tile.getFrame(tileX, tileY) .." prop: ".. cas.tile.getProperty(tileX, tileY) 
					    .." custom frame: ".. tostring(cas.tile.isChanged(tileX, tileY)) .." original frame: "
						.. cas.tile.getOriginalFrame(tileX, tileY))
				end
			end
		end
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.tileMapper.joinHook = cas.hook.new("join", CSample.tileMapper.hook.join)
CSample.tileMapper.leaveHook = cas.hook.new("leave", CSample.tileMapper.hook.leave)
CSample.tileMapper.serveractionHook = cas.hook.new("serveraction", CSample.tileMapper.hook.serveraction)
CSample.tileMapper.clientdataHook = cas.hook.new("clientdata", CSample.tileMapper.hook.clientdata)