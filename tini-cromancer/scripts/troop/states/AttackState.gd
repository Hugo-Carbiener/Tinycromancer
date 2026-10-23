class_name AttackState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter():
	troop.combat_module.reset()

func on_state_exit():
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.IDLE

func process(_delta: float):
	troop.combat_module.process(_delta)
