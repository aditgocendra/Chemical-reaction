extends Control


onready var grid_mission = $Panel/ScrollMission/GridContainer
onready var mission_interface = preload("res://src/UserInterface/Mission/MissionItem.tscn").instance()

onready var mission_player = GameDatabase.load_data()#ganti ketika export #json data 


var conversation: Array
var index: int


var max_mission: int = 10

func _ready() -> void:
	GameDatabase.connect("updated", self, "updated_mission")
	get_user_mission()
	set_label_mission()


func get_user_mission():
	var mission = mission_player["player_mission"].values()
	if mission[0] == null:
		$Panel/LabelNotmission.show()
	else:
		get_mission_from_db(mission[0])
		
		
	
func get_mission_from_db(player_mission: String):
	var mission_data = mission_player["mission"][player_mission].values()
	conversation = mission_data
	
	
func updated_mission():
	mission_player = GameDatabase.json_data
	get_user_mission()
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
	
