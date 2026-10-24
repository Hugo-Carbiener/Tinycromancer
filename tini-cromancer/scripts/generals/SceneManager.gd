extends Node2D

var titlescreen : PackedScene = preload("res://scenes/title_screen.tscn");
#var fight : PackedScene = preload("res://scenes/combat.tscn");
var fight : PackedScene = preload("res://scenes/combat_jow.tscn");
var shop : PackedScene = preload("res://scenes/shop.tscn");

func _ready() -> void:
	SignalBus.shop_clicked.connect(open_shop);
	SignalBus.next_level_clicked.connect(start_fight);

func menu():
	get_tree().change_scene_to_packed(titlescreen);

func open_shop():
	get_tree().change_scene_to_packed(shop);

func start_fight():
	print("go fight")
	get_tree().change_scene_to_packed(fight);
