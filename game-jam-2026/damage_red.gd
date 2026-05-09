extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	color_rect.color.a = 0

func play_damage_effect():
	color_rect.color = Color(1, 0, 0, 0.5)
	
	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, 0.5)
