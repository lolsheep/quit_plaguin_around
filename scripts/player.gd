class_name Player
extends Entity

@export var animation_handler : AnimationHandler
@export var player_speed : int = 150
@onready var sprite = animation_handler.current_sprite
@onready var attack_hitbox = animation_handler.attack_hitbox 

enum States {
	Explore,
	Battle,
	Die
}

var input = Vector2.ZERO

func _ready():

	base_health = 100
	inventory = {0 : "common_sword"}
	mv_speed = player_speed
	attack_speed = 10
	has_plague = true
func _process(delta):
	
	animation_handler.flip_h_direction(input)
	animation_handler.pick_animation(input)
	
func _physics_process(delta):
	
	Global.player_pos = position
	input = Input.get_vector("left", "right", "up", "down")
	velocity = input * mv_speed
	
	move_and_slide()


func _on_hitbox_body_entered(body):
	
	if body is BasicEnemy:
		body.infect()
		
