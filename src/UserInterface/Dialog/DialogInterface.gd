extends Control


var instance_db = GameDatabase.load_data()#ganti ketika export
var conversation: Array
var indexes: int = 0

var mission_interface = preload("res://src/UserInterface/Mission/MissionInterface.gd").new()
onready var text_dialog = $BackgroundDialog/TextDialog
onready var take_cancel = $BackgroundDialog/TakeOrCancelDialog
onready var next_touch = $BackgroundDialog/TouchNextDialog
onready var finish_touch = $BackgroundDialog/TouchFinishDialog
onready var scene_tree: SceneTree = get_tree()

func _ready() -> void:
	GameDatabase.connect("updated_mission", self, "updated_dialog")
	#load data dialog
	get_dialog()


func _update():
	var text = conversation[indexes].dialog
	
	text_dialog.set_bbcode(text)
	text_dialog.set_visible_characters(0) 
	
	if check_mission() == false:
		if indexes == conversation.size() - 1:
			next_touch.hide()
			take_cancel.show()
	else:
		next_touch.hide()
		take_cancel.hide()
		finish_touch.show()

func _on_Timer_timeout() -> void:
	text_dialog.set_visible_characters(text_dialog.get_visible_characters() + 1) 


func _on_TouchNextDialog_pressed() -> void:
	indexes += 1
	if indexes < conversation.size():
		_update()
	



func _on_TouchCancelButton_pressed() -> void:
	$".".hide()
	indexes = 0
	take_cancel.hide()
	next_touch.show()
	_update()
	scene_tree.paused = false


func _on_TouchTakeButton_pressed() -> void:
	$".".hide()
	indexes = 0
	take_cancel.hide()
	next_touch.show()
	_update()
	scene_tree.paused = false
	set_mission()
	
	
func set_mission():
	if conversation[indexes].npc_name == "nurdin":
		var save_mission = instance_db
		save_mission["player_mission"] = {
			mission = "mission1"
		}
		GameDatabase.save_data(save_mission)
		GameDatabase.json_data = save_mission
	

func check_mission():
	var mission_player  = instance_db["player_mission"]["mission"]
	
	if mission_player != null:
		return true
	else: return false


func _on_TouchFinishDialog_pressed() -> void:
	$".".hide()
	take_cancel.hide()
	next_touch.show()
	_update()
	scene_tree.paused = false


func get_dialog():
	var data
	if	check_mission() == false:
		indexes = 0
		data = instance_db["talking"]["dialog_prof_nurdin"]
		conversation = data.values()
		_update()
	else:
		data = instance_db["talking"]["end_dialog"]
		conversation = data.values()
		_update()



func updated_dialog():
	instance_db = GameDatabase.json_data
	next_touch.show()
	finish_touch.hide()
	get_dialog()
	
