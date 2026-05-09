extends Node2D

var speed = -400

@export var life_time = 2
@export var life_spawn  = 0


func _physics_process(delta: float) -> void:
	position.x -= delta * speed

	life_spawn += delta
	if life_spawn > life_time:
		queue_free()
