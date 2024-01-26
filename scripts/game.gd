extends Node2D

@export var tile_map : TileMap
var enemy := preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():

	for i in range(50):
		
		var e = enemy.instantiate()
		var pos = Vector2(rand_position())
		e.direction = Vector2.ZERO
		e.position = tile_map.map_to_local(pos)
		add_child(e)
		e.add_to_group("enemies")

		
func rand_position():
	
	var size = tile_map.get_used_rect().size
	return Vector2(randi_range(0,size.x), randi_range(0,size.y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Engine.set_physics_ticks_per_second(DisplayServer.screen_get_refresh_rate())

