
extends Panel

@onready var game_state = get_node("../../../GameState")
@onready var loti = get_node("../../../Loti")
@onready var loti_image: Sprite2D = get_node("../../../Loti/Loti's Image")

@onready var buttons: Array[Button] = [
	$"Option One",
	$"Option One2",
	$"Option One3"
]

var foods: Array[Dictionary] = [
	{"name": "Bread", "good": "res://asset/Good Food/good_bread.png", "bad": "res://asset/Bad Food/bad_bread.png"},
	{"name": "Burger", "good": "res://asset/Good Food/good_burger.png", "bad": "res://asset/Bad Food/bad_burger.png"},
	{"name": "Cake", "good": "res://asset/Good Food/good_cake.png", "bad": "res://asset/Bad Food/bad_cake.png"},
	{"name": "Eggs", "good": "res://asset/Good Food/good_eggs.png", "bad": "res://asset/Bad Food/bad_eggs.png"},
	{"name": "Soup", "good": "res://asset/Good Food/good_soup.png", "bad": "res://asset/Bad Food/bad_soup.png"},
	{"name": "Steak", "good": "res://asset/Good Food/good_steak.png", "bad": "res://asset/Bad Food/bad_steak.png"}
]

const MAX_CORRECT_GUESSES: int = 5
const MAX_BAD_GUESSES: int = 2

const MUTATIONS: Array[String] = [
	"mouth",
	"long",
    "neck"
]

var current_foods: Array[Dictionary] = []
var selection_in_progress: bool = false
var correct_guesses: int = 0
var bad_guesses: int = 0
var mutation_type: String = ""

func _ready() -> void:
	randomize()
	loti_image.texture = load("res://asset/Loti/default.png")

	for i in range(buttons.size()):
		buttons[i].pressed.connect(_on_food_selected.bind(i))

	_show_food_choices()

func _show_food_choices() -> void:
	if game_state.current_state != game_state.State.PLAYING:
		return

	var available_foods = foods.duplicate(true)
	available_foods.shuffle()
	current_foods.clear()

	var bad_index: int = randi_range(0, buttons.size() - 1)

	for i in range(buttons.size()):
		var food: Dictionary = available_foods[i].duplicate(true)
		food["is_bad"] = (i == bad_index)
		current_foods.append(food)

		print(food["name"], " | Bad: ", food["is_bad"])

		buttons[i].get_node("Label").text = food["name"]
		buttons[i].get_node("Food One").texture = load(food["good"])
		
		# Loading particles around bad food
		var badParticles = buttons[i].get_node("Food One/BadFoodParticles")
		badParticles.emitting = false
		badParticles.visible = false 
		if food["is_bad"]:
			badParticles.texture = load(food["good"])
			badParticles.visible = true
			badParticles.restart()
			badParticles.emitting = true
			
		buttons[i].disabled = false

	selection_in_progress = false

func _on_food_selected(index: int) -> void:
	if selection_in_progress:
		return

	if game_state.current_state != game_state.State.PLAYING:
		return

	selection_in_progress = true

	var food: Dictionary = current_foods[index]
	var image_path: String

	if food["is_bad"]:
		image_path = food["bad"]
		bad_guesses += 1

		print("Bad guesses: ", bad_guesses, "/", MAX_BAD_GUESSES)

		if bad_guesses == 1:
			mutation_type = MUTATIONS.pick_random()
			var first_mutation: String = (
				"res://asset/Mutations/" + mutation_type + "1.png"
			)
			loti_image.texture = load(first_mutation)
			print("First mutation: ", first_mutation)

		elif bad_guesses == 2:
			var second_mutation: String = (
				"res://asset/Mutations/" + mutation_type + "2.png"
			)
			loti_image.texture = load(second_mutation)
			print("Second mutation: ", second_mutation)

	else:
		image_path = food["good"]
		correct_guesses += 1

		print(
			"Correct guesses: ",
			correct_guesses,
			"/",
			MAX_CORRECT_GUESSES
		)

		# Only show food reactions before the first mutation.
		if bad_guesses == 0:
			loti_image.texture = load(
                "res://asset/Loti/default_good.png"
			)

	buttons[index].get_node("Food One").texture = load(image_path)

	for button in buttons:
		button.disabled = true

	if bad_guesses >= MAX_BAD_GUESSES:
		print("Second mutation applied; Game Over in 5 seconds.")

		await get_tree().create_timer(5.0).timeout

		if not is_inside_tree():
			return

		game_state.set_state(game_state.State.GAME_OVER)
		return

	if correct_guesses >= MAX_CORRECT_GUESSES:
		print("YOU WIN")
		game_state.set_state(game_state.State.GAME_COMPLETE)
		return

	await get_tree().create_timer(2.0).timeout

	if not is_inside_tree():
		return

	if game_state.current_state != game_state.State.PLAYING:
		return

	if bad_guesses == 0:
		loti_image.texture = load("res://asset/Loti/default.png")

	_show_food_choices()
