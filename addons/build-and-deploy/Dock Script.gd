tool
extends Control


onready var deploy_presets: Dictionary = $Deploy.presets_dict
var plugin_persistant_data = "res://addons/build-and-deploy/persistant.save"


var blank_presets_dict: Dictionary = {
	"is logged in": false,
	"directory": "",
	"user": "",
	"game": "",
	"channels": {
		"Windows": false,
		"Linux": false,
		"Mac": false
	},
	"async mode": false
}


func save_build_presets():
	var file = File.new()
	file.open(plugin_persistant_data, File.WRITE)
	file.store_var(deploy_presets)
	file.close()


func load_build_presets():
	var file = File.new()
	if file.file_exists(plugin_persistant_data):
		file.open(plugin_persistant_data, File.READ)
		deploy_presets = file.get_var(deploy_presets)
		file.close()
	else:
		deploy_presets = blank_presets_dict
		
		file.open(plugin_persistant_data, File.READ)
		deploy_presets = file.get_var(blank_presets_dict)
		file.close()


func _ready():
	load_build_presets()
