extends Node

var DB_dialog_path =  "res://database_game.json"

var default_data = {
	"mission":{
		"mission1":{
			"001":{
				"material_name":"rock","value":"5"
				},
			"002":{
				"material_name":"wood","value":"8"}
				}
			},
	"player_mission":{
		"mission":null
		},
	"talking":{
		"dialog_prof_nurdin":{
			"001":{
				"dialog":"Hi....... I am a professor in this laboratory","npc_name":"nurdin"
				},
			"002":{
				"dialog":"Finally you come too, I have been waiting for your arrival","npc_name":"nurdin"
				},
			"003":{
				"dialog":"I need your help to get the chemicals out there","npc_name":"nurdin"
				},
			"004":{
				"dialog":"I'm doing research on a reaction and need some chemicals out there","npc_name":"nurdin"
				},
			"005":{
				"dialog":"if you are willing?","npc_name":"nurdin"
				}
		},
	"end_dialog":{
		"001":{
			"dialog":"Why are you still here, and not doing your job? I need it immediately"
			}
		}
	}
}

signal updated


var json_data setget update_data
var _file 


func _ready() -> void:
	print(DB_dialog_path)
	load_data()
	

func load_data():
	_file = File.new()
		
	if not _file.file_exists(DB_dialog_path):
		save_data(default_data)
	else:
		_file.open(DB_dialog_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data
		
		
func save_data(new_data):
	_file = File.new()
	
	_file.open(DB_dialog_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
	
	
func update_data(json_data):
	json_data = load_data()
	emit_signal("updated")
	
	
	


