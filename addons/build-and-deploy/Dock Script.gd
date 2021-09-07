tool
extends Control


var persistant_dict: Dictionary = {
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



func butler_push(directory: String, user: String, game: String, channel: String, async_mode:= false):
	 #channel is the slot the game is uploaded to, for example windows-beta
	
	var output = []
	var array = ["push", str(directory), str(user, "/", game, ":", channel)]
	var args = PoolStringArray(array)
	OS.execute("butler", args, async_mode, output)


func _on_Login_pressed():
	butler_login()


func _on_SelectDir_pressed():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print("Selected: ", dir)
	$VBoxContainer/BuildDir.text = dir


func _on_ItchPush_pressed():
	persistant_dict["directory"] = $VBoxContainer/BuildDir.text
	persistant_dict["user"] = $VBoxContainer/User.text
	persistant_dict["game"] = $VBoxContainer/Game.text
	persistant_dict["channels"]["Windows"] = $VBoxContainer/Windows/CheckBox.is_pressed()
	persistant_dict["channels"]["Linux"] = $VBoxContainer/Linux/CheckBox.is_pressed()
	persistant_dict["channels"]["Mac"] = $VBoxContainer/Mac/CheckBox.is_pressed()
	persistant_dict["async mode"] = $VBoxContainer/Async/CheckBox.is_pressed()
	print(persistant_dict)
