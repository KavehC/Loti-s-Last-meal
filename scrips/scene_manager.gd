extends Node

@onready var game_state = $"../GameState"

func _process(_delta: float) -> void:
	if game_state.current_state == game_state.State.GAME_OVER:
		change_scene("res://scenes/game_over.tscn")

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
