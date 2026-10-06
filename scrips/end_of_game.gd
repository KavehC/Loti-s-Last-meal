extends Control

@onready var restart_button = $RestartButton

func _ready() -> void:
	restart_button.pressed.connect(restart_game)

func restart_game() -> void:
	get_tree().change_scene_to_file("res://scenes/GameScene.tscn")
