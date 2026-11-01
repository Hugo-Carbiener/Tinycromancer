@abstract class_name State

var troop : Troop
var animation_on_state_enter : String

func _init(_troop : Troop, animation : String):
	troop = _troop
	animation_on_state_enter = animation

func on_state_enter(_target : Troop):
	troop.animation_module.play(animation_on_state_enter)

@abstract func get_next_state() -> StateMachine.STATES
@abstract func on_state_exit(target : Troop)
@abstract func get_state_id() -> StateMachine.STATES
@abstract func process(_delta: float, target : Troop)
