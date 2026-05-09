extends CharacterBody2D

@export var speed: float = 100.0
@export var accelerate: float = 100.0

var target_player: CharacterBody2D = null
var health = 1

func _physics_process(delta: float) -> void:
	speed += accelerate * delta
	
	if target_player:
		var direction = global_position.direction_to(target_player.global_position)
		velocity = direction * speed
	else:
		velocity = Vector2.LEFT * speed

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().die()
			queue_free()

func _on_detection_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		target_player = body

func damage():
	health -= 1
	
	if health <= 0:
		die()
		
func die():
	queue_free()
