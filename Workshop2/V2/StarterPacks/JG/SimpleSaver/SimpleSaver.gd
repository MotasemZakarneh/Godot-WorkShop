extends JG
class_name SimpleSaver

export var file_name = "SimpleData.dat"
const dir = "user://"

func _ready():
	if not is_in_group("Simple Saver"):
		add_to_group("Simple Saver")
	pass

func set_var(key,val):
	var data = get_data()
	data[key] = val
	
	var json_string = Extentions.to_pretty_json(data)
	
	var file = File.new()
	file.open(get_file_path(), File.WRITE)
	file.store_string(json_string)
	file.close()
	pass

func get_var(key):
	var data = get_data()
	
	if data.size() == 0:
		#print("There Is No Data Stored, Dictionary Is Empty")
		print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	if not data.keys().has(key):
		print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	var val = data[key]
	return val

func safe_get_var(key,def_val):
	var v = get_var(key)
	if v == null:
		set_var(key,def_val)
		v = def_val
	return v

func get_data():
	var data = {} 
	
	var file = File.new()
	if not file.file_exists(get_file_path()):
		return data
	
	var er = file.open(get_file_path(),File.READ)
	if er != OK:
		#print(er)
		return data
	
	var json_string : String = file.get_as_text()
	file.close()
	
	if(json_string.length() == 0):
		#print("There is no stored data In File")
		return data
	
	data = parse_json(json_string)
	return data

func get_file_path():
	return dir.plus_file(file_name)
