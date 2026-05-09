extends CharacterBody2D

#var player = null

signal died

@export var speed = 50
var y_speed = 60
@export var accelerate = 50

@export var health = 3

@onready var spawnpos = $Marker2D


	
func _physics_process(delta: float) -> void:
	speed += delta * accelerate
	velocity = Vector2.LEFT * speed
	if Input.is_action_pressed("Move Down"):
		velocity.y = y_speed
	if Input.is_action_pressed("Move Up"):
		velocity.y = -y_speed
	move_and_slide()
	#if get_slide_collision_count() > 0:
		#player_die()

		
func damage():
	health -= 1
	
	if health <= 0:
		die()
		
func die():
	var play = $Sprite2D
	died.emit()
	queue_free()
