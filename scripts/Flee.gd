class_name Flee
extends State

var player_exit = false

func input(e: InputEvent) -> int:
	
	return States.Null

func physics_process(delta):
	
	var direction = entity.global_position.direction_to(-Global.player_pos)

	
	if player_exit or entity.has_plague:
		player_exit = false
		return States.Roam
		
	var nav_dir = entity.navigation_agent.get_next_path_position()
	var d = entity.global_position.direction_to(nav_dir)
	entity.set_movement_target(direction)		
	entity.velocity = d * entity.mv_speed
	entity.move_and_slide()
	return States.Null


func _on_aggro_body_exited(b):
	if b is Player:
		player_exit = true
