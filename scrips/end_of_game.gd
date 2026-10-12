
extends Node2D

@onready var main_menu_button: Button = $MainMenuButton
@onready var restart_button: Button = $RestartButton

func _ready() -> void:
	main_menu_button.pressed.connect(main_menu)
	restart_button.pressed.connect(restart_game)

func main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func restart_game() -> void:
	get_tree().reload_current_scene()
