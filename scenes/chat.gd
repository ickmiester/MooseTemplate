extends Node2D

@export var ChatHistory:TextEdit
@export var ConnectedToLabel:Label
@export var ConnectedAsLabel:Label
@export var textInput:LineEdit

func _ready() -> void:
	updateLabels()
	textInput.grab_focus()
	Global.MultiplayerInfoChanged.connect(updateLabels)
	
func updateLabels() -> void:	
	ConnectedToLabel.text = "Connected To: " + Global.HostIP + ":" + Global.HostPort
	ConnectedAsLabel.text = "Connected As: " + Global.MultiplayerName

func _on_send_button_pressed() -> void:
	if textInput.text.length() > 0:
		sendInput.rpc_id(1, textInput.text, Global.MultiplayerName)
		textInput.text = ""
	pass # Replace with function body.

@rpc("any_peer", "call_local")
func sendInput(message:String, user:String):
	print("Sending Inpput")
	ChatHistory.text = ChatHistory.text + "\r\n" + user + " : " + message
	#scrollBottom.rpc()

@rpc("any_peer", "call_local")
func scrollBottom() -> void:
	print("scrolling to bottom")
	ChatHistory.scroll_vertical=INF


@warning_ignore("unused_parameter")
func _on_input_text_submitted(new_text: String) -> void:
		sendInput.rpc_id(1, textInput.text, Global.MultiplayerName)
		textInput.text = ""

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("got quit request")
		if multiplayer.is_server():
			print("I am a server")
			Global.transferHost()
		get_tree().quit() # default behavior
