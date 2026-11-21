class_name TroopSummary extends Control

const troop_summary_scene : PackedScene = preload("res://scenes/ui-components/troop_summary.tscn")

@export_group("Components")
@export var icon : TextureRect
@export var amount : Label

static func create_troop_summary(troop_type : TroopFactory.TROOP_TYPES, troop_amount : int) -> TroopSummary:
	var troop_summary = troop_summary_scene.instantiate()
	troop_summary.setup(troop_type, troop_amount)
	return troop_summary

func setup(troop_type : TroopFactory.TROOP_TYPES, troop_amount : int):
	amount.text = "x" + str(troop_amount)
	icon.texture = TroopFactory.troop_icons[troop_type]
