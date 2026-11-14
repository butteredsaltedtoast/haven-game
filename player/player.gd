class_name Player
extends CharacterBody2D

@export var speed: float = 300.0
@export var max_hp: float = 100.0
@export var ball_scene: PackedScene

@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D

var hp: float = 0.0
var level: float = 0.0
var xp: float = 0


enum STATES {
IDLE,
MOVING,
DEAD,
ATTACK,
}

var current_state = STATES.IDLE
var last_dir: String = "down"

func _ready() -> void:
	GameState.player = self

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if direction:
		current_state = STATES.MOVING
	if current_state == STATES.MOVING:
		pass
	elif not direction:
		current_state = STATES.IDLE

	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		asprite.play("idle_" + last_dir)
		return
	if abs(direction.x) > abs(direction.y):
		last_dir = "right" if direction.x > 0 else "left"
	else:
		last_dir = "down" if direction.y > 0 else "up"
	asprite.play("idle_" + last_dir) # get a walk animation at some point?
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hit_ball"):
		launch_ball()

func launch_ball() -> void:
	var ball = ball_scene.instantiate()
	get_tree().current_scene.add_child(ball)
	ball.global_position = global_position
	ball.direction = global_position.direction_to(get_global_mouse_position())
