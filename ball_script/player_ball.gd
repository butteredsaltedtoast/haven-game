extends Area2D

func _input(event) -> void:
	self.visible = false
	if event.is_action_pressed("hit_ball"):
		self.visible = true
