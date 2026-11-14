class_name HP_Bar
extends HBoxContainer

@export var full: Texture2D
@export var empty: Texture2D

func _ready() -> void:
	GameState.hud = self
	await get_tree().process_frame
	if GameState.player:
		update_display(GameState.player.hp)

func update_display(new_hp: float) -> void:
	for i in range(get_child_count()):
		var icon := get_child(i) as TextureRect
		if icon:
			icon.texture = full if i < new_hp else empty
