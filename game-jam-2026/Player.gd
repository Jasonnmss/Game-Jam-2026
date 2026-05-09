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
	
	if Input.is_action_just_pressed("shoot"):
		fire()
	
func fire():
	var bullet = preload("res://dna.tscn")
	var firebullet = bullet.instantiate()
	firebullet.position = Vector2(50,position.y) #50 muss zu ort von virus geändert werden!
	get_parent().call_deferred("add_child", firebullet)
