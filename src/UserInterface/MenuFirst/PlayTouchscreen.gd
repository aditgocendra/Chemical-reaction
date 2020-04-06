extends TouchScreenButton

var player_scene

func _ready() -> void:
	var data = GameDatabase.load_data()
	player_scene = data["player_init"]["scene"]


func _on_PlayTouchscreen_pressed() -> void:
	get_tree().change_scene(player_scene)
	
func _get_configuration_warning() -> String:
	return "Property Empty" if player_scene == "" else ""
