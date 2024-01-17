class_name Roam
extends State

var direction = Vector2.ZERO
var wander_timer = 2
var player_entered = false

func _ready():
	
	x_direction()
	
func rand_direction():
	
	direction = Vector2(randf_range(-1,1), randf_range(-1,1))
	wander_timer = randf_range(1,2)
	
func x_direction():
	
	direction.x = -1 if direction.x == 1 else 1
	direction.y = 0
	wander_timer = randf_range(1,2)
	
func y_direction():
	
	direction.y = -1 if direction.x != 1 else 1
	direction.x = 0
	wander_timer = randf_range(1,2)


func physics_process(delta):
	
	if player_entered:
		player_entered = false
		return States.LockOn
		
	if wander_timer > 0:
		wander_timer -= delta
	else:
		x_direction()
		return States.Idle
		
	entity.velocity = direction * 100
	entity.move_and_slide()
	return States.Null

func _on_aggro_body_entered(b):
	if b is Player:
		player_entered = true

