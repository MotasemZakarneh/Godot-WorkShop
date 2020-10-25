extends Node

"""
Will change the scale of the sprite of the parent
"""

export var sprite_scale = 0.1

func _ready():
	randomize()
	get_parent().get_node("Sprite").scale = Vector2(sprite_scale,sprite_scale)
	pass 

