class_name DeadState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func on_state_enter(_target : Troop):
	super(troop)
	# TODO remove hitbox

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.DEAD

func process(_delta: float, _target : Troop):
	# nothing to do while idle
	pass
