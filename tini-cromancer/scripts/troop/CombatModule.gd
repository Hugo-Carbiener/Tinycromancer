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
	await dispatch_attack()
	target.combat_module.take_damage(attack_damage)
	print("attack target of " + str(target.faction) + " | target health goes to " + str(target.combat_module.health))

func dispatch_attack():
	troop.animation_module.play("hit")
	await troop.animation_module.animation_finished
	troop.animation_module.play("idle")

func take_damage(damage_amount : int):
	health -= damage_amount
	# TODO blink sprite
