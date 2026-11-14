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
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.position = GameState.player.global_position + Vector2(randf_range(0, 960), randf_range(0, 540))
	enemies.add_child(enemy)
	
