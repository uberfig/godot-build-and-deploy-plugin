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


func build_prject(game: String, channel: String, async_mode:= false):
	var output = []
	var array = ["--export", str(channel), str(game)]
	var args = PoolStringArray(array)
	OS.execute(OS.get_executable_path(), args, async_mode, output)



func _on_Build_pressed():
	update_presets()
	if build_presets["channels"]["Windows"] == true:
		build_prject(
			build_presets["game"], 
			"Windows Desktop",
			build_presets["async mode"]
		)
	
	if build_presets["channels"]["Linux"] == true:
		build_prject(
			build_presets["game"], 
			"Linux/X11",
			build_presets["async mode"]
		)
	
	if build_presets["channels"]["Mac"] == true:
		build_prject( 
			build_presets["game"], 
			"Mac OSX",
			build_presets["async mode"]
		)
	
	if build_presets["channels"]["HTML5"] == true:
		build_prject(
			build_presets["game"], 
			"HTML5",
			build_presets["async mode"]
		)


