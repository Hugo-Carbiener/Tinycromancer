class_name Troop extends CharacterBody2D

@export_group("Modules")
@export var combat_module : CombatModule
@export var movement_module : MovementModule
@export var animation_module : AnimationModule

var target : Troop
var faction : CombatManager.FACTIONS
var current_state : State = IdleState.new(self, "idle")
var state_machine : StateMachine = StateMachine.new()


func _ready() -> void:
	combat_module.setup()
	movement_module.setup()
	animation_module.setup()

func is_dead() -> bool:
	return combat_module.health <= 0

func is_target_in_range() -> bool:
	if !target: return false
	return global_position.distance_to(target.global_position) <= combat_module.attack_range

func get_closest_target() -> Troop:
	var opponents = CombatManager.instance.get_alive_opponents(faction)
	var distance = 10000.0
	var current_target = null;
	for opponent in opponents:
		var distance_to_current_target = global_position.distance_to(opponent.global_position)
		if distance_to_current_target < distance:
			distance = distance_to_current_target
			current_target = opponent
	return current_target

func check_target():
	if target == null || target.is_dead():
		target = get_closest_target()
		if target == null: return
		
		movement_module.reset(target)

func check_state():
	var new_state_id = state_machine.get_state_from_context(self)
	if new_state_id == current_state.get_state_id():
		return
	
	print("Troop " + str(self) + " switch to " + StateMachine.STATES.keys()[new_state_id])
	current_state.on_state_exit(target)
	current_state = state_machine.get_state_from_id(new_state_id, self)
	current_state.on_state_enter(target)
