class_name Idle
extends State

var wander_timer = 2
	
func input(e: InputEvent) -> int:
	
	return States.Null

func physics_process(delta):
	if wander_timer > 0:
		wander_timer -= delta
	else:
		wander_timer = randf_range(1,2)
		return States.Roam
	return States.Null
