tool
extends Control


var build_presets = {
	"directory": "",
	"game": "",
	"channels": {
		"Windows": false,
		"Linux": false,
		"Mac": false,
		"HTML5": false
	},
	"async mode": true
}

func _ready():
	print("executable path: ", OS.get_executable_path())

func _on_BuildDialog_dir_selected(dir):
	print("Selected directory: ", dir)
	$VBoxContainer/BuildDir.text = dir


func _on_SelectDir_pressed():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print("Selected directory: ", dir)
	$VBoxContainer/BuildDir.text = dir


func update_presets():
	build_presets["directory"] = $VBoxContainer/BuildDir.text
	build_presets["game"] = $VBoxContainer/Game.text
	build_presets["channels"]["Windows"] = $VBoxContainer/Windows.is_pressed()
	build_presets["channels"]["Linux"] = $VBoxContainer/Linux.is_pressed()
	build_presets["channels"]["Mac"] = $VBoxContainer/Mac.is_pressed()
	build_presets["channels"]["HTML5"] = $VBoxContainer/HTML5.is_pressed()
	build_presets["async mode"] = $VBoxContainer/Async.is_pressed()
	print("build presets updated with: ", build_presets)



