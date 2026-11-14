class_name Player
extends CharacterBody2D

@export var speed: float = 300.0
@export var max_hp: float = 3.0
@export var ball_scene: PackedScene

@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D

var hp: float
var level: int = 0
var xp: float = 0.0
var hit_cooldown: float = 0.0

enum STATES {
	IDLE,
	MOVING,
	DEAD,
	ATTACK,
}

var current_state: STATES = STATES.IDLE
var last_dir: String = "down"

func _ready() -> void:
	hp = max_hp
	GameState.player = self

func _physics_process(delta: float) -> void:
	if current_state == STATES.DEAD:
		return

	if hit_cooldown > 0.0:
		hit_cooldown = maxf(hit_cooldown - delta, 0.0)

	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	current_state = STATES.MOVING if direction != Vector2.ZERO else STATES.IDLE

	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			last_dir = "right" if direction.x > 0 else "left"
		else:
			last_dir = "down" if direction.y > 0 else "up"
			
	asprite.play("idle_" + last_dir)

func _unhandled_input(event: InputEvent) -> void:
	if current_state == STATES.DEAD:
		return
	if event.is_action_pressed("hit_ball"):
		launch_ball()

func launch_ball() -> void:
	if not ball_scene:
		push_warning("ball_scene is not assigned on Player!")
		return
		
	var ball = ball_scene.instantiate()
	get_tree().current_scene.add_child(ball)
	ball.global_position = global_position
	ball.direction = global_position.direction_to(get_global_mouse_position())

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if hit_cooldown > 0.0 or current_state == STATES.DEAD:
		return
	if area.is_in_group("enemies") or area.get_parent().is_in_group("enemies"):
		hp = maxf(hp - 1.0, 0.0)
		print("took damage")
		GameState.hud.update_display(hp)
		hit_cooldown = 1.5
		if hp <= 0.0:
			current_state = STATES.DEAD
