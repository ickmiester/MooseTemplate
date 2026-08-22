extends Node2D
@export var HostName:LineEdit
@export var HostPort:LineEdit
@export var JoinName:LineEdit
@export var JoinPort:LineEdit
@export var JoinIP:LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chatterNum = Global.Random.randi_range(1, 999)
	$HostPopup/NameEdit.text = "Chatter" + str(chatterNum)
	$JoinPopup/NameEdit.text = "Chatter" + str(chatterNum)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	Global.LoadScene(Enums.Scenes.Game)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_info_button_pressed() -> void:
	Global.LoadScene(Enums.Scenes.Info)

func _on_options_button_pressed() -> void:
	Global.LoadScene(Enums.Scenes.Options)
	pass # Replace with function body.

func _on_mute_pressed() -> void:
	MooseAudio.Mute(!MooseAudio.GlobalMute)
	pass # Replace with function body.

func _on_host_button_pressed() -> void:
	$HostPopup.show()
	pass # Replace with function body.

func _on_join_button_pressed() -> void:
	$JoinPopup.show()
	pass # Replace with function body.

func _on_startChat_button_pressed() -> void:
	Global.hostMultiplayer(HostName.text, HostPort.text)
	$HostPopup.hide()
	pass # Replace with function body.

func _on_cancel_button_pressed() -> void:
	$HostPopup.hide()
	$JoinPopup.hide()
	pass # Replace with function body.

func _on_connect_button_pressed() -> void:
	Global.joinMultiplayer(JoinName.text, JoinPort.text, JoinIP.text)
	$JoinPopup.hide()
	pass # Replace with function body.
