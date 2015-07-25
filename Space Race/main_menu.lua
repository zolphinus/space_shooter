local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	
	print("entering main menu Screen")
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		composer.removeScene("space_race_loading_screen")
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
		
		
		
		local loadingScreen = display.newImage("main_menu.png")
		loadingScreen.alpha = 0.0
		transition.to(loadingScreen, {alpha=1, time=300})
		sceneGroup:insert(loadingScreen)
		loadingScreen.x = display.contentWidth / 2
		loadingScreen.y = display.contentHeight / 2
		
		local options = {
		   effect = "fade",
		   time = 1000
		}
		
		local changeScene = function()
		  composer.gotoScene("options", options)
		end
		
		--play cool sound music here
		
		
		local function achievementButtonPress( event )

			if ( "ended" == event.phase ) then
				print( "Button was pressed and released" )
			end
		end

		local achievementButton = widget.newButton
		{
			width = 56,
			height = 56,
			defaultFile = "achievement.png",
			overFile = "achievement.png",
			onEvent = achievementButtonPress
		}
		
		achievementButton.x = 25
		achievementButton.y = display.contentHeight - 50
		sceneGroup:insert(achievementButton)
		
		
		local function leaderboardButtonPress( event )

			if ( "ended" == event.phase ) then
				print( "Button was pressed and released" )
			end
		end

		local leaderboardButton = widget.newButton
		{
			width = 56,
			height = 56,
			defaultFile = "leaderboard.png",
			overFile = "leaderboardOver.png",
			onEvent = leaderboardButtonPress
		}
		
		leaderboardButton.x = 100
		leaderboardButton.y = display.contentHeight - 50
		sceneGroup:insert(leaderboardButton)
		
		
		local function space_storeButtonPress( event )

			if ( "ended" == event.phase ) then
				print( "Button was pressed and released" )
			end
		end

		local space_storeButton = widget.newButton
		{
			width = 192,
			height = 56,
			defaultFile = "space_store.png",
			overFile = "space_storeOver.png",
			onEvent = leaderboardButtonPress
		}
		
		space_storeButton.x = display.contentWidth - 100
		space_storeButton.y = 50
		sceneGroup:insert(space_storeButton)
		
		
		local function playButtonPress( event )

			if ( "ended" == event.phase ) then
				print( "Button was pressed and released" )
			end
		end

		local playButton = widget.newButton
		{
			width = 80,
			height = 80,
			defaultFile = "play.png",
			overFile = "playOver.png",
			onEvent = playButtonPress
		}
		
		playButton.x = display.contentWidth - 75
		playButton.y = display.contentHeight - 50
		sceneGroup:insert(playButton)
		
		--change_timer = timer.performWithDelay(2800, changeScene, 1)
		
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
	
	print("destroying  main menu loading Screen")
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene