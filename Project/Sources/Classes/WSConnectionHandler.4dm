Class constructor
	/// Web socket client connection handler
	This:C1470.dataType:="object"
	
Function onMessage($ws : 4D:C1709.WebSocket; $event : Object)
	
	Form:C1466.messages.push($event.data)
	
Function onError($ws : 4D:C1709.WebSocket; $event : Object)
	
	ALERT:C41("Error: "+String:C10($event.errors[0].message))
	
Function onTerminate($ws : 4D:C1709.WebSocket; $event : Object)
	
	Form:C1466.messages.push({color: "red"; message: "The websocket server is closed!!"; name: "Server"})