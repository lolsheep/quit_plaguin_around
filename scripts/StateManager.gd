class_name StateManager
extends Node

@export var idle : Node
@export var roam : Node
@export var lock_on : Node

@onready var states = {
	State.States.Idle : idle,
	State.States.Roam : roam,
	State.States.LockOn : lock_on
}
var current : State

func switch_state(n: int) -> void:
	
	if current:
		current.exit()
	current = states[n]
	current.enter()

func init(entity: Entity) -> void:
	for c in get_children():
		c.entity = entity
	
	switch_state(State.States.Idle)

func physics_process(delta: float) -> void:
	var new = current.physics_process(delta)
	if new != State.States.Null:
		switch_state(new)

func input(e: InputEvent) -> void:
	var new = current.input(e)
	if new != State.States.Null:
		switch_state(new)

	
