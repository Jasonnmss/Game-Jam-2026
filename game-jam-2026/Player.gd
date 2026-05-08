extends CharacterBody2D

var speed = 250

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Down"):
		velocity.y = speed
	if Input.is_action_pressed("Move Up"):
		velocity.y = -speed
	if velocity.length() > 0 :
		move_and_slide()
