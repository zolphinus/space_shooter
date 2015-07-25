display.setStatusBar( display.HiddenStatusBar)

--local storyboard = require ("storyboard")

local store = require( "plugin.google.iap.v3" )
local composer = require( "composer" )

function transactionCallback( event )
    local transaction = event.transaction

    if ( transaction.state == "purchased" ) then
	    native.showAlert( "Corona", "Dream. Build. Ship.", { "OK", "Learn More" }, onComplete )
        print( "Transaction successful!" )
        print( "productIdentifier:", transaction.productIdentifier )
        print( "receipt:", transaction.receipt )
        print( "transactionIdentifier:", transaction.identifier )
        print( "date:", transaction.date )

    elseif ( transaction.state == "restored" ) then
        print( "Transaction restored from previous session" )
        print( "productIdentifier:", transaction.productIdentifier )
        print( "receipt:", transaction.receipt )
        print( "transactionIdentifier:", transaction.identifier )
        print( "date:", transaction.date )
        print( "originalReceipt:", transaction.originalReceipt )
        print( "originalTransactionIdentifier:", transaction.originalIdentifier )
        print( "originalDate:", transaction.originalDate )

    elseif ( transaction.state == "cancelled" ) then
        print( "User cancelled transaction" )

    elseif ( transaction.state == "failed" ) then
        print( "Transaction failed:", transaction.errorType, transaction.errorString )

    else
        print( "Unknown event" )
    end

    -- Tell the store that the transaction is finished
    -- If you are providing downloadable content, wait until after the download completes
    store.finishTransaction( transaction )
end

store.init( "google", transactionCallback )

local options = {
   effect = "fade",
   time = 1000
}

--composer.gotoScene("quatro_gato_screen", options)
--composer.gotoScene("main_menu", options)

composer.gotoScene("main_game", options)





