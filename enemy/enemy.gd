class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 100.0
@export var DAMAGE: float = 20.0

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(GameState.player.global_position)
	velocity = direction * SPEED
	move_and_slide()
