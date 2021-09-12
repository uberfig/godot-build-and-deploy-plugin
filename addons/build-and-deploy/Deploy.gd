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
		"Mac": false,
		"HTML5": false
	},
	"async mode": true
}


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


func calculator_example(number1, number2):
	var number3 = number1 + number2
	return(number3)



func _on_Login_pressed():
	butler_login()
	print(calculator_example(10, 2))


func _on_Logout_pressed():
	butler_logout()


func _on_SelectDir_pressed():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print("Selected directory: ", dir)
	$VBoxContainer/BuildDir.text = dir


func update_presets():
	presets_dict["directory"] = $VBoxContainer/BuildDir.text
	presets_dict["user"] = $VBoxContainer/User.text
	presets_dict["game"] = $VBoxContainer/Game.text
	presets_dict["channels"]["Windows"] = $VBoxContainer/Windows.is_pressed()
	presets_dict["channels"]["Linux"] = $VBoxContainer/Linux.is_pressed()
	presets_dict["channels"]["Mac"] = $VBoxContainer/Mac.is_pressed()
	presets_dict["channels"]["HTML5"] = $VBoxContainer/HTML5.is_pressed()
	presets_dict["async mode"] = $VBoxContainer/Async.is_pressed()
	print("presets updated with: ", presets_dict)


func _on_ItchPush_pressed():
	update_presets()
	print("started deploy with presets: ", presets_dict)
	
	if presets_dict["channels"]["Windows"] == true:
		butler_push(
			str(presets_dict["directory"], "/windows"), 
			presets_dict["user"], 
			presets_dict["game"], 
			"windows",
			presets_dict["async mode"]
		)
	
	if presets_dict["channels"]["Linux"] == true:
		butler_push(
			str(presets_dict["directory"], "/linux"), 
			presets_dict["user"], 
			presets_dict["game"], 
			"linux-universal",
			presets_dict["async mode"]
		)
	
	if presets_dict["channels"]["Mac"] == true:
		butler_push(
			str(presets_dict["directory"], "/mac"), 
			presets_dict["user"], 
			presets_dict["game"], 
			"osx-universal",
			presets_dict["async mode"]
		)
	
	if presets_dict["channels"]["HTML5"] == true:
		butler_push(
			str(presets_dict["directory"], "/html5"), 
			presets_dict["user"], 
			presets_dict["game"], 
			"html5",
			presets_dict["async mode"]
		)

