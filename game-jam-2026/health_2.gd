extends Sprite2D
var player_health = 3
func _on_hp(player_health):
	if player_health < 2:
		queue_free()
