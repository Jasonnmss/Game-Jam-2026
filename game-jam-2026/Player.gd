extends CharacterBody2D

var speed = 250
var player_health = 3

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

func damage_player():
	player_health -= 1
	$Damage.play_damage_effect()
	
	if player_health <= 0:
		die()
		
func die():
	$AnimationPlayer.play("death")
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	await $AnimationPlayer.animation_finished
	#animation and go to menu reset
	queue_free()
