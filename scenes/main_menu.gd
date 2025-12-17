extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	pass # Replace with function body.


func _on_mute_pressed() -> void:
	MooseAudio.Mute(!MooseAudio.GlobalMute)
	pass # Replace with function body.
