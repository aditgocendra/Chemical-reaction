extends TouchScreenButton

export(String, FILE) var next_scne_path: = ""



func _on_PlayTouchscreen_pressed() -> void:
	get_tree().change_scene(next_scne_path)
	
func _get_configuration_warning() -> String:
	return "Property Empty" if next_scne_path == "" else ""
