class_name UI extends Control

@export_group("Currency components")
@export var currency_amount_label : Label
@export var currency_icon : TextureRect

func _ready() -> void:
	dispatch_currency()

func dispatch_currency():
	currency_amount_label.text = str(UserData.souls)
	AnimationsUtils.bounce(currency_icon, 1.5)
