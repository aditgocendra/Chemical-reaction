extends KinematicBody2D


var speed: = Vector2(400.0, 850.0)
var gravity = 2000.0
var velocity: = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP


onready var direction: = get_parent().get_node("NavigationInterface/Navigation")
onready var platformer_detector = $PlatformerDetector

func _physics_process(delta: float) -> void:
	var action_player = direction.get_value()
	velocity = calculate_movement(velocity, action_player)
	
	get_anim_equip(action_player)
	
	var is_on_platform = platformer_detector.is_colliding()
	var snap_vector = Vector2.DOWN * 20.0 if action_player.y == 0.0 else Vector2.ZERO
	
	velocity = move_and_slide_with_snap(
		velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
	)
	
	
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



func calculate_movement(linear_velocity: Vector2, player_direction: Vector2) -> Vector2:
	var new_velocity = linear_velocity
	
	new_velocity.x = player_direction.x * speed.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if player_direction.y == -1.0:
		if is_on_floor():
			new_velocity.y = speed.y * player_direction.y

			
	return new_velocity
