extends Node2D

@export var food_name: String
@export var food_image: Texture2D
@export var food_safety: float    # For now, a number between -3 and 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_sprite = Sprite2D.new()
	new_sprite.texture = food_image
	add_child(new_sprite)
