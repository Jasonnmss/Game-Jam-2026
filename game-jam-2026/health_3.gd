extends Sprite2D

func _on_hp(hitpoints):
	print(hitpoints)
	if hitpoints == 2:
		queue_free()
