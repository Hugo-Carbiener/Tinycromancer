@abstract class_name State

var troop : Troop

func _init(_troop : Troop):
	troop = _troop

@abstract func on_state_enter(target : Troop)
@abstract func on_state_exit(target : Troop)
@abstract func get_state_id() -> StateMachine.STATES
@abstract func process(_delta: float, target : Troop)
