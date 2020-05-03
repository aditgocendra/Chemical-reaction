extends Control

export (PackedScene) var next_scene
onready var anim_player: AnimationPlayer = $AnimationPlayer


# warning-ignore:unused_argument
func _process(delta: float) -> void:
	yield(anim_player, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(next_scene)

 

