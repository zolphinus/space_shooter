local composer = require( "composer" )

local scene = composer.newScene()

--Scenary speeds
local backgroundSpeed = 1.5
local closePlanetSpeed = 1.7
local distantPlanetSpeed = 1.0 
local closeStarSpeed = 1.8
local distantStarSpeed = 1.2

--graphical

--[[
  May instead change the space background to be plain black and spawn celestial objects to
  generate background procedurally
--]]
local space_bg1
local space_bg2
local space_bg3
local shade

local player_ship

--game values
local distance_traveled = 0
local enemies_destroyed = 0
local currency_obtained = 0
local game_difficulty = 0

local mRand = math.random
system.setAccelerometerInterval(100)

local changeTimer
local scrollBackground = function()
   space_bg1.x = space_bg1.x - backgroundSpeed
   space_bg2.x = space_bg2.x - backgroundSpeed
   space_bg3.x = space_bg3.x - backgroundSpeed
   
   if(space_bg1.x <= -190) then space_bg1.x = space_bg3.x + 570 end
   if(space_bg2.x <= -190) then space_bg2.x = space_bg1.x + 570 end
   if(space_bg3.x <= -190) then space_bg3.x = space_bg2.x + 570 end
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

local 

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
		
		
		
		player_ship = display.newImage("ship.png")
		player_ship.x = 20
		player_ship.y = display.contentHeight / 2
		sceneGroup:insert(player_ship)
		
		local enemy_ship = display.newImage("valkyrie.png")
		enemy_ship.x = display.contentWidth - 20
		enemy_ship.y = display.contentHeight / 2
		enemy_ship.xScale = -1
		sceneGroup:insert(enemy_ship)
		
		
		
		
		local options = {
		   effect = "fade",
		   time = 1000
		}
		
		local changeScene = function()
		  composer.gotoScene("main_menu", options)
		end
		
		
		
		
		
		
		
		--tap to change to main menu
		Runtime:addEventListener("touch", changeScene)
		Runtime:addEventListener( "enterFrame", scrollBackground )
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
	if change_timer then timer.cancel(change_timer); end
	
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