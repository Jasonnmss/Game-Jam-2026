extends Area2D

var speed = -400

@export var life_time = 2
@export var life_spawn  = 0

@onready var spawnpos = $Marker2D

@export var particle: PackedScene

func _physics_process(delta: float) -> void:
	position.x -= delta * speed

	life_spawn += delta
	if life_spawn > life_time:
		queue_free()
		
func _on_body_entered(body):
	if body.has_method("damage"):                
		body.damage()
		spawn_particle()
		queue_free()
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
			spawn_particle()
			queue_free()
			
func spawn_particle():
	if particle:
		var effect = particle.instantiate()
		get_tree().root.add_child(effect)
		effect.global_position = spawnpos.global_position
		effect.get_node("AnimatedSprite2D").play("default")
