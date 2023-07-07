Class constructor($winRef : Integer)
	/// Web Socket Server handler
	This:C1470.countClient:=0
	This:C1470.winRef:=$winRef
	
/** Function called each time a new user log in
 In this example, we accept all the connections */
Function onConnection($wss : Object; $param : Object) : Object
	
	$wss.handler.countClient+=1
	// Instanciates WSSConnectionHandler class that manage the user connection behavior
	return cs:C1710.WSSConnectionHandler.new($wss.handler.countClient; $param.request)
	
Function onTerminate($wss : Object; $param : Object)
	
	KILL WORKER:C1390("WebSocketServer")
	