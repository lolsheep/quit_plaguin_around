## Animation Handler class
## Used to set current animations based on player "state"
## 
## Use by adding this node to a player scene
## This was made to avoid issues with multiple AnimationPlayer nodes
## This will set visibility for all inactive sprites/animations to false

class_name AnimationHandler
extends Node

# Animation player
@export var animation_player : AnimationPlayer

# Current animations to use
@export var idle : Sprite2D
@export var attack : Sprite2D
@export var walk : Sprite2D

# current_sprite will be whichever sprite is currently playing
var current_sprite : Sprite2D
# visibility will hold all nodes, and be iterated through to set visibility for all that are not current to "false"
var visibility : Array

func _ready():
	
	# Always start with "idle" animation
	current_sprite = idle
	current_sprite.visible = true
	animation_player.autoplay = "Idle"

# Flip sprite horizontally based on player input
func flip_h_direction(input):
	
	if input.x != 0:
		current_sprite.flip_h = input.x < 0

func set_visibility():
	
	# Update visibility 
	visibility = [
		idle,
		attack,
		walk
	]
	# Set any inactive sprites to invisible
	for v in visibility:
		v.visible = v.name == current_sprite.name
		v.flip_h = current_sprite.flip_h	

# TODO: Optimize this. Will eventually come into problems when adding more animations.
# If no more animations are added, fuck it, it works.
func pick_animation(input):
	
	# If input is (0,0), then the player is idle
	# Create a temp variable to hold the new animation if the conditions are met
	var tmp
	if input != Vector2.ZERO:
		tmp = walk
	else:
		tmp = idle
	
	# If the nodes do not match, then we'll change the sprite and change visibility
	if tmp != current_sprite:
		current_sprite = tmp
		set_visibility()
		animation_player.play(current_sprite.name)
