tool
extends Control


var presets_dict: Dictionary = {
	"is logged in": false,
	"directory": "",
	"user": "",
	"game": "",
	"channel": "",
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


func _on_Login_pressed():
	butler_login()


func _on_Logout_pressed():
	butler_logout()


func update_presets():
	presets_dict["directory"] = $ScrollContainer/VBoxContainer/BuildDir.text
	presets_dict["user"] = $ScrollContainer/VBoxContainer/User.text
	presets_dict["game"] = $ScrollContainer/VBoxContainer/Game.text
	presets_dict["channel"] = $ScrollContainer/VBoxContainer/Channel.text
	presets_dict["async mode"] = $ScrollContainer/VBoxContainer/Async.is_pressed()
	print("presets updated with: ", presets_dict)


func _on_ItchPush_pressed():
	update_presets()
	print("started deploy with presets: ", presets_dict)
	
	butler_push(
		presets_dict["directory"], 
		presets_dict["user"], 
		presets_dict["game"], 
		presets_dict["channel"],
		presets_dict["async mode"]
	)
	
	print("finished deploy")

