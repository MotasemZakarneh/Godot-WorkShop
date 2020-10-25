extends JG
class_name SimpleSaver

"""
Use s_set_var/s_get_var 
to save and get data from the default file, to use a different file
add this node to the node tree and use set_var/get_var
"""

const def_file_name = "SimpleData.dat"
export var file_name = def_file_name
const dir = "user://"

func _ready():
	if not is_in_group("Simple Saver"):
		add_to_group("Simple Saver")
	pass

static func s_set_var(key,val):
	var data = get_data(null)
	data[key] = val
	
	var json_string = Extentions.to_pretty_json(data)
	write_to_file(null,json_string)
	pass

static func s_get_var(key):
	var data = get_data(null)
	if data.size() == 0:
		#print("There Is No Data Stored, Dictionary Is Empty")
		#print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	if not data.keys().has(key):
		#print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	var val = data[key]
	return val

func set_var(key,val):
	var data = get_data(self)
	data[key] = val
	
	var json_string = Extentions.to_pretty_json(data)
	write_to_file(self,json_string)
	pass

func get_var(key):
	var data = get_data(self)
	
	if data.size() == 0:
		#print("There Is No Data Stored, Dictionary Is Empty")
		#print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	if not data.keys().has(key):
		#print ("SimpleSaver Does Not Contain Key :: " + key)
		return null
	
	var val = data[key]
	return val

func safe_get_var(key,def_val):
	var v = get_var(key)
	if v == null:
		set_var(key,def_val)
		v = def_val
	return v

static func write_to_file(inst,json_string):
	var file_path = get_file_path(inst)
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_string(json_string)
	file.close()
	pass

static func get_data(inst):
	var file_path = get_file_path(inst)
	var data = {} 
	
	var file = File.new()
	if not file.file_exists(file_path):
		return data
	
	var er = file.open(file_path,File.READ)
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

static func get_file_path(inst):
	var f = def_file_name
	
	if inst!=null:
		f = inst.file_name
	
	return dir.plus_file(f)
