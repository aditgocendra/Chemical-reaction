extends Control

export (PackedScene) var next_scene
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)

 

