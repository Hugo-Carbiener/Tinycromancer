class_name AttackState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter(_target : Troop):
	troop.combat_module.reset()

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.ATTACK

func process(_delta: float, target : Troop):
	troop.combat_module.process(_delta,target)
