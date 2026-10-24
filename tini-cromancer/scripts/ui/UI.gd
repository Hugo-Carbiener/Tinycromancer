class_name UI extends Control

@export_group("Currency components")
@export var currency_amount_label : Label
@export var currency_icon : TextureRect
@export_group("Hint components")
@export var hint_label : Label
var hint_label_glow_tween : Tween

func _ready() -> void:
	dispatch_currency()
	dispatch_hint()
	SignalBus.on_battle_started.connect(on_battle_started)

func dispatch_currency():
	currency_amount_label.text = str(UserData.souls)
	AnimationsUtils.bounce(currency_icon, 1.5)

func dispatch_hint():
	hint_label.modulate.a = 0
	await AnimationsUtils.fade(hint_label, 1., Constants.LONG_TRANSITION_DURATION)
	hint_label_glow_tween = AnimationsUtils.glow(hint_label, Constants.LONG_TRANSITION_DURATION, 0.5)

func on_battle_started():
	hint_label_glow_tween.kill()
	hint_label.visible = false
