extends TextEdit

func _set(property: StringName, value: Variant) -> bool:
	if property == "text":
		set_deferred("scroll_vertical", INF)
	return false
