extends Area2D


onready var touch_action = $TouchActionNPC.hide()
onready var scene_tree: SceneTree = get_tree()


func _on_Professor_body_entered(body: Node) -> void:
	$TouchActionNPC.show()


func _on_Professor_body_exited(body: Node) -> void:
	$TouchActionNPC.hide()


func _on_TouchActionNPC_pressed() -> void:
	get_parent().get_node("DialogUI/DialogInterface").show()
	scene_tree.paused = true
	
	
