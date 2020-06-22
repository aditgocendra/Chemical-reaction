extends KinematicBody2D


var speed: = Vector2(400.0, 1000.0)
var gravity = 2000.0
var velocity: = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP


onready var direction: = get_parent().get_node("NavigationInterface/Navigation")
onready var platformer_detector = $PlatformerDetector
onready var timer_action_anim = $TimerAnimation
onready var area_action = $PlayerAction/CollisionPolygon2D
onready var label_item = $LabelItem


var action_equip: bool
var animation


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	var action_player = direction.get_value()
	print(action_player)
	action_equip = direction.get_action()

	velocity = calculate_movement(velocity, action_player)
	
	var anim_use_equip = get_anim_equip()
	animation = playAnimation(action_player, anim_use_equip)
	
	if $PlayerAnimation.animation != animation and timer_action_anim.is_stopped():
		if action_equip:
			timer_action_anim.start()
			area_action.set_disabled(false)
			action_player = Vector2(0.0, 0.0)
		else: area_action.set_disabled(true)  
		$PlayerAnimation.play(animation)
	
	var is_on_platform = platformer_detector.is_colliding()
	var snap_vector = Vector2.DOWN * 20.0 if action_player.y == 0.0 else Vector2.ZERO
	
	
	if $PlayerAnimation.animation == "ActionHammer" and $PlayerAnimation.is_playing():
		velocity = Vector2.ZERO
	elif $PlayerAnimation.animation == "ActionAxe" and $PlayerAnimation.is_playing():
		velocity = Vector2.ZERO
	
	
	velocity = move_and_slide_with_snap(
		velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
	)
	
	
func get_anim_equip():
	var get_data = GameDatabase.load_data()
	var equip_use = get_data["player_use_equip"]["equip_use_name"]
	var anim : Array
	if equip_use == null :
		anim =  ["Idle","walk",null]
	elif equip_use == "Axe":
		anim = ["IdleAxe", "walkAxe","ActionAxe"]
	else : anim = ["IdleHammer","walkHammer", "ActionHammer"]

	return anim


func playAnimation(linear_direction : Vector2, anim :Array):
		var new_anim = ""
		
		if linear_direction.x == -1.0:
			$PlayerAnimation.flip_h = true
			if $AudioMovement.playing == false:
				if setSoundGame() == false:
					$AudioMovement.playing = false
				else: $AudioMovement.play()
			new_anim = anim[1]
		elif linear_direction.x == 1.0: 
			$PlayerAnimation.flip_h = false
			if $AudioMovement.playing == false:
				if setSoundGame() == false:
					$AudioMovement.playing = false
				else: $AudioMovement.play()
			new_anim = anim[1]
		else: 
			new_anim = anim[0]
			$AudioMovement.stop()
		
		if action_equip == true:
			new_anim = anim[2]
		
		return new_anim


func calculate_movement(linear_velocity: Vector2, player_direction: Vector2) -> Vector2:
	var new_velocity = linear_velocity
	
	new_velocity.x = player_direction.x * speed.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if player_direction.y == -1.0:
		if is_on_floor():
			new_velocity.y = speed.y * player_direction.y
			if setSoundGame() == false:
				$AudioJump.playing = false
			else: $AudioJump.play()
			
	return new_velocity



func _on_PlayerAction_area_entered(area: Area2D) -> void:
	if area.name == "AreaMediumRock" and $PlayerAnimation.animation == "ActionHammer":
		label_item.text = "1x Broken Stone"
		pushAmountItem("broken_stone")
	
		if setSoundGame() == false:
			$AudioHitRock.playing = false
		else: $AudioHitRock.play()
		
		$AnimationItem.play("get_item")
	
	elif area.name == "AreaSmallWood" and $PlayerAnimation.animation == "ActionAxe":
		label_item.text = "1x Small Wood"
		pushAmountItem("small_wood")
		
		if setSoundGame() == false:
			$AudioHitWood.playing = false
		else: $AudioHitWood.play()
		
		$AnimationItem.play("get_item")
		
	elif area.name == "AreaBigWood" and $PlayerAnimation.animation == "ActionAxe":
		label_item.text = "1x Big Wood"
		pushAmountItem("big_wood")
		
		if setSoundGame() == false:
			$AudioHitWood.playing = false
		else: $AudioHitWood.play()
		
		$AnimationItem.play("get_item")
		

func pushAmountItem(nameItem : String) -> void:
	var item_material = GameDatabase.load_data()
	item_material["item_inventory"]["item_material"][nameItem]["amount"] += 1
	
	GameDatabase.save_data(item_material)
	

func setSoundGame():
	var data = GameDatabase.load_data()
	var sound_fx = data["game_setting"]["sound_fx"]
	
	if sound_fx.checked == false:
		return false
	else:
		$AudioHitRock.volume_db = sound_fx.vol
		$AudioMovement.volume_db = sound_fx.vol
		$AudioJump.volume_db = sound_fx.vol
		$AudioHitWood.volume_db = sound_fx.vol
		return true

