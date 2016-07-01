------------------------------------------------------------------------------------
-- Simple console commands by Infinite Rain, based on a sample by Unreal Software --
------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.console = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.console.hook = {
	parse = function(text)
		if text == "myserverinfo" then
			-- My server info.
			cas.console.print("Server name: ".. cas.game.getSetting("sv_name"))
			cas.console.print("Max players: ".. cas.game.getSetting("sv_maxplayers"))
			
			return 2
		elseif text == "healthlist" then
			-- Health list.
			for _, player in pairs(cas.player.getPlayers()) do
				local health = player:getHealth()
				local color
				
				if health > 90 then
					color = cas.color.green
				elseif health > 60 then
					color = cas.color.yellow
				elseif health > 30 then
					color = cas.color.orange
				else
					color = cas.color.red
				end
				
				cas.console.print("Health of ".. player:getName() ..": ".. health, color)
			end
			
			return 2
		elseif text == "encage" then
			cas.game.messageToChat(cas.color.red, "ENCAGING ALL PLAYERS!!!@C")
			for _, player in pairs(cas.player.getLivingPlayers()) do
				local px, py = player:getTilePosition()
				for x = -1, 1 do
					for y = -1, 1 do
						if not (x == 0 and y == 0) then
							cas.dynObject.type.barbedwire:spawn(px + x, py + y, 1, 0, false)
						end
					end
				end
			end
			
			return 2
		elseif text == "getentitylist" then
			for _, entity in pairs(cas.entity.getEntities()) do
				cas.console.print("Entity at ".. entity:getX() .."|".. entity:getY() .." - ".. entity:getTypeName())
			end
			
			return 2
		elseif text == "getprojectilelist" then
			cas.console.print("Flying projectiles:")
			for _, projectile in pairs(cas.projectile.getProjectiles("flying")) do
				print("Projectile of player ".. projectile.player:getName() .." with ID of ".. projectile.id
					.." is at ".. cas.projectile.getInfo(projectile.player, projectile.id, "x")
					.."|".. cas.projectile.getInfo(projectile.player, projectile.id, "y"))
			end
			cas.console.print("Ground projectiles:")
			for _, projectile in pairs(cas.projectile.getProjectiles("ground")) do
				print("Projectile of player ".. projectile.player:getName() .." with ID of ".. projectile.id
					.." is at ".. cas.projectile.getInfo(projectile.player, projectile.id, "x")
					.."|".. cas.projectile.getInfo(projectile.player, projectile.id, "y"))
			end
			
			return 2
		end
		
		return 0
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.console.parseHook = cas.hook.new("parse", CSample.console.hook.parse)