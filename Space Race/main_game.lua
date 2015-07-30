local composer = require( "composer" )
local physics = require "physics"

local scene = composer.newScene()

--ship stats
local max_health = 50
local current_health = max_health

local max_shields = 10
local current_shields = 0--max_shields

local shield_repair_rate = 0.05
local shield_repair_bonus = 0




--Scenary  start speeds
local backgroundSpeed = 1.6
local maxBackgroundSpeed = 10
local closePlanetSpeed = 2.0
local distantPlanetSpeed = 1.0 
local closeStarSpeed = 1.8
local distantStarSpeed = 1.2

local obstacle_speed = 5.3
local max_obstacle_speed = 12.0

--scenary multipliers and limits
local closePlanetRate = closePlanetSpeed / backgroundSpeed
local distantPlanetRate = distantPlanetSpeed / backgroundSpeed
local closeStarRate = closeStarSpeed / backgroundSpeed
local distantStarRate = distantStarSpeed / backgroundSpeed


--spawn rates in milliseconds
local minimum_spawn_time = 120
local maximum_spawn_variance = 40

local fastest_spawn_time = 20
local fastest_spawn_variance = 20

--background visual limits
local maxDistantPlanets = 2
local maxClosePlanets = 1
local maxDistantStars = 3
local maxCloseStars = 10

local minBackgroundRange = 0
local maxBackgroundRange = 220

--obstacle limits
local maxValkyries = 7

local enemy_sway_rate = 0.15
local enemy_sway = 10


local check = 0
local obstacleMinRange = 52
local obstacleMaxRange = 225
local obstacleStartHeight

--containers to reuse objects
local enemy_ships = display.newGroup()
local obstacles = display.newGroup()
local player_group = display.newGroup()
local closeStars = display.newGroup()
local farStars = display.newGroup()
local closePlanets = display.newGroup()
local farPlanets = display.newGroup()
local hudGroup = display.newGroup()


--stat multipliers
local enemy_health_modifier = 1.0
local enemy_speed_modifier = 1.0


--hud variables
local healthBar
local damageBar
local shieldBar
local shieldDamageBar



local scoreText

local testTxt = "enemy"

--graphical

--[[
  May instead change the space background to be plain black and spawn celestial objects to
  generate background procedurally
--]]
local space_bg1
local space_bg2
local space_bg3
local pause_shade

local player_ship
local player_shield

--game values
local distance_traveled = 0
local enemies_destroyed = 0
local ingame_currency_obtained = 0
local paid_currency_obtained = 0
local game_difficulty = 0
local currency_chance = .05
local power_up_chance = .01

local isHeld = false
local isDip = false
local touchY = (display.contentHeight / 2)
local lastDirection = "none"
local maxVelocity = 200
local dipVelocity = 32

local mRand = math.random
local mSin = math.sin
system.setAccelerometerInterval(100)



local scrollBackground = function()
   space_bg1.x = space_bg1.x - backgroundSpeed
   space_bg2.x = space_bg2.x - backgroundSpeed
   space_bg3.x = space_bg3.x - backgroundSpeed
   
   if(space_bg1.x <= -300) then space_bg1.x = space_bg3.x + 570 end
   if(space_bg2.x <= -300) then space_bg2.x = space_bg1.x + 570 end
   if(space_bg3.x <= -300) then space_bg3.x = space_bg2.x + 570 end
   
   if backgroundSpeed < maxBackgroundSpeed then
      backgroundSpeed = backgroundSpeed + 0.0025
      if backgroundSpeed > maxBackgroundSpeed then backgroundSpeed = maxBackgroundSpeed end
	  
	  --set speeds of background objects relative to this speed
	  distantPlanetSpeed = backgroundSpeed * distantPlanetRate
	  closePlanetSpeed = backgroundSpeed * closePlanetRate
	  distantStarSpeed = backgroundSpeed * distantStarRate
	  closeStarSpeed = backgroundSpeed * closeStarRate
	  
   end
   
   
end

local warpZones = function()
	--randomly determine a zone
	
	--animate the ship warp
	
	--blind the screen
	
	--remove event listener to scroll background items
	
	--change zone backgrounds
	
	--change zone enemy list
	
	--change planet/stars list
	
	--add event listener to scroll background items
	
	--unblind screen
	
	--warp in
	
end

local gainCurrency = function()

end

local gainExperience = function()

end

local updateDistanceTraveled = function()

end


local takeDamage = function()

end




