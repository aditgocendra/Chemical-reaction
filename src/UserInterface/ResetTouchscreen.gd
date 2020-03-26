extends TouchScreenButton


export(String, FILE) var next_scene_path: = ""


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

func _on_ResetTouchscreen_pressed() -> void:
	GameDatabase.save_data(default_data)
	GameDatabase.json_data = default_data
	get_tree().change_scene(next_scene_path)
