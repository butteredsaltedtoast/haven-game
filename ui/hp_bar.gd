extends HBoxContainer

@export var full: Texture2D
@export var empty: Texture2D

func update_display(new_hp: int) -> void:
	for x in range(get_child_count()):
		var icon: TextureRect = get_child(x) as TextureRect
		if x < GameState.player.hp:
			icon.texture = full
		else:
			icon.texture = empty
