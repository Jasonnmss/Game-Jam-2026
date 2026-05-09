extends Area2D

var speed = -400

@export var life_time = 2
@export var life_spawn  = 0


func _physics_process(delta: float) -> void:
	position.x -= delta * speed

	life_spawn += delta
	if life_spawn > life_time:
		queue_free()
		
func _on_body_entered(body):
	if body.has_method("damage"):                
		body.damage()
		queue_free()
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
			queue_free()
			