-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	
	print("entering space race loading Screen")
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		composer.removeScene("quatro_gato_screen")
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
		
		
		
		local createBackgroundItems = function()
			space_bg1 = display.newImage("space_bg1.png")
			--space_bg1.alpha = 0.0
			sceneGroup:insert(space_bg1)
			space_bg1.x = display.contentWidth / 2
			space_bg1.y = display.contentHeight / 2
			
			space_bg2 = display.newImageRect("space_bg2.png", 570, 380)
			--space_bg2.alpha = 0.0
			sceneGroup:insert(space_bg2)
			space_bg2.x = space_bg1.x + 570
			space_bg2.y = display.contentHeight / 2
			
			
			space_bg3 = display.newImageRect("space_bg3.png", 570, 380)
			--space_bg3.alpha = 0.0
			sceneGroup:insert(space_bg3)
			space_bg3.x = space_bg1.x - 570 
			space_bg3.y = display.contentHeight / 2
		
			
			sceneGroup:insert(farStars)
			sceneGroup:insert(farPlanets)
			sceneGroup:insert(closePlanets)
			sceneGroup:insert(closeStars)
			sceneGroup:insert(player_group)
			sceneGroup:insert(enemy_ships)
			sceneGroup:insert(obstacles)
			sceneGroup:insert(hudGroup)
		end
		
		local hud = function()
			healthBar = display.newRoundedRect(0, 30, max_health, 10, 0.9)
			healthBar.x = 30 + healthBar.width / 2
			
			healthBar:setFillColor( 50/255, 150/255, 2000/255 )
			healthBar.strokeWidth = 1
			healthBar.anchorX = 1.0
			healthBar:setStrokeColor( 255, 255, 255, .5 )
			
			damageBar = display.newRect(0, 30, 0, 10, 0)
			damageBar.x = healthBar.x
			damageBar.anchorX = 1
			damageBar:setFillColor( 255/255, 0/255, 0/255 )
			
			
			hudGroup:insert(healthBar)
			hudGroup:insert(damageBar)
			
		end
		
		local updateDamageBars = function()
			--recovery of shields
			current_shields = current_shields + shield_repair_rate + shield_repair_bonus
			
			
			if current_shields > max_shields  then
				current_shields = max_shields
			end
			
			if current_health > max_health  then
				current_health = max_health
			end
			
			damageBar.x = healthBar.x
			damageBar.width = max_health - current_health
			
			
			player_shield.alpha = (current_shields / max_shields) * (3/5)
		end
		
		
		
		local updateObstacles = function()
		  for a = 1, enemy_ships.numChildren, 1 do
			if enemy_ships[a].isActive then
				enemy_ships[a].steps = enemy_ships[a].steps + enemy_sway_rate
				enemy_ships[a].y = enemy_ships[a].startY + (enemy_sway * mSin(enemy_ships[a].steps))
				enemy_ships[a].x = enemy_ships[a].x - obstacle_speed
				
				if enemy_ships[a].x < -80 then
					enemy_ships[a].x = display.contentWidth + 80
				end
			end
		  end
		end
		
		
		
		
		
		
		
		local createPlayer = function()
		--create thruster here
		
		--create ship here
			player_ship = display.newImage("ship.png")
			player_ship.anchorX = 0.5; player_ship.anchorY = 0.5
			player_ship.x = 20
			player_ship.y =  display.contentHeight - 35 - (player_ship.height / 2)
			player_ship.myName = "player_ship"
			player_group:insert(player_ship)
			
			physics.addBody(player_ship, "dynamic", {density = 1.0,
		 bounce = 0.4, friction = 0.15,})
			
			
			--create shield here
			player_shield = display.newImage("shield.png")
			player_shield.anchorX = player_ship.anchorX
			player_shield.anchorY = player_ship.anchorY
			player_shield.x = player_ship.x
			player_shield.y = player_ship.y
			player_shield.myName = "player_shield"
			player_shield.alpha = 0.0
			player_group:insert(player_shield)
			
		end
		
		local spawnEnemy = function(enemyType)
			local enemy_ship
			obstacleStartHeight = obstacleMinRange + mRand(obstacleMaxRange)
			if enemyType == "valkyrie" then
				enemy_ship = display.newImage("valkyrie.png")
				enemy_ship.x = display.contentWidth - 20
				enemy_ship.y = obstacleStartHeight
				enemy_ship.startY = enemy_ship.y 
				
				enemy_ship.xScale = -1
				enemy_ship.isActive = true
				enemy_ship.steps = 0
				enemy_ship.myName = enemyType
				enemy_ships:insert(enemy_ship)
				physics.addBody(enemy_ship, "static", {density = 1.0,
				  bounce = 0.4, friction = 0.15,})
				  
				enemy_ship.isSensor = true
			end
			
		end
		
		local spawnObstacle = function()
			--determine objectType randomly
			local objectType = "enemy"
		   obstacleStartHeight = obstacleMinRange + mRand(obstacleMaxRange)
		   if objectType == "enemy" then
				--determine enemy at random
				objectType = "valkyrie"
				spawnEnemy(objectType)
		   elseif objectType == "comet" then
		   
		   end
		end
		
		
		
		local spawnBackgroundObject = function(objectType)
			
		end
		
		
		local setupObstacles = function()
			for count = 1, maxValkyries, 1 do
				spawnEnemy("valkyrie")
			end
		end
		
		
		local gameObjectSpawner = function(obstacleType)
			check = check + 1
			
			local checkValue = minimum_spawn_time + mRand(maximum_spawn_variance)
			
			if check >= checkValue then
				check = 0

				if minimum_spawn_time > fastest_spawn_time then
				   minimum_spawn_time = minimum_spawn_time - 0.6
				   if minimum_spawn_time < fastest_spawn_time then
						minimum_spawn_time = fastest_spawn_time 
				   end
				end
				
				if minimum_spawn_time == fastest_spawn_time then
					if maximum_spawn_variance > fastest_spawn_variance then
						maximum_spawn_variance = maximum_spawn_variance - 1
					end
				end
				
				if obstacle_speed < max_obstacle_speed then
				   obstacle_speed = obstacle_speed + 0.05
				   if obstacle_speed > max_obstacle_speed then
						obstacle_speed = max_obstacle_speed
				   end
				end
				
			end
			
			
			
			scoreText.text = obstacle_speed
			if minimum_spawn_time == fastest_spawn_time then
				scoreText.text = "MAX SPEED"
			end
			
		end
		
		
		local function checkPress(event)
			
			if event.phase == "began" and event.x < display.contentWidth / 2.0 then
				isHeld = true
			elseif event.phase == "ended" then
				isHeld = false
			end
			
		end
		
		local movePlayer = function()
			local xForce = 0
			local yForce = 0
			local vx, vy = player_ship:getLinearVelocity()
			
			
			
			if isHeld then
				
				
				yForce = -2.7
				if player_ship.y < 80 then
					yForce = 0.6
				end
				
				--player_ship:applyForce(0, yForce, player_ship.x, player_ship.y)
				player_ship:applyLinearImpulse( 0, yForce, player_ship.x, player_ship.y )
				
				if vy < maxVelocity * -1 then
					if isDip then
						player_ship:setLinearVelocity(0, (dipVelocity * -1))
					else
						player_ship:setLinearVelocity(0, (maxVelocity * -1))
					end
				end
				
				
			else
				if vy > maxVelocity then
					if isDip then 
						player_ship:setLinearVelocity(0, dipVelocity)
					else
						player_ship:setLinearVelocity(0, maxVelocity)
					end
				elseif vy < dipVelocity * -1 then
					--player_ship:setLinearVelocity(0, dipVelocity * -1)
				end	
				
			end
			
			
			
			
			if player_ship.y > display.contentHeight - (player_ship.height / 2) - 30 then
				if vy > dipVelocity then
					player_ship:applyForce(0, -140, player_ship.x, player_ship.y)
				end
				player_ship:applyForce(0, -18, player_ship.x, player_ship.y)
				
			elseif player_ship.y < 70  then
				if vy < dipVelocity * -1 then
					player_ship:applyForce(0, 150, player_ship.x, player_ship.y)
				end
				player_ship:applyForce(0, -25, player_ship.x, player_ship.y)
			else
			    local playerY = player_ship.y
				if playerY <= 0 then playerY = 0.1 end
				
				--local newGrav = 5 - (5 * (playerY / (display.contentHeight)))
				--physics.setGravity(0, newGrav)
				
				player_ship.gravityScale = 1 - (playerY / (display.contentHeight))
			end
			
			player_shield.x = player_ship.x
			player_shield.y = player_ship.y
		end
		
		local options = {
		   effect = "fade",
		   time = 1000
		}
		
		local gotoGameOver = function()
		  
		end
		
		local gameStart = function()
		   createBackgroundItems()
		   physics.start(true)
		   createPlayer()
		   player_ship.gravityScale = 0
		   
		   physics.setGravity(0, 9.8)
		   
		   
		   hud()
		   setupObstacles()
		   
		   
		   updateObstacles()
		   
		   Runtime:addEventListener( "enterFrame", scrollBackground )
		   
		   
		   Runtime:addEventListener("touch", checkPress)
		   Runtime:addEventListener("enterFrame", movePlayer)
		   Runtime:addEventListener("enterFrame", gameObjectSpawner)
		   Runtime:addEventListener("enterFrame", updateDamageBars)
		   Runtime:addEventListener("enterFrame", updateObstacles)
		   
		   
		end
		gameStart()
		scoreText = display.newText( "Score: " .. 5, 0, 0, "Arial", 45)
		   scoreText:setTextColor(255, 255, 255, 255)
		   scoreText.xScale = 0.5; scoreText.yScale = 0.5
		   scoreText.x = (scoreText.contentWidth * 0.5) + 15
		   scoreText.y = 15
		   sceneGroup:insert(scoreText)
		
		
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
		
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
	
	Runtime:removeEventListener( "enterFrame", scrollBackground )
	
	print("destroying  space race loading Screen")
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene