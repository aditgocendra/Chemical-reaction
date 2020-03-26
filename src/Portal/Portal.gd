extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var scene_tree: SceneTree = get_tree()
export var next_scene: PackedScene

func _on_Portal_body_entered(body: PhysicsBody2D) -> void:
	teleport()
	
	
func _get_configuration_warning() -> String:
	return "The property Next Level can't be empty" if not next_scene else ""


func teleport() -> void:
	anim_player.play("fade_out")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
