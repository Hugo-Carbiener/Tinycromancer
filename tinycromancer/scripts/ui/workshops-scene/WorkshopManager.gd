class_name WorkshopManager extends Control

const warcamp_scene : PackedScene = preload("res://scenes/workshops/warcamp_ui.tscn")
const shop_scene : PackedScene = preload("res://scenes/workshops/shop_ui.tscn")
const ritual_scene : PackedScene = preload("res://scenes/workshops/ritual/ritual_ui.tscn")

@export_group("Data")
@export var tabDataList : Array[TabData]
@export_group("Components")
@export var tab_container : HBoxContainer
@export var workshop_container : MarginContainer
@export var resource_container : HBoxContainer

var tabs : Array[Tab]
var selected_tab : Tab
var opened_workshop : CanvasItem

enum WORKSHOPS {
	WARCAMP,
	SHOP,
	RITUAL
}

var sceneByWorkshop = {
	WORKSHOPS.WARCAMP : warcamp_scene,
	WORKSHOPS.SHOP : shop_scene,
	WORKSHOPS.RITUAL : ritual_scene
}

func _ready() -> void:
	setup()

func setup():
	SignalBus.tab_clicked.connect(on_tab_selected)
	init_resources()
	generateTabs()
	open_default_scene()

func init_resources():
	for resources in UserData.resources.keys():
		var resource_display = ResourceDisplay.create_resource_display(resources)
		resource_container.add_child(resource_display)

func generateTabs():
	for tabData in tabDataList:
		var tab = Tab.create_tab(tabData)
		tabs.append(tab)
		tab_container.add_child(tab)

func open_default_scene():
	tabs[0].button.button_pressed = true
	selected_tab = tabs[0]
	load_tab_scene(selected_tab)

func on_tab_selected(tab : Tab):
	if selected_tab == null || selected_tab == tab: return
	
	selected_tab.unselect()
	selected_tab = tab
	load_tab_scene(selected_tab)

func load_tab_scene(tab : Tab):
	var scene_to_load;
	match (tab.tab_destination):
		WORKSHOPS.WARCAMP:
			scene_to_load = warcamp_scene.instantiate()
		WORKSHOPS.SHOP:
			scene_to_load = shop_scene.instantiate()
		WORKSHOPS.RITUAL:
			scene_to_load = ritual_scene.instantiate()
	
	if opened_workshop != null:
		opened_workshop.queue_free()
	workshop_container.add_child(scene_to_load)
	opened_workshop = scene_to_load
