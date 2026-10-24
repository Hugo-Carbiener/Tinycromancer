class_name CombatModule extends Node2D

@export var max_health : int
@export var attack_cooldown_duration : float 
@export var attack_damage : int
@export var attack_range : int
var troop : Troop
var health : int
var attack_cooldown : float

func setup():
	troop = get_parent()
	health = max_health

func reset():
	attack_cooldown = attack_cooldown_duration

func process(delta : float, target : Troop):
	attack_cooldown -= delta
	if attack_cooldown <= 0.:
		execute_attack(target)
		attack_cooldown = attack_cooldown_duration - abs(attack_cooldown) # keep track of overhead time

func execute_attack(target : Troop):
	if is_melee():
		execute_melee_attack(target)
	else:
		execute_ranged_attack(target)
	
func execute_melee_attack(target : Troop):
	await dispatch_attack()
	target.combat_module.take_damage(attack_damage)
	print("attack target of " + str(target.faction) + " | target health goes to " + str(target.combat_module.health))

func execute_ranged_attack(target : Troop):
	dispatch_attack()
	var current_shot_id = CombatManager.instance.shot_id
	CombatManager.instance.shot_id +=1
	var new_shot = Shot.create_shot(current_shot_id,target,attack_damage)
	add_child(new_shot)
	new_shot.launch()

func dispatch_attack():
	troop.animation_module.play("hit")
	await troop.animation_module.animation_finished
	troop.animation_module.play("idle")

func take_damage(damage_amount : int):
	health -= damage_amount
	# TODO blink sprite

func is_melee():
	return attack_range <= Constants.MAX_RANGE_MELEE
