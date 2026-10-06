extends Node2D

@export var food_item_scene: PackedScene
var current_food_item: Node2D # Variable that points to the current food item
enum food_type {CAKE, STEAK, EGGS}

# Instantiate a food item depending on its type
func instantiate_food(food: food_type) -> void:
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
	add_child(food_item_instance)
	if (current_food_item == null):
		current_food_item = food_item_instance
	
func remove_current_food() -> void:
	if (current_food_item != null):
		current_food_item.remove_from_group("foodItems") 
		current_food_item.queue_free()
		current_food_item = null
	# Assigns next food item to the current_food_item
	var next_food_item = get_tree().get_first_node_in_group("foodItems")
	if (next_food_item != null):
		current_food_item = next_food_item
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instantiate_food(food_type.CAKE) # testing
	instantiate_food(food_type.CAKE) # testing
	remove_current_food()
	remove_current_food()
	remove_current_food()
	remove_current_food()
