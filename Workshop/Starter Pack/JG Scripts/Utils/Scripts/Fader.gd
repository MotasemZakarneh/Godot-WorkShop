extends CanvasLayer

export var def_dur = 3
export (Color) var def_out_color
export (Color) var def_in_color
signal on_faded
signal on_faded_in
signal on_faded_out

func fade_out(dur,out_color):
	$Tween.interpolate_property($ColorRect,"color",$ColorRect.color,out_color,dur,Tween.TRANS_SINE,Tween.EASE_IN_OUT,0)
	yield(get_tree().create_timer(dur+0.01),"timeout")
	emit_signal("on_faded")
	emit_signal("on_faded_out")
	pass

func fade_in(dur,in_color):
	$Tween.interpolate_property($ColorRect,"color",$ColorRect.color,in_color,dur,Tween.TRANS_SINE,Tween.EASE_IN_OUT,0)
	yield(get_tree().create_timer(dur+0.01),"timeout")
	emit_signal("on_faded")
	emit_signal("on_faded_in")
	pass

func def_fade_in():
	fade_in(def_dur,def_in_color)
	pass

func def_fade_out():
	fade_out(def_dur,def_out_color)
	pass
