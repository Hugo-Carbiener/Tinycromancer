class_name MovementModule extends Node2D

var troop : Troop
@export var movement_speed : int
@export var navigation_agent : NavigationAgent2D
## @export var weight : int$ 
var initial_position : Vector2

func setup():	
	troop = get_parent()
	initial_position = global_position

func set_destination(destination : Vector2):
	navigation_agent.target_position = destination

func reset(target : Troop):
	set_destination(target.global_position)

func process(delta : float, target : Troop):
	if target != null:
		set_destination(target.global_position)
	if !navigation_agent.is_target_reached():
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		troop.velocity = direction * movement_speed * delta
		troop.move_and_slide()
