extends CharacterBody2D

@export var speed: float = 600.0

var current_bounces: int = 0
var enemies_hit: int = 0
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	var coll: KinematicCollision2D = move_and_collide(direction * speed * delta)
	if coll:
		direction = direction.bounce(coll.get_normal())
		current_bounces += 1
		if current_bounces >= GameState.max_bounces:
			queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemies_hit += 1
		print("hit enemy # ", enemies_hit)
		# DAMAGE HERE IARHSDKJFKLJAFHZ
		if enemies_hit >= GameState.max_pierces:
			queue_free()
