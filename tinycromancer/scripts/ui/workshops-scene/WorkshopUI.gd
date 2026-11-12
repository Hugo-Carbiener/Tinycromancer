class_name WorkshopUI extends Control

@export var resource_container : HBoxContainer

func _ready() -> void:
	init_resources()

func init_resources():
	for resources in UserData.resources.keys():
		var resource_display = ResourceDisplay.create_resource_display(resources)
		resource_container.add_child(resource_display)
