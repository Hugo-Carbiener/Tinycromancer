class_name DeadState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter(_target : Troop):
	troop.visible = false
	# TODO remove hitbox

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.DEAD

func process(_delta: float, _target : Troop):
	# nothing to do while idle
	pass
