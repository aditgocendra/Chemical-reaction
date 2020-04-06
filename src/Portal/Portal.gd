extends Area2D

export(String, FILE) var next_scene_path: = ""

onready var anim_player: AnimationPlayer = $AnimationPlayer

func _get_configuration_warning() -> String:
	return "the next scene can't be empty" if not next_scene_path else ""


func teleport() -> void:
	anim_player.play("fade_out")
	yield(anim_player, "animation_finished")
	get_tree().change_scene(next_scene_path)
	
func update_sceneDB():
	var player_init = GameDatabase.load_data()
	player_init["player_init"] = {
		scene = next_scene_path
	}
	GameDatabase.save_data(player_init)


func _on_Node2D_body_entered(body: Node) -> void:
	teleport()
	update_sceneDB()
