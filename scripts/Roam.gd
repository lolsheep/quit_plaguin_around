class_name Roam
extends State

var wander_timer = 2
var player_entered = false
var direction
func _ready():

	rand_direction()
	
func rand_direction():
	
	direction = Vector2(randf_range(-1,1), randf_range(-1,1))
	wander_timer = randf_range(0,2)
	
func x_direction():
	
	direction.x = -1 if direction.x == 1 else 1
	direction.y = 0
	wander_timer = randf_range(1,2)
	
func y_direction():
	
	direction.y = -1 if direction.x != 1 else 1
	direction.x = 0
	wander_timer = randf_range(1,2)

func physics_process(delta):
	
	entity.direction = direction

	if player_entered and not entity.has_plague:
		return States.Flee
		
	if entity.has_plague:
		entity.find_nearest_person()
		return States.LockOn
			
	if wander_timer > 0:
		wander_timer -= delta
	else:
		rand_direction()
		wander_timer = randf_range(1,2)
		return States.Idle
			
	entity.velocity = entity.direction * entity.mv_speed
	entity.move_and_slide()
	
	return States.Null

func _on_aggro_body_entered(b):
	if b is Entity and b.has_plague:
		player_entered = true

