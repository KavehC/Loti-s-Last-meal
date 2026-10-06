extends Node

@onready var game_state = $"../GameState"

var max_health: int = 100
var health: int = 100

func damage_taken(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		health = 0
		game_state.set_state(game_state.State.GAME_OVER)
