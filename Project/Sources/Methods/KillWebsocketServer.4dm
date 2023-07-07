//%attributes = {}
If (Process number:C372("WebSocketServer")>0)
	CALL WORKER:C1389("WebSocketServer"; Formula:C1597(WebSocketServer.terminate()))
	
End if 