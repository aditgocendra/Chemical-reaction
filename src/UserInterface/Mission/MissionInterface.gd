extends Control


onready var grid_mission = $Panel/ScrollMission/GridContainer
onready var mission_interface = preload("res://src/UserInterface/Mission/MissionItem.tscn").instance()


onready var mission_player = GameDatabase.load_data()#ganti ketika export #json data 
onready var touch_cancel = $Panel/PanelCancel


var conversation: Array
var index: int


func _ready() -> void:
# warning-ignore:return_value_discarded
	GameDatabase.connect("updated_mission", self, "load_update_mission")
	get_user_mission()
	set_label_mission()


func get_user_mission():
	var mission = mission_player["player_mission"].values()
	if mission[0] == null:
		$Panel/LabelNotmission.show()
		touch_cancel.hide()
		
		if grid_mission.get_child_count() > 0:
			removeItemMission()
		
	else:
		get_mission_from_db(mission[0])
		touch_cancel.show()
		
		
	
func get_mission_from_db(player_mission: String):
	var mission_data = mission_player["mission"][player_mission].values()
	conversation = mission_data
	
	
func load_update_mission():
	mission_player = GameDatabase.json_data
	get_user_mission()
	if mission_player["player_mission"]["mission"] != null:
		set_label_mission()
		$Panel/LabelNotmission.hide()
	
	
func set_label_mission():
	index = 0
	while index < conversation.size():
		
		var mission = mission_interface.duplicate()
		var materialName = conversation[index].material_name
		var materialValue = conversation[index].value
		
		grid_mission.add_child(mission)
		mission.setLabelMaterial(materialName, materialValue)
		
		index +=1
		

func _on_TouchCancel_pressed() -> void:
		var save_mission = mission_player
		save_mission["player_mission"] = {
			mission = null
		}
		GameDatabase.save_data(save_mission)
		GameDatabase.json_data = save_mission



func removeItemMission():
	index = 0
	for index in range(grid_mission.get_child_count()):
		grid_mission.get_child(index).queue_free()
