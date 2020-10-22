extends SimpleComponent
class_name LocalizedText

export(String,FILE,"*.json") var file_name
export var key = ""
var all_tables = []


func _ready():
	all_tables = Extentions.read_file(file_name)
	pass

func get_text(_key,lang):
	return Extentions.get_localized_text(all_tables,_key,lang)
