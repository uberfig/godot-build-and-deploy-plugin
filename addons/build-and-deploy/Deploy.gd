tool
extends Control

var butler_path = "butler"

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
	OS.execute(butler_path, args, async_mode, output)


func butler_logout(async_mode:= false):
	var output = []
	var array = ["logout"]
	var args = PoolStringArray(array)
	OS.execute(butler_path, args, async_mode, output)


func butler_push(directory: String, user: String, game: String, channel: String, async_mode:= false):
	 #channel is the slot the game is uploaded to, for example windows-beta
	
	var output = []
	var array = ["push", str(directory), str(user, "/", game, ":", channel)]
	var args = PoolStringArray(array)
	OS.execute(butler_path, args, async_mode, output)


func _on_Login_pressed():
	butler_login()


func _on_Logout_pressed():
	butler_logout()


func update_presets():
	presets_dict["directory"] = $ScrollContainer/VBoxContainer/BuildDir.text
	presets_dict["user"] = $ScrollContainer/VBoxContainer/User.text
	presets_dict["game"] = $ScrollContainer/VBoxContainer/Game.text
	presets_dict["channels"]["Windows"] = $ScrollContainer/VBoxContainer/Windows.is_pressed()
	presets_dict["channels"]["Linux"] = $ScrollContainer/VBoxContainer/Linux.is_pressed()
	presets_dict["channels"]["Mac"] = $ScrollContainer/VBoxContainer/Mac.is_pressed()
	presets_dict["channels"]["HTML5"] = $ScrollContainer/VBoxContainer/HTML5.is_pressed()
	presets_dict["async mode"] = $ScrollContainer/VBoxContainer/Async.is_pressed()
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

