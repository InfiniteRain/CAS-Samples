---------------------------------------------------------------------------
-- Simple classes by Infinite Rain, based on a sample by Unreal Software --
---------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.classes = {}

-------------------
-- Initial setup --
-------------------

-- Table which will hold player data
CSample.classes.player = {}

-- Function which will open up the class selection menu.
function CSample.classes.showClassSelection(player)
	local menu = {
		title = "Select your class",
		
		buttons = {
			{
				caption = "Soldier",
				subcaption = "Armor+MG"
			},
			{
				caption = "Spy",
				subcaption = "Stealth"
			},
			{
				caption = "Engineer",
				subcaption = "Wrench",
				disabled = true
			},
			{
				caption = "Pyro",
				subcaption = "Flamethrower"
			},
			{
				caption = "Scout",
				subcaption = "Machete"
			},
			{
				caption = "Sniper",
				subcaption = "AWP"
			}
		}
	}
	
	player:openMenu(menu)
end

-----------------------------------------------------
-- Table which holds functions, later to be hooked --
-----------------------------------------------------
CSample.classes.hook = {
	-- On join, creating a data table for this player.
	join = function(player)
		CSample.classes.player[player] = {
			class = 1
		}
	end,
	
	-- On leave, removing the data table of this player.
	leave = function(player)
		CSample.classes.player[player] = nil
	end,
	
	-- On team change, opening the class selection menu (assuming the new team is not spectators).
	team = function(player, team)
		if team > 0 then
			CSample.classes.showClassSelection(player)
		end
	end,
	
	-- On server action, opening the class selection menu.
	serveraction = function(player, action)
		CSample.classes.showClassSelection(player)
	end,
	
	-- Handling the class selection.
	menu = function(player, title, button)
		if title == "Select your class" then
			if button >= 0 and button <= 6 then
				CSample.classes.player[player].class = button
				if player:getHealth() > 0 then
					player:kill()
				end
			end
		end
	end,
	
	-- Making the player spawn with the correct setup.
	spawn = function(player)
		if CSample.classes.player[player].class == 1 then
			-- Soldier.
			player:setMaxHealth(150)
			player:setArmor(202)
			player:setSpeed(-5)
			return "40,4,51"
		elseif CSample.classes.player[player].class == 2 then
			-- Spy.
			player:setMaxHealth(100)
			player:setArmor(206)
			player:setSpeed(5)
			return "21,1"
		elseif CSample.classes.player[player].class == 3 then
			-- Engineer
			player:setMaxHealth(100)
			player:setArmor(50)
			return "10,2,74"
		elseif CSample.classes.player[player].class == 4 then
			-- Pyro
			player:setMaxHealth(125)
			player:setArmor(75)
			return "46,6,73"	
		elseif CSample.classes.player[player].class == 5 then
			-- Scout.
			player:setMaxHealth(75)
			player:setArmor(0)
			player:setSpeed(15)
			return "5,69,54"
		elseif CSample.classes.player[player].class == 6 then
			-- Sniper.
			player:setMaxHealth(75)
			player:setArmor(25)
			return "35,3,53"
		end
	end,
	
	-- No buying.
	buy = function()
		return 1
	end,
	
	-- No collecting.
	walkover = function(player, item, itemType)
		if itemType:getType() >= 61 and itemType:getType() <= 68 then
			return 0
		end
		
		return 1
	end,
	
	-- No dropping.
	drop = function()
		return 1
	end,
	
	-- No death dropping.
	die = function()
		return 1
	end
}

------------------------------------
-- Hooking the declared functions --
------------------------------------
CSample.classes.joinHook = cas.hook.new("join", CSample.classes.hook.join)
CSample.classes.leaveHook = cas.hook.new("leave", CSample.classes.hook.leave)
CSample.classes.teamHook = cas.hook.new("team", CSample.classes.hook.team)
CSample.classes.serveractionHook = cas.hook.new("serveraction", CSample.classes.hook.serveraction)
CSample.classes.menuHook = cas.hook.new("menu", CSample.classes.hook.menu)
CSample.classes.spawnHook = cas.hook.new("spawn", CSample.classes.hook.spawn)
CSample.classes.buyHook = cas.hook.new("buy", CSample.classes.hook.buy)
CSample.classes.walkoverHook = cas.hook.new("walkover", CSample.classes.hook.walkover)
CSample.classes.dropHook = cas.hook.new("drop", CSample.classes.hook.drop)
CSample.classes.dieHook = cas.hook.new("die", CSample.classes.hook.die)
