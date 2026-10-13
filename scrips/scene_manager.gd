
extends Node

@onready var game_state = $"../GameState"
@onready var bottom_bar = $"../CanvasLayer/UI/BottomBar"
@onready var end_of_game = $"../CanvasLayer/UI/end_of_game"
@onready var game_over = $"../CanvasLayer/UI/game_over"
@onready var music_player = $"BackgroundMusic"

var result_shown: bool = false

func _ready() -> void:
	bottom_bar.show()
	end_of_game.hide()
	game_over.hide()

func _process(_delta: float) -> void:
	if result_shown:
		return

	if game_state.current_state == game_state.State.PLAYING:
		if !music_player.playing:
			music_player.play()

	if game_state.current_state == game_state.State.GAME_OVER:
		if music_player.playing:
			music_player.stop()
		result_shown = true
		bottom_bar.hide()
		game_over.show()

	elif game_state.current_state == game_state.State.GAME_COMPLETE:
		if music_player.playing:
			music_player.stop()
		result_shown = true
		bottom_bar.hide()
		end_of_game.show()
