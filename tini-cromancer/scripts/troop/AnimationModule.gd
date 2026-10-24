class_name AnimationModule extends AnimatedSprite2D

var troop : Troop

func setup():
	troop = get_parent()
	flip_h = troop.faction == CombatManager.FACTIONS.ENEMIES

func play_resurrection_animation():
	if troop.faction != CombatManager.FACTIONS.ENEMIES: return
	
	play("res")
	await animation_finished
	play("res-loop")
