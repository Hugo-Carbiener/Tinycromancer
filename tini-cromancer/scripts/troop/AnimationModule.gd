class_name AnimationModule extends AnimatedSprite2D

var troop : Troop

func setup():
	troop = get_parent()
	flip_h = troop.faction == CombatManager.FACTIONS.ENEMIES
	
