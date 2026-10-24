class_name LichManager extends AnimatedSprite2D

static var instance : LichManager

func _ready() -> void:
	if instance == null:
		instance = self

func on_fight_win():
	play_corpse_resurrection()
	await play_lich_spell()

func on_fight_lost():
	pass

func play_lich_spell():
	play("spell-1")
	await animation_finished
	play("spell-2")

func play_corpse_resurrection():
	for enemy in CombatManager.instance.enemies:
		enemy.animation_module.play_resurrection_animation()
