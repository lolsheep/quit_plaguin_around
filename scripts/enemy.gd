class_name BasicEnemy
extends Entity

@export var state_manager : StateManager
@export var aggro_range : Area2D
@export var sprite : Sprite2D
@export var particles : GPUParticles2D
@export var animation_player : AnimationPlayer
@export var navigation_agent : NavigationAgent2D
@export var timer : Timer

var lock_on_to : Vector2
var direction = Vector2.ZERO

func _ready() -> void:

	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	mv_speed = 100
	state_manager.init(self)
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(direction)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
	print(movement_target)
func _unhandled_input(e: InputEvent) -> void:
	
	state_manager.input(e)
	
func _process(delta):
	
	if direction.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
		
func _physics_process(delta: float) -> void:
	
	state_manager.physics_process(delta)

func infect():
	
	mv_speed += 20
	has_plague = true
	particles.emitting = true

func find_nearest_person():
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	var temp
	var closest = enemies[0]
	for e in enemies:
		if e.has_plague or e == self: continue
		var dist_to_person = position.distance_squared_to(e.position)
		var dist_to_closest = position.distance_squared_to(closest.position)
		if dist_to_person < dist_to_closest:
			closest = e
	direction = closest.position

func _on_timer_timeout():

	set_movement_target(direction)
	print(direction)
