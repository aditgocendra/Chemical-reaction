extends KinematicBody2D


var speed: = Vector2(300.0, 1000.0)
var velocity: = Vector2.ZERO
onready var direction: = get_parent().get_node("NavigationInterface/Navigation")


func _physics_process(delta: float) -> void:
	var action_player = direction.get_value()
	velocity.y += speed.y * delta
	velocity.x = action_player.x * speed.x
	playAnimation(action_player)
	velocity = move_and_slide(velocity)
	
	
func playAnimation(linear_direction : Vector2) -> void:
	if linear_direction.x == -1.0:
		$PlayerAnimation.flip_h = true
		$PlayerAnimation.play("walk")
	elif linear_direction.x == 1.0: 
		$PlayerAnimation.flip_h = false
		$PlayerAnimation.play("walk")
	else: 
		$PlayerAnimation.play("Idle")



	
	



