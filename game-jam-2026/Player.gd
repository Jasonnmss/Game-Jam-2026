extends CharacterBody2D

var speed = 250
var player_health = 3

@onready var heart1 = $"../../../healthbar/1"
@onready var heart2 = $"../../../healthbar/2"
@onready var heart3 = $"../../../healthbar/3"

@onready var hearts = [heart1,heart2,heart3]


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
	
	#for i in range(hearts.size()):
	#	if i < player_health:
	#		hearts[i].visible = true
	#	else:
	#		hearts[i].visible = false

	if player_health <= 0:
	
		die()
		
	
func die():
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	$Sprite.play("death")
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	await $Sprite.animation_finished
	#animation and go to menu reset
	#queue_free()
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://open.tscn")
