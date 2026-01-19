extends Node2D

@export var TextList:Array[String]
@export var CurrentText:Label
var currentIndex:int = 0

func _ready() -> void:
	CurrentText.text = TextList[currentIndex]
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	currentIndex += 1
	if(currentIndex >= TextList.size()):
		queue_free()
		return
	CurrentText.text = TextList[currentIndex]
