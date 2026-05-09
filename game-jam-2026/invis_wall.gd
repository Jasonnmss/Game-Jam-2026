extends Area2D
	
func _on_body_entered(body):
		var player = get_tree().get_first_node_in_group("player")
		player.damage_player()
		body.die()
	

	
	
	  
