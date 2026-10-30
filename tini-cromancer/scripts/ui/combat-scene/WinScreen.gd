class_name WinScreen extends PopUpScreen

const currency_icon_scene : PackedScene = preload("res://scenes/ui/currency_icon.tscn")

@export_group("Components")
@export var content_title : Label
@export var soul_container : HBoxContainer

func launch():
	content_title.modulate.a = 0
	modulate.a = 0
	content_title.visible = true
	visible = true;
	await AnimationsUtils.fade(self, 1., Constants.DEFAULT_TRANSITION_DURATION)
	await AnimationsUtils.fade(content_title, 1., Constants.DEFAULT_TRANSITION_DURATION)
	dispatch_souls()

func dispatch_souls():
	var currency_icon = currency_icon_scene.instantiate()
	currency_icon.modulate.a = 0
	currency_icon.scale = Vector2.ONE * 1.5
	for i in range(CombatManager.instance.enemies.size()):
		var current_icon = currency_icon.duplicate()
		soul_container.add_child(current_icon)
		AnimationsUtils.fade(current_icon, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.DEFAULT_TRANSITION_DURATION/2 * (i - 1))
		AnimationsUtils.animate_scale(current_icon, current_icon.scale, Vector2.ONE, Constants.DEFAULT_TRANSITION_DURATION)
