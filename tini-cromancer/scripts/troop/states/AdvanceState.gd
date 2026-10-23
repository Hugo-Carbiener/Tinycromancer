class_name AdvanceState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter():
	#TODO switch to idle animation
	pass

func on_state_exit():
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.IDLE

func process(_delta: float):
	# nothing to do while idle
	pass
