extends CharacterBody2D

@export var SPEED = 300.0

enum STATES {
IDLE,
MOVING,
DEAD,
ATTACK,
}

var current_state = STATES.IDLE

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	if direction:
		current_state = STATES.MOVING
	if current_state == STATES.MOVING:
		print("moving")
	elif not direction:
		current_state = STATES.IDLE
		print("not moving")

	move_and_slide()
