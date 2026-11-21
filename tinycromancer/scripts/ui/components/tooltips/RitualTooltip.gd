class_name RitualTooltip extends Tooltip

const ritual_tooltip_scene : PackedScene = preload("res://scenes/ui-components/tooltips/ritual_tooltip.tscn")

@export var troop_icon : TextureRect
@export var magic_icon : TextureRect
@export var magic_label : Label
@export var cost_container : HBoxContainer
@export var uses_label : Label

static func create_ritual_tooltip(ritual_recipe : RitualRecipe) -> RitualTooltip:
	var tooltip = ritual_tooltip_scene.instantiate()
	tooltip.setup(ritual_recipe)
	return tooltip

func setup(ritual_recipe : RitualRecipe):
	troop_icon.texture = TroopFactory.troop_icons[ritual_recipe.troop_type]
	magic_icon.texture = RitualFactory.icons[ritual_recipe.magic_type]
	magic_label.text = RitualFactory.magicNames[ritual_recipe.magic_type]
	uses_label.text = str(ritual_recipe.uses_left) + "/" + str(ritual_recipe.max_uses) + " Uses"
	for cost_type in ritual_recipe.resource_cost.keys():
		var resource_display = ResourceDisplay.create_cost_display(cost_type, ritual_recipe.resource_cost[cost_type])
		cost_container.add_child(resource_display)
