extends TileMapLayer


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("click")):
		set_cell(local_to_map(get_local_mouse_position()), 1, Vector2i.ZERO, 1);
	
