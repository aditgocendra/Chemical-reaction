extends KinematicBody2D


var speed: = Vector2(300.0, 1000.0)
var velocity: = Vector2.ZERO
onready var direction: = get_parent().get_node("NavigationInterface/Navigation")


func _physics_process(delta: float) -> void:
	var action_player = direction.get_value()
	velocity.y += speed.y * delta
	velocity.x = action_player.x * speed.x
	get_anim_equip(action_player)
	velocity = move_and_slide(velocity)
	
	
func get_anim_equip(direction: Vector2):
	var get_data = GameDatabase.load_data()
	var equip_use = get_data["player_use_equip"]["equip_use_name"]
	if equip_use == null :
		playAnimation(direction, ["Idle","walk"])
	elif equip_use == "Axe":
		playAnimation(direction, ["IdleAxe", "walkAxe"])
	else :
		playAnimation(direction, ["IdleHammer","walkHammer"])


func playAnimation(linear_direction : Vector2, anim :Array) -> void:
		if linear_direction.x == -1.0:
			$PlayerAnimation.flip_h = true
			$PlayerAnimation.play(anim[1])
		elif linear_direction.x == 1.0: 
			$PlayerAnimation.flip_h = false
			$PlayerAnimation.play(anim[1])
		else: 
			$PlayerAnimation.play(anim[0])





