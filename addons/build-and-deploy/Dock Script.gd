tool
extends Control

 
var plugin_persistant_data = "res://addons/build-and-deploy/persistant.save"


var persistant_dict = {
	"Deploy": {},
	"QuickDeploy": {}
}


#var blank_presets_dict: Dictionary = {
#	"is logged in": false,
#	"directory": "",
#	"user": "",
#	"game": "",
#	"channels": {
#		"Windows": false,
#		"Linux": false,
#		"Mac": false,
#		"HTML5": false
#	},
#	"async mode": true
#}


func save_build_presets():
	$TabBox/Deploy.update_presets()
	$TabBox/QuickDeploy.update_presets()
#	$Build.update_presets()
	print("saving deploy presets with: ", $TabBox/Deploy.presets_dict)
	persistant_dict["Deploy"] = $TabBox/Deploy.presets_dict
	persistant_dict["QuickDeploy"] = $TabBox/QuickDeploy.presets_dict
#	persistant_dict["Build"] = $Build.build_presets
	var file = File.new()
	file.open(plugin_persistant_data, File.WRITE)
	file.store_var(persistant_dict, true)
	file.close()


func load_build_presets():
	var file = File.new()
	if file.file_exists(plugin_persistant_data):
		file.open(plugin_persistant_data, File.READ)
		persistant_dict = Dictionary(file.get_var())
#		$Build.build_presets = persistant_dict["Build"]
		$TabBox/Deploy.presets_dict = persistant_dict["Deploy"]
		$TabBox/QuickDeploy.presets_dict = persistant_dict["QuickDeploy"]
		file.close()
		update_ui()
	else:
#		persistant_dict["Build"] = $Build.build_presets
		persistant_dict["Deploy"] = $TabBox/Deploy.presets_dict
		persistant_dict["QuickDeploy"] = $TabBox/QuickDeploy.presets_dict
		file.open(plugin_persistant_data, File.WRITE)
		file.store_var(persistant_dict, true)
		file.close()


func update_ui():
	var deploy_presets = $TabBox/Deploy.presets_dict
	print("updating ui with: ", deploy_presets)
	$TabBox/Deploy/ScrollContainer/VBoxContainer/User.text = deploy_presets["user"]
	$TabBox/Deploy/ScrollContainer/VBoxContainer/Game.text = deploy_presets["game"]
	$TabBox/Deploy/ScrollContainer/VBoxContainer/BuildDir.text = deploy_presets["directory"]
	$TabBox/Deploy/ScrollContainer/VBoxContainer/Windows.set_pressed(deploy_presets["channels"]["Windows"])
	$TabBox/Deploy/ScrollContainer/VBoxContainer/Linux.set_pressed(deploy_presets["channels"]["Linux"])
	$TabBox/Deploy/ScrollContainer/VBoxContainer/Mac.set_pressed(deploy_presets["channels"]["Mac"])
	$TabBox/Deploy/ScrollContainer/VBoxContainer/HTML5.set_pressed(deploy_presets["channels"]["HTML5"])
	$TabBox/Deploy/ScrollContainer/VBoxContainer/Async.set_pressed(deploy_presets["async mode"])
	
	var Quickdeploy_presets = $TabBox/QuickDeploy.presets_dict
	print("updating ui with: ", deploy_presets)
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/User.text = Quickdeploy_presets["user"]
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/Game.text = Quickdeploy_presets["game"]
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/BuildDir.text = Quickdeploy_presets["directory"]
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/Channel.text = Quickdeploy_presets["channel"]
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/Async.set_pressed(Quickdeploy_presets["async mode"])
	
#	var Build_presets = $Build.build_presets
#	print("updating ui with: ", Build_presets)
#	$Build/VBoxContainer/Game.text = Build_presets["game"]
#	$Build/VBoxContainer/BuildDir.text = Build_presets["directory"]
#	$Build/VBoxContainer/Windows.set_pressed(Build_presets["channels"]["Windows"])
#	$Build/VBoxContainer/Linux.set_pressed(Build_presets["channels"]["Linux"])
#	$Build/VBoxContainer/Mac.set_pressed(Build_presets["channels"]["Mac"])
#	$Build/VBoxContainer/HTML5.set_pressed(Build_presets["channels"]["HTML5"])
#	$Build/VBoxContainer/Async.set_pressed(Build_presets["async mode"])


func _ready():
	load_build_presets()


func _on_SavePresets_pressed():
	save_build_presets()


func _on_SelectDir_pressed():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print("Selected directory: ", dir)
	$TabBox/Deploy/ScrollContainer/VBoxContainer/BuildDir.text = dir


func _on_QuickSelectDir_pressed():
	$QuickFile.popup()


func _on_QuickFile_dir_selected(dir):
	print("Selected directory: ", dir)
	$TabBox/QuickDeploy/ScrollContainer/VBoxContainer/BuildDir.text = dir



