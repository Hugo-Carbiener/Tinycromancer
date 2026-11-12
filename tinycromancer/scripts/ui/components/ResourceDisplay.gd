class_name ResourceDisplay extends Control

const resource_display_scene : PackedScene = preload("res://scenes/ui-components/resource_display.tscn")

@export var resource_amount_label : Label
@export var resource_icon : TextureRect
var target_resource : ResourceManager.Resources

static func create_resource_display(_target_resource : ResourceManager.Resources) -> ResourceDisplay:
	var resource_display = resource_display_scene.instantiate()
	resource_display.setup(_target_resource)
	return resource_display

func setup(_target_resource : ResourceManager.Resources):
	target_resource = _target_resource
	resource_icon.pivot_offset = resource_icon.size/2
	SignalBus.resource_amount_updated.connect(dispatch_currency)
	update_resource()

func update_resource():
	resource_amount_label.text = str(UserData.resources[target_resource])

func dispatch_currency(resource : ResourceManager.Resources, from : int, to : int):
	if resource != target_resource: return
	
	await AnimationsUtils.animate_integer(
		func(x): resource_amount_label.text = str(x),
		from,
		to)
	AnimationsUtils.bounce(resource_icon, 1.5)
