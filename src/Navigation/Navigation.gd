extends Control


export(String, FILE) var next_scene_path: = ""


onready var mission_interface = $MissionInterface
onready var scene_tree: SceneTree = get_tree()

var clickable: = Vector2.ZERO


func _on_Touch_left_pressed() -> void:
	clickable = Vector2(-1.0,0.0)


func _on_Touch_left_released() -> void:
	clickable = Vector2.ZERO


func _on_Touch_Right_pressed() -> void:
	clickable = Vector2(1.0,0.0)


func _on_Touch_Right_released() -> void:
	clickable = Vector2.ZERO



func get_value():
	return clickable


func _on_Touch_Mission_pressed() -> void:
	if	mission_interface.is_visible_in_tree():
		mission_interface.hide()
	else : mission_interface.show()



func _on_TouchRetry_pressed() -> void:
	$PauseOverlay.hide()
	scene_tree.paused = false


func _on_TouchSetting_pressed() -> void:
	$PauseOverlay.show()
	scene_tree.paused = true


func _on_TouchBackMenu_pressed() -> void:
	scene_tree.paused = false
	get_tree().change_scene(next_scene_path)


func _on_TouchQuit_pressed() -> void:
	
	get_tree().quit()
	
