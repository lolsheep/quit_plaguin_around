class_name LockOn
extends State

func physics_process(delta):

	entity.find_nearest_person()
	
	var col = entity.get_last_slide_collision()
	if col:
		var hit = col.get_collider()
		
		if hit is BasicEnemy:
			hit.infect()

	var nav_dir = entity.navigation_agent.get_next_path_position()
	var d = entity.global_position.direction_to(nav_dir)
	entity.velocity = d * entity.mv_speed	
	entity.move_and_slide()
	return States.Null
