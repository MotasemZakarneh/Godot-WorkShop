extends Reaction

"""
Warning, this must always be the final reaction, as the entire level
will change, thus, destroying everything else in view
including the other reactions below this one.
"""

export (PackedScene) var level : PackedScene
export var do_fade = true
export var fade_dur = -1

const fader_scene = preload("res://JG/Components/SceneFader/Fader.tscn")

func _react():
	if do_fade:
		var fader = fader_scene.instance()
		get_tree().current_scene.add_child(fader)
		if fade_dur <= 0:
			fader.def_fade_in()
		else:
			fader.fade_in(fade_dur)
		yield(fader,"on_faded")
	
	
	get_tree().change_scene_to(level)
	pass
