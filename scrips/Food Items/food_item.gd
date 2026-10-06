extends Node2D

@export var food_name: String
@export var icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_sprite = Sprite2D.new()
	new_sprite.texture = icon
	add_child(new_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
