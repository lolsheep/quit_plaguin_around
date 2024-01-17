class_name Player
extends Entity

@export var animation_handler : AnimationHandler
@onready var sprite = animation_handler.current_sprite

enum States {
	Explore,
	Battle,
	Die
}

var input = Vector2.ZERO

func _ready():

	base_health = 100
	type = Player
	inventory = {0 : "common_sword"}
	mv_speed = 200
	attack_speed = 10

func _process(delta):
	
	animation_handler.flip_h_direction(input)
	animation_handler.pick_animation(input)
	
func _physics_process(delta):
	
	Global.player_pos = position
	input = Input.get_vector("left", "right", "up", "down")
	velocity = input * mv_speed
	move_and_slide()
