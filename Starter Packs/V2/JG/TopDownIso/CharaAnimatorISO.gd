extends TopDownISO
class_name IsoCharaAnimator

var v_dir = Vector2()
var active_anim = ""
var sprite : AnimatedSprite
var dir = ""
var active_anim_set = ""
var anims_sets = []
var chara_name = ""

var directions = {
	Vector2.RIGHT : "Right",Vector2.LEFT:"Left",Vector2.UP:"Up",Vector2.DOWN:"Down",
	Vector2.ONE :"BotRight",Vector2(-1,1):"BotLeft",
	-Vector2.ONE:"TopLeft",Vector2(1,-1):"TopRight"
}

func _ready():
	sprite = get_parent().get_node("AnimatedSprite")
	pass

func setup_anims(_chara_name,_anims_sets):
	self.chara_name = _chara_name
	self.anims_sets = _anims_sets
	
	var s : SpriteFrames = Extentions.get_sprite_frames_all(anims_sets)
	sprite.frames = s
	pass

func set_active_anim_set(new_set):
	active_anim_set = new_set
	pass

func play_anim(anim:String):
	active_anim = anim
	var anim_set = "_"
	if active_anim_set != "":
		anim_set = "_" + active_anim_set +"_"
	
	var anim_name = chara_name + anim_set + active_anim + "_" + dir
	if sprite.animation == anim_name || not sprite.frames.has_animation(anim_name):
		return 
	sprite.play(anim_name)
	pass

func update_dir(new_v_dir:Vector2):
	v_dir = new_v_dir
	v_dir = Extentions.make_one(v_dir)
	var new_dir = directions[v_dir]
	if new_dir != self.dir:
		self.dir = new_dir
		play_anim(active_anim)
	pass
