class_name AnimationModule extends AnimatedSprite2D

var troop : Troop

func setup():
	troop = get_parent()
	troop.y_sort_enabled = true # make sprites ordering y-axis dependent (parent must enable prop)
	flip_h = troop.faction == CombatManager.FACTIONS.ENEMIES

func play_resurrection_animation():
	if troop.faction != CombatManager.FACTIONS.ENEMIES: return
	
	play("res")
	await animation_finished
	play("res-loop")
