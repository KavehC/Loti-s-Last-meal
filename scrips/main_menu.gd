extends Control

@onready var start_button = $StartButton

func _ready() -> void:
	start_button.pressed.connect(start_game)

func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/GameScene.tscn")
