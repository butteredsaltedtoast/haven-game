extends CharacterBody2D

@export var SPEED: float = 100.0
@export var DAMAGE: float = 20.0

@onready var player_pos = Vector2(0, 0) # hey!! replace this later!!!!! because! it's a placeholder. mhm.

func _ready() -> void:
	pass #will be needed laterrr

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player_pos)
	velocity = direction * SPEED
	move_and_slide()

func _process(delta: float) -> void:
	pass #idk do smth here if u wanttt
