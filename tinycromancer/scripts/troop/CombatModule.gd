class_name CombatModule extends Node2D

@export var max_health : int
@export var attack_cooldown_duration : float 
@export var attack_damage : int
@export var attack_range : int
var troop : Troop
var health : int
var attack_cooldown : float
var is_blinking : bool = false

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
	if !target.is_dead():
		target.combat_module.take_damage(attack_damage)

func execute_ranged_attack(target : Troop):
	dispatch_attack()
	var current_shot_id = CombatManager.instance.shot_id
	CombatManager.instance.shot_id +=1
	var new_shot = Shot.create_shot(current_shot_id,target,attack_damage)
	add_child(new_shot)
	new_shot.launch()

func dispatch_attack():
	troop.animation_module.play("hit")

func take_damage(damage_amount : int):
	health -= damage_amount
	await dispatch_damage()
	if health <= 0:
		on_death()

func dispatch_damage():
	if is_blinking: return
	is_blinking = true
	await AnimationsUtils.blink_sprite(troop.animation_module)
	is_blinking = false

func on_death():
	CombatManager.instance.on_troop_death(troop)

func is_melee():
	return attack_range <= Constants.MAX_RANGE_MELEE
