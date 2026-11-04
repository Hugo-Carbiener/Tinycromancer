class_name TabManager extends Control

@export_group("Debug")
@export var tab_amount : int

var tabs : Dictionary[int, Tab]
var selected_tab : int = -1

func setup():
	SignalBus.tab_clicked.connect(on_tab_selected)
	tabs[0].button_pressed = true
	selected_tab = 0

func _ready() -> void:
	setup()

func on_tab_selected(id : int):
	if id == selected_tab: return
	
	tabs[selected_tab].unselect()
	selected_tab = id
