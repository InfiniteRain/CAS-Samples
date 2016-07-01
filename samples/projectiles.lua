-------------------------------------------------------------------------------------
-- Simple projectile script by Infinite Rain, based on a sample by Unreal Software --
-------------------------------------------------------------------------------------
if not CSample then
	require("sys/lua/CS2D-AmplifiedScripting")
	CSample = {}
end
CSample.projectiles = {}

------------------------------------------------------
-- Table which holds a function, later to be hooked --
------------------------------------------------------
CSample.projectiles.hook = {
	-- On serveraction, spawn projectiles.
	serveraction = function(player, action)
		if player:getTeam() > 0 then
			if action == 1 then
				for i = 0, 315, 45 do
					cas.projectile.spawn(
						player,
						cas.item.type.he,
						player:getX(),
						player:getY(),
						200,
						i)
				end
			elseif action == 2 then
				for i = 0, 315, 45 do
					cas.projectile.spawn(
						player,
						cas.item.type.getInstance(math.random(1, 6)),
						player:getX(),
						player:getY(),
						200,
						i)
				end
			elseif action == 3 then
				for i = 0, 315, 45 do
					cas.projectile.spawn(
							player,
							cas.item.type.rpglauncher,
							player:getX(),
							player:getY(),
							500,
							i)
				end
			end
		end
	end
}

-----------------------------------
-- Hooking the declared function --
-----------------------------------
CSample.projectiles.serveractionHook = cas.hook.new("serveraction", CSample.projectiles.hook.serveraction)