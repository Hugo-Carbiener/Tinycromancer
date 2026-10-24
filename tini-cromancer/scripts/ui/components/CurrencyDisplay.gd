class_name CurrencyDisplay extends Control

@export var currency_amount_label : Label
@export var currency_icon : TextureRect

func _ready() -> void:
	SignalBus.currency_amount_updated.connect(dispatch_currency)
	currency_icon.pivot_offset = currency_icon.size/2
	update_currency()

func update_currency():
	currency_amount_label.text = str(UserData.souls)

func dispatch_currency(from : int, to : int):
	await AnimationsUtils.animate_integer(
		func(x): currency_amount_label.text = str(x),
		from,
		to)
	AnimationsUtils.bounce(currency_icon, 1.5)
