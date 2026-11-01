class_name Tab extends TextureButton

@export var on_tab_selected_signal : String

func _ready() -> void:
	toggled.connect(on_toggle)
	if !SignalBus.has_signal(on_tab_selected_signal):
		printerr("Error in Tab.gd: signal " + on_tab_selected_signal + " not implemented")

func on_toggle(on : bool):
	if on:
		SignalBus.emit_signal(on_tab_selected_signal)
