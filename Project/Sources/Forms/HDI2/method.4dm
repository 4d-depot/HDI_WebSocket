Case of 
		
	: (FORM Event:C1606.code=On Load:K2:1)
		
		InitInfo
		
		Init
		
	: (FORM Event:C1606.code=On Unload:K2:2)
		var $state : Object
		// close the websocket server
		KillWebsocketServer()
		
	: (FORM Event:C1606.code=On Close Box:K2:21)
		If (Is Windows:C1573 && Get application info:C1599().SDIMode)
			KillWebsocketServer()
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
End case 


