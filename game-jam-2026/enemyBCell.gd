extends CharacterBody2D
class_name EnemyBCell

var Bullet = preload("res://enemy_bullet.tscn")
var canshoot = true
signal died
#var player = null

@export var health = 3

@export var speed = 20
@export var accelerate = 50

@onready var spawnpos = $Marker2D

#func _on_Detection_body_entered(body):
	#if body.is_in_group("Player"):
		#player = body
		
func _ready() -> void: 
	pass
	
func _physics_process(delta: float) -> void:
	speed += delta * accelerate
	velocity = Vector2.LEFT * speed
	
	move_and_slide()
	#if get_slide_collision_count() > 0:
		#player_die()

func _on_timer_timeout():
	canshoot = true
	shoot() 
	#if player != null: 
		#shoot()
		
func shoot():
	if canshoot:
		var bullet = Bullet.instantiate()
		
		get_parent().call_deferred("add_child", bullet)
		bullet.ready.connect(func(): bullet.global_position = spawnpos.global_position)
		
		$Timer.start()
		canshoot = false
		
func damage():
	health -= 1
	
	if health <= 0:
		die()
		
func die():
	died.emit()
	print("signal")
	queue_free()
