class_name CombatModule extends Node2D

@export var max_health : int
@export var attack_cooldown_duration : float 
@export var attack_damage : int
@export var attack_range : int
var health : int
var attack_cooldown : float

func setup():
	health = max_health

func reset():
	attack_cooldown = attack_cooldown_duration

func process(delta : float):
	attack_cooldown -= delta
	if attack_cooldown <= 0.:
		execute_attack()
		attack_cooldown = attack_cooldown_duration - abs(attack_cooldown) # keep track of overhead time

func execute_attack():
	#troop.target.combat_module.take_damage(attack_damage)

func take_damage(damage_amount : int):
	health -= damage_amount
	# TODO blink sprite
