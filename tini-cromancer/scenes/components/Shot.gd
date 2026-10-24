class_name Shot extends Node2D

const shot_scene: PackedScene = preload("res://scenes/components/shot.tscn")

@export var shot_duration : float
var target : Troop
var damage : int

static func create_shot(_id : int, _target : Troop, _damage : int):
	var shot = shot_scene.instantiate()
	shot.target = _target
	shot.damage = _damage
	return shot
	
func destroy_shot():
	queue_free()

func launch():
	modulate.a = 0
	AnimationsUtils.fade(self,1.,shot_duration)
	await AnimationsUtils.move(self,global_position,target.global_position,shot_duration)
	target.combat_module.take_damage(damage)
	destroy_shot()
		#SignalBus.shot_touched.emit(id)
