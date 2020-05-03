extends Area2D


onready var touch_action = $TouchActionNPC.hide()
onready var scene_tree: SceneTree = get_tree()
onready var npc_texture = $NPC


func _on_Professor_body_entered(body: Node) -> void:
	if body.name == "Player":
		$TouchActionNPC.show()


func _on_Professor_body_exited(body: Node) -> void:
	if body.name == "Player":
		$TouchActionNPC.hide()


func _on_TouchActionNPC_pressed() -> void:
	if npc_texture.texture.resource_path == "res://assets/npc/npc_nurdin.png":
		GameDatabase.npc_name = "nurdin"
	elif npc_texture.texture.resource_path == "res://assets/npc/npc_crafter.png":
		GameDatabase.npc_name = "Holdin"
	else : GameDatabase.npc_name = "yadi"
		
	get_parent().get_node("DialogUI/DialogInterface").show()
	scene_tree.paused = true
	
	
