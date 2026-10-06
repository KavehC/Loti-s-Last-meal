extends Node

enum State {
	PLAYING,
	PAUSED,
	GAME_OVER,
	LEVEL_COMPLETE
}

var current_state: State = State.PLAYING

func set_state(new_state: State) -> void:
	current_state = new_state
