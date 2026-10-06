extends Node2D

@export var food_item_scene: PackedScene
enum food_type {CAKE, STEAK, EGGS}

# Instantiate a food item depending on its type
func _instantiate_food(food: food_type) -> void:
	var food_item_instance = food_item_scene.instantiate()
	match food:
		food_type.CAKE:
			food_item_instance.food_name = "Cake"
			food_item_instance.food_image = load("res://temp/cake.jpg")
		food_type.STEAK:
			food_item_instance.food_name = "Steak"
			#food_item_instance.food_image = load("res://temp/steak.jpg")
		food_type.EGGS:
			food_item_instance.food_name = "Eggs"
			#food_item_instance.food_image = load("res://temp/eggs.jpg")
	
	food_item_instance.food_safety = randf_range(-3, 3)
	print(food_item_instance.food_safety)
	add_child(food_item_instance)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instantiate_food(food_type.CAKE) # testing
