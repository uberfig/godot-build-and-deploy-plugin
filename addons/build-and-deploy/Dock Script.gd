tool
extends Control


 
var plugin_persistant_data = "res://addons/build-and-deploy/persistant.save"



var blank_presets_dict: Dictionary = {
	"is logged in": false,
	"directory": "",
	"user": "",
	"game": "",
	"channels": {
		"Windows": false,
		"Linux": false,
		"Mac": false,
		"HTML5": false
	},
	"async mode": true
}


func save_build_presets():
	$Deploy.update_presets()
	print("saving deploy presets with: ", $Deploy.presets_dict)
	var file = File.new()
	file.open(plugin_persistant_data, File.WRITE)
	file.store_var($Deploy.presets_dict, true)
	file.close()


func load_build_presets():
	var file = File.new()
	if file.file_exists(plugin_persistant_data):
		file.open(plugin_persistant_data, File.READ)
		$Deploy.presets_dict = Dictionary(file.get_var())
		file.close()
		update_ui()
	else:
		
		file.open(plugin_persistant_data, File.WRITE)
		file.store_var($Deploy.presets_dict, true)
		file.close()


func update_ui():
	var deploy_presets = $Deploy.presets_dict
	print("updating ui with: ", deploy_presets)
	$Deploy/VBoxContainer/User.text = deploy_presets["user"]
	$Deploy/VBoxContainer/Game.text = deploy_presets["game"]
	$Deploy/VBoxContainer/BuildDir.text = deploy_presets["directory"]
	$Deploy/VBoxContainer/Windows.set_pressed(deploy_presets["channels"]["Windows"])
	$Deploy/VBoxContainer/Linux.set_pressed(deploy_presets["channels"]["Linux"])
	$Deploy/VBoxContainer/Mac.set_pressed(deploy_presets["channels"]["Mac"])
	$Deploy/VBoxContainer/HTML5.set_pressed(deploy_presets["channels"]["HTML5"])
	$Deploy/VBoxContainer/Async.set_pressed(deploy_presets["async mode"])


func _ready():
	load_build_presets()


func _on_SavePresets_pressed():
	save_build_presets()
