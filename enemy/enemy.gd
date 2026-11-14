class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 100.0
@export var DAMAGE: float = 20.0
@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	asprite.play("balloon_" + str(randi_range(1, 5)))

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(GameState.player.global_position)
	velocity = direction * SPEED
	move_and_slide()
