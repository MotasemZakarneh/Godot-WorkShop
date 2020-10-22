extends Node2D

#Simple Unit Behavior, the ColorSwitcherFSM talks to this unit
#and has a reference to the unit script, which should control the behavior of the unit

func change_color(to):
	$Sprite.modulate = to
	pass

func set_scale_to(s):
	scale = s
	pass
