class_name TooltipFactory extends Control

## Scipt to place on elements that must display a tooltip 
##
## This overrides the default tooltip using the content set in the inspector

@export var tooltip_type : TYPE;

## Used to displayed tooltips that need additional loading
var preloaded_tooltip : Object;

enum TYPE {
	RITUAL
}

func _make_custom_tooltip(for_text):
	match tooltip_type:
		TYPE.RITUAL:
			return preloaded_tooltip.duplicate();
