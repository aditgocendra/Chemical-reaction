extends Control

export(String, FILE) var next_scene_path: = ""


onready var mission_interface = $MissionInterface
onready var scene_tree: SceneTree = get_tree()
onready var item_container = $ItemContainer
onready var equipment_interface = preload("res://src/UserInterface/Equipment/Equipment.tscn").instance()
onready var texture_action = $BackgroundTextureAct/EquipmentTexture
onready var bg_texture_action = $BackgroundTextureAct

#touch---------------------------------------------------
onready var touch_right = $HBoxContainer/Touch_Right
onready var touch_left = $HBoxContainer/Touch_left
onready var touch_jump = $BotRightContainer/TouchJump
#end touch---------------------------------------------------

var clickable: = Vector2.ZERO
var action = false

var index = 0


func _ready() -> void:
# warning-ignore:return_value_discarded
	GameDatabase.connect("update_texture_equip", self, "update_texture_action")
# warning-ignore:return_value_discarded
	GameDatabase.connect("update_crafting", self, "update_notif")
	load_action_texture()


func _on_Touch_left_pressed() -> void:
	if touch_jump.is_pressed():
		clickable = Vector2(-1.0, -1.0)
	clickable = Vector2(-1.0,0.0)
	


func _on_Touch_left_released() -> void:
	clickable = Vector2.ZERO


func _on_Touch_Right_pressed() -> void:
	if touch_jump.is_pressed():
		clickable = Vector2(1.0, -1.0)
	else: clickable = Vector2(1.0,0.0)


func _on_Touch_Right_released() -> void:
	clickable = Vector2.ZERO


func _on_TouchJump_pressed() -> void:
	if touch_left.is_pressed():
		clickable = Vector2(-1.0,-1.0)
	elif touch_right.is_pressed():
		clickable = Vector2(1.0,-1.0)
	else: clickable = Vector2(0.0, -1.0)
	


func _on_TouchJump_released() -> void:
	clickable = Vector2.ZERO
	

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
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene_path)


func _on_TouchQuit_pressed() -> void:
	get_tree().quit()
	


func _on_TouchEquipment_pressed() -> void:
	if item_container.get_child_count() == 0:
		item_container.add_child(equipment_interface)
	else: 
		var node = item_container.get_child(0)
		item_container.remove_child(node)
	
	
func load_action_texture():
	var data = GameDatabase.load_data()
	var player_use_equip = data["player_use_equip"]["equip_use_name"]
	if player_use_equip != null:
		bg_texture_action.show()
		var texture_load = data["item_inventory"]["equipment"][player_use_equip].src
		texture_action.texture = load(texture_load)
	else : 
		bg_texture_action.hide()
		

func update_texture_action():
	var path = GameDatabase.path_texture
	if path != null:
		bg_texture_action.show()
		texture_action.texture = load(path)
	else: bg_texture_action.hide()


func _on_TouchInventory_pressed() -> void:
	if setSoundGame() == false:
		$AudioOpenBag.playing = false
	else: 
		$AudioOpenBag.play()
		
	var item_interface = preload("res://src/UserInterface/Inventory/Inventory.tscn").instance()
	if item_container.get_child_count() == 0:
		item_container.add_child(item_interface)
	else:
		var node = item_container.get_child(0)
		item_container.remove_child(node)
	
	if $TopRightContainer2/Notif/NotifTexture.visible == true:
		$TopRightContainer2/Notif/NotifTexture.hide()


func _on_TouchAction_pressed() -> void:
	action  = true


func _on_TouchAction_released() -> void:
	action = false


func get_value():
	return clickable
	
	
func get_action():
	return action


func setSoundGame():
	var data = GameDatabase.load_data()
	var sound_fx = data["game_setting"]["sound_fx"]
	
	if sound_fx.checked == false:
		return false
	else:
		$AudioOpenBag.volume_db = sound_fx.vol
		return true
		
		
func update_notif():
	$TopRightContainer2/Notif/NotifTexture.show() 

















