class_name Idle
extends State

var wander_timer = 2
var player_entered = false
func input(e: InputEvent) -> int:
	
	return States.Null

func physics_process(delta):
	if player_entered:
		player_entered = false
		return States.Flee
	if wander_timer > 0:
		wander_timer -= delta
	else:
		wander_timer = randf_range(2,3)
		return States.Roam
	return States.Null


func _on_aggro_body_entered(body):
	if body.has_plague:
		player_entered = true
