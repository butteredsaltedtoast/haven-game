extends Node

var player: Player
var hp: float
var xp: int = 0
var xp_to_next: int = 3
var max_bounces: int = 2
var max_pierces: int = 2

func _process(_delta: float) -> void:
	if(xp_to_next <= xp):
		print("level up")
		xp_to_next += 1
		xp = 0
