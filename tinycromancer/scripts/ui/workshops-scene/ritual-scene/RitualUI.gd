class_name RitualUI extends Control

const RITUAL_PER_PAGE = 5

@export_group("Components")
@export var ritual_recipe_container : HBoxContainer
@export var page_indicator_container : HBoxContainer
@export var previous_page_button : TextureButton
@export var next_page_button : TextureButton

var selected_ritual_recipe : RitualRecipe
var page_indicators : Array[PageIndicator]
var current_page : int

func _ready() -> void:
	current_page = 1
	init_page_indicators()
	init_ritual_recipes(1)
	init_buttons()

func init_page_indicators():
	for i in range(get_page_amount()):
		var page_indicator = PageIndicator.create_page_indicator()
		page_indicators.append(page_indicator)
		page_indicator_container.add_child(page_indicator)
	page_indicators[0].select_page()

func init_ritual_recipes(page :  int):
	var ritual_recipe_amount = RITUAL_PER_PAGE if page != get_page_amount() else UserData.ritual_recipes.size() % RITUAL_PER_PAGE
	for i in range((page - 1) * RITUAL_PER_PAGE, (page - 1) * RITUAL_PER_PAGE + ritual_recipe_amount, 1):
		var ritual_recipe = UserData.ritual_recipes[i]
		ritual_recipe_container.add_child(ritual_recipe)


func init_buttons():
	previous_page_button.pressed.connect(display_previous_page)
	next_page_button.pressed.connect(display_next_page)
	update_button_status()

func update_button_status():
	previous_page_button.disabled = current_page <= 1
	next_page_button.disabled = current_page >= get_page_amount()

func get_page_amount() -> int:
	return ceil(UserData.ritual_recipes.size() / float(RITUAL_PER_PAGE))

func display_previous_page():
	update_button_status()
	if current_page <= 1: return
	
	var new_page = current_page - 1
	reset_ritual_recipes()
	init_ritual_recipes(new_page)
	page_indicators[current_page - 1].unselect_page()
	page_indicators[new_page - 1].select_page()
	current_page = new_page
	update_button_status()

func display_next_page():
	update_button_status()
	if current_page >= get_page_amount(): return
	
	var new_page = current_page + 1
	reset_ritual_recipes()
	init_ritual_recipes(new_page)
	page_indicators[current_page - 1].unselect_page()
	page_indicators[new_page - 1].select_page()
	current_page = new_page
	update_button_status()

func reset_ritual_recipes():
	for ritual_recipe in ritual_recipe_container.get_children():
		ritual_recipe_container.remove_child(ritual_recipe)
