extends Control

export(String, FILE) var next_scene_path: = ""


onready var mission_interface = $MissionInterface
onready var scene_tree: SceneTree = get_tree()
onready var equipment_container = $EquipmentContainer
onready var equipment_interface = preload("res://src/UserInterface/Equipment/Equipment.tscn").instance()
onready var texture_action = $BackgroundTextureAct/EquipmentTexture
onready var bg_texture_action = $BackgroundTextureAct


var clickable: = Vector2.ZERO


func _ready() -> void:
	GameDatabase.connect("update_texture_equip", self, "update_texture_action")
	load_action_texture()


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
	


func _on_TouchEquipment_pressed() -> void:
	if equipment_container.get_child_count() == 0:
		equipment_container.add_child(equipment_interface)
	else: equipment_container.remove_child(equipment_interface)
	

func load_action_texture():
	var data = GameDatabase.load_data()
	var player_use_equip = data["player_use_equip"]["equip_use_name"]
	if player_use_equip != null:
		bg_texture_action.show()
		var texture_load = data["equipment"][player_use_equip].src
		texture_action.texture = load(texture_load)
	else : 
		bg_texture_action.hide()
		

func update_texture_action():
	var path = GameDatabase.path_texture
	if path != null:
		bg_texture_action.show()
		texture_action.texture = load(path)
	else: bg_texture_action.hide()
