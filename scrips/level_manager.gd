extends Node

@onready var game_state = $"../GameState"

var current_level: int = 1
var max_level: int = 3

var food_eaten: int = 0
var food_required: int = 5

func food_consumed() -> void:
	food_eaten += 1
	
	if food_eaten >= food_required:
		if next_level():
			game_state.set_state(game_state.State.LEVEL_COMPLETE)
	
func next_level() -> bool:
	if current_level < max_level and food_eaten >= food_required:
		current_level += 1
		food_eaten = 0
		return true
		
	return false
