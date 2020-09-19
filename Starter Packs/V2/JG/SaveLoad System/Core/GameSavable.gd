extends SaveLoadSystem
class_name GameSavable

enum SavableType {GameSave,SettingsSave}
export(SavableType) var savable_type = SavableType.GameSave

func _ready():
	var group = Extentions.get_key_of_enum(savable_type,SavableType)
	if not is_in_group(group):
		add_to_group(group)
	pass 

func capture_state() -> Dictionary:
	return {}

func restore_state(state:Dictionary):
	pass

func get_id()->String:
	return str(get_path())
