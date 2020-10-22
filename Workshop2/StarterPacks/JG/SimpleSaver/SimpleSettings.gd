extends SimpleSaver
class_name SimpleSettings

enum languages {en,ar}
export (languages) var active_lang = languages.en
export var sfx_vol = 0.85
export var music_vol = 0.65

func get_sfx_vol():
	return safe_get_var("SFX Vol",sfx_vol)

func get_music_vol():
	return safe_get_var("Music Vol",music_vol)

func get_lang():
	return safe_get_var("Lang",active_lang)

func update_data():
	set_var("SFX Vol",sfx_vol)
	set_var("Music Vol",music_vol)
	set_var("Lang",active_lang)
	pass
