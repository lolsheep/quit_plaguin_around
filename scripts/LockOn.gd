class_name LockOn
extends State

var player_exit = false

func input(e: InputEvent) -> int:
	
	return States.Null

func physics_process(delta):
	
	if player_exit:
		player_exit = false
		return States.Roam
	var direction = entity.position.direction_to(Global.player_pos)
	entity.velocity = direction * 100
	entity.move_and_slide()
	return States.Null


func _on_aggro_body_exited(b):
	if b is Player:
		player_exit = true
