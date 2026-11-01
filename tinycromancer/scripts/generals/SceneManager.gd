extends Node2D

var fight : PackedScene = preload("res://scenes/combat.tscn");
var shop : PackedScene = preload("res://scenes/workshops.tscn");

func _ready() -> void:
	SignalBus.shop_clicked.connect(open_shop);
	SignalBus.next_level_clicked.connect(start_fight);

func open_shop():
	get_tree().change_scene_to_packed(shop);

func start_fight():
	get_tree().change_scene_to_packed(fight);
