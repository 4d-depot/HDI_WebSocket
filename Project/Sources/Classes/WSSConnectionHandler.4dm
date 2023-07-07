Class constructor($countClient : Integer; $request : Object)
	/// Web Socket Server connection handler
	/// Class that defines a connection behavior 
	var $colors : Collection
	
	// Creates the user name that appear in conversation
	This:C1470.name:="Client"+String:C10($countClient)
	// Definition of the color text for the current user in conversation
	$colors:=New collection:C1472("aqua"; "blue"; "fuchsia"; "gray"; "green"; "lime"; "maroon"; "navy"; "olive"; "purple"; "silver"; "teal")
	This:C1470.color:=$colors[Mod:C98($countClient; $colors.length)]
	
	// color and name used if the receiver is the owner of the connection
	This:C1470.myColor:="black"
	This:C1470.myName:="Me"
	
	// Stores the remote address
	This:C1470.address:=$request.remoteAddress
	
	
	/// Defines a connection behavior
Function onOpen($ws : 4D:C1709.WebSocketConnection; $event : Object)
	var $client : Object
	
	// Send a message to the client chat to let him know he is connected
	$ws.send(This:C1470.serverMessage("Welcome on the chat!"))
	
	// Send the message "new client connected" to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send(This:C1470.myMessage(This:C1470.color; String:C10(This:C1470.name); "Connected!"))
		End if 
	End for each 
	
	// Called each time the user sends a message
Function onMessage($ws : Object; $event : Object)
	var $client : Object
	
	// Resend the message to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send($client.handler.myMessage(This:C1470.color; This:C1470.name; String:C10($event.data.message)))
		Else 
			// if the receiver is the owner of the connection:
			$client.send($client.handler.myMessage(This:C1470.myColor; This:C1470.myName; String:C10($event.data.message)))
		End if 
	End for each 
	
	// Called when the session is closed
Function onTerminate($ws : Object; $event : Object)
	var $client : Object
	
	// resend the message "new client connected" to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send(This:C1470.myMessage(This:C1470.color; String:C10(This:C1470.name); "Disconnected!"))
		End if 
	End for each 
	
	/// creates a server type message (display in red in the chat)
Function serverMessage($message : Text) : Object
	return This:C1470.myMessage("red"; "Server"; $message)
	
	/// Creates a message with a defined user color 
Function myMessage($color : Text; $name : Text; $message : Text) : Object
	return {color: $color; message: $message; name: $name}