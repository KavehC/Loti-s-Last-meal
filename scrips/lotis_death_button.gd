extends Button

@onready var loti = $"../../../../Loti"

func _ready() -> void:
	pressed.connect(kill_loti)

func kill_loti() -> void:
	loti.damage_taken(100)
