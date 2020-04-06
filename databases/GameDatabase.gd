extends Node

var DB_dialog_path =  "res://databases/database_game.json"

var default_data = {
  "mission": {
	"mission1": {
	  "001": {
		"material_name": "rock",
		"value": "5"
	  },
	  "002": {
		"material_name": "wood",
		"value": "8"
	  }
	}
  },
  "player_mission": {
	"mission": null
  },
  "player_init": {
	"scene":"res://src/Laboratory/Laboratory.tscn"
  },
  "talking": {
	"dialog_prof_nurdin": {
	  "001": {
		"dialog": "Hi....... I am a professor in this laboratory",
		"npc_name": "nurdin"
	  },
	  "002": {
		"dialog": "Finally you come too, I have been waiting for your arrival",
		"npc_name": "nurdin"
	  },
	  "003": {
		"dialog": "I need your help to get the chemicals out there",
		"npc_name": "nurdin"
	  },
	  "004": {
		"dialog": "I'm doing research on a reaction and need some chemicals out there",
		"npc_name": "nurdin"
	  },
	  "005": {
		"dialog": "if you are willing?",
		"npc_name": "nurdin"
	  }
	},
	"end_dialog": {
	  "001": {
		"dialog": "Why are you still here, and not doing your job? I need it immediately"
	  }
	}
  },
  "equipment":{
		 "Axe":{
		  "equipment_name":"Axe", "src":"res://assets/object/item/kapak.png", "description":"You can use this to cut and cut wood"
		},
		"Hammer":{
		  "equipment_name":"Hammer", "src":"res://assets/object/item/palu.png", "description":"You can use this to crush anything other than wood"
		}
  },
  "player_use_equip":{
		"equip_use_name":null
  }
}

signal updated_mission
signal update_detail
signal update_texture_equip

var json_data setget update_data


var new_item_data setget update_name_item
var item_data_show


var equip_texture setget update_texture
var path_texture


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
	emit_signal("updated_mission")
	
	

func update_name_item(new_item_data):
	item_data_show =  new_item_data
	emit_signal("update_detail")


func update_texture(equip_texture):
	path_texture = equip_texture
	emit_signal("update_texture_equip")

