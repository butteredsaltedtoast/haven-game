extends Node

@export var enemy_scene: PackedScene
@export var base_interval: float = 2

@export var enemies: Node2D

var spawn_cooldown: float = 0

func _physics_process(delta: float) -> void:
	spawn_cooldown -= delta
	if spawn_cooldown <= 0:
		spawn_enemy()
		spawn_cooldown = base_interval

func spawn_enemy() -> void:
	if not is_instance_valid(GameState.player):
		return
	var spawn_pos: Vector2
	var min_safe_distance: float = 120.0
	var margin: float = 32.0
	for attempt in 10:
		spawn_pos = Vector2(
			randf_range(margin, 960.0 - margin),
			randf_range(margin, 540.0 - margin)
		)
		if spawn_pos.distance_to(GameState.player.global_position) >= min_safe_distance:
			break
	var enemy: Enemy = enemy_scene.instantiate()
	enemies.add_child(enemy)
	enemy.global_position = spawn_pos
