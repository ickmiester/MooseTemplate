extends Button

class_name MooseButton

@export var ButtonAudio:AudioStreamPlayer
@export var EnterAudio:AudioStream
@export var ExitAudio:AudioStream
@export var ClickAudio:AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset = Vector2(size.x/2, size.y/2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	if(ButtonAudio != null && EnterAudio != null):
		#ButtonAudio.stop()
		#ButtonAudio.stream = EnterAudio
		#ButtonAudio.play()
		MooseAudio.PlaySound(EnterAudio)
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .1)
	tween.tween_property(self, "scale", Vector2.ONE, 0)
	tween.tween_property(self, "rotation_degrees", 5 * (100/size.x), .05)
	tween.tween_property(self, "rotation_degrees", 0, 0)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	if(ButtonAudio != null && ExitAudio != null):
		#ButtonAudio.stop()
		#ButtonAudio.stream = ExitAudio
		#ButtonAudio.play()
		MooseAudio.PlaySound(ExitAudio)
	pass # Replace with function body.


func _on_button_down() -> void:
	if(ButtonAudio != null && ClickAudio != null):
		#ButtonAudio.stop()
		#ButtonAudio.stream = ClickAudio
		#ButtonAudio.play()
		MooseAudio.PlaySound(ClickAudio)
	pass # Replace with function body.
