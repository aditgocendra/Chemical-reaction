extends TouchScreenButton


export(String, FILE) var next_scene_path: = ""


var default_data = GameDatabase.default_data

func _on_ResetTouchscreen_pressed() -> void:
	GameDatabase.save_data(default_data)
	GameDatabase.json_data = default_data
	get_tree().change_scene(next_scene_path)
