tool
extends Control


var presets_dict: Dictionary = {
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


func _ready():
#	check_for_persistant()
	pass


func butler_login(async_mode:= false):
	var output = []
	var array = ["login"]
	var args = PoolStringArray(array)
	OS.execute("butler", args, async_mode, output)


func butler_logout(async_mode:= false):
	var output = []
	var array = ["logout"]
	var args = PoolStringArray(array)
	OS.execute("butler", args, async_mode, output)


func butler_push(directory: String, user: String, game: String, channel: String, async_mode:= false):
	 #channel is the slot the game is uploaded to, for example windows-beta
	
	var output = []
	var array = ["push", str(directory), str(user, "/", game, ":", channel)]
	var args = PoolStringArray(array)
	OS.execute("butler", args, async_mode, output)


func _on_Login_pressed():
	butler_login()


func _on_Logout_pressed():
	butler_logout()


func _on_SelectDir_pressed():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print("Selected directory: ", dir)
	$VBoxContainer/BuildDir.text = dir


func _on_ItchPush_pressed():
	presets_dict["directory"] = $VBoxContainer/BuildDir.text
	presets_dict["user"] = $VBoxContainer/User.text
	presets_dict["game"] = $VBoxContainer/Game.text
	presets_dict["channels"]["Windows"] = $VBoxContainer/Windows.is_pressed()
	presets_dict["channels"]["Linux"] = $VBoxContainer/Linux.is_pressed()
	presets_dict["channels"]["Mac"] = $VBoxContainer/Mac.is_pressed()
	presets_dict["async mode"] = $VBoxContainer/Async.is_pressed()
	print("started deploy with presets: ", presets_dict)
	
	if presets_dict["channels"]["Windows"] == true:
		butler_push(
			presets_dict["directory"], 
			presets_dict["user"], 
			presets_dict["game"], 
			"windows",
			presets_dict["async mode"]
		)
	
	if presets_dict["channels"]["Linux"] == true:
		butler_push(
			presets_dict["directory"], 
			presets_dict["user"], 
			presets_dict["game"], 
			"linux-universal",
			presets_dict["async mode"]
		)
	
	if presets_dict["channels"]["Mac"] == true:
		butler_push(
			presets_dict["directory"], 
			presets_dict["user"], 
			presets_dict["game"], 
			"osx-universal",
			presets_dict["async mode"]
		)



