extends Node

"""
Will get the sprite node from the parent, and change the texture of the parent
"""

export (Array,Resource) var sprites

func _ready():
	var i = randi() % sprites.size()
	get_parent().get_node("Sprite").texture = sprites[i]
	pass
