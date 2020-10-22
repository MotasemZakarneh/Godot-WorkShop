extends TopDownISO
class_name IsoCharaAnimator

"""
This Script does not effect the parent, instead it looks for an AnimatedSprite
in the siblings, and it simply does nothing, it requires, another script.
to drive it and control it, in other words, calling the public functions
the ones that, do not start with _

Note: Leave the active_anim_set to empty so it palys defaults.

Note 2: _anims_sets is a resources File, that is of type: CharaAnimSet

Note 3: SpriteSheets are the only thing supported now.

Note 4: SpriteSheets must be named in this Pattern

CharaName_AnimSet_AnimName.extention
for example:
MC_Sword_Walk is an animation Sprite Sheet for the character MC
with the Set of Sword, (example sword walk, sword run, sword attack)
and at the end is the animation name, this one is Walk.

Note 5: SpriteSheets, Must Contain All Needed Directions Of A Single Animation
The Directions For All SpriteSheets must be ordered the same as the const Array

"""

var v_dir = Vector2()
var active_anim = ""
var sprite : AnimatedSprite
var dir = ""
var active_anim_set = ""
var anims_sets = []
var chara_name = ""

const directions = {
	Vector2.RIGHT : "Right",Vector2.LEFT:"Left",Vector2.UP:"Up",Vector2.DOWN:"Down",
	Vector2.ONE :"BotRight",Vector2(-1,1):"BotLeft",
	-Vector2.ONE:"TopLeft",Vector2(1,-1):"TopRight"
}

func _ready():
	sprite = get_parent().get_node("AnimatedSprite")
	pass

#Must be called at the moment the character spawns, so we build the animations
func setup_anims(_chara_name,_anims_sets):
	self.chara_name = _chara_name
	self.anims_sets = _anims_sets
	
	var s : SpriteFrames = Extentions.get_sprite_frames_all(anims_sets)
	sprite.frames = s
	pass

#Changes, the active animations Set
func set_active_anim_set(new_set):
	active_anim_set = new_set
	pass

#Tries To Play An Animation
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

#Facing Direction, Must Be Continiously Updated
func update_dir(new_v_dir:Vector2):
	v_dir = new_v_dir
	v_dir = Extentions.make_one(v_dir)
	var new_dir = directions[v_dir]
	if new_dir != self.dir:
		self.dir = new_dir
		play_anim(active_anim)
	pass
