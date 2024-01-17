class_name BasicEnemy
extends Entity

@export var state_manager : StateManager
@export var aggro_range : Area2D

func _ready() -> void:
	state_manager.init(self)
	
func _unhandled_input(e: InputEvent) -> void:
	state_manager.input(e)
	
func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)



