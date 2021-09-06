tool
extends Control


var persistant_dict: Dictionary = {}


func _ready():
	check_for_persistant()


func _on_Button_pressed():
	$VBoxContainer/Label.text = str("output")
	butler_login()


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



func check_for_persistant():
	
	var file2check = File.new()
	var does_file_exist = file2check.file_exists("res://addons/build-and-deploy/persistant.json")
	
	if does_file_exist == true:
		print("loading persistant settings")
	
	else:
		print("no persistant file found")
		print("creating persistant file")
		var persistant = File.new()
		persistant.open("res://addons/build-and-deploy/persistant.json", File.WRITE)
		
		
		
		persistant.close()


func fresh_persistant():
	var blank_persistant_dict: Dictionary = {
		"is logged in": false,
		"directory": "",
		"user": "",
		"game": "",
		"channels": [],
		"async mode": false
	}
	return persistant_dict


func get_export_directory():
	pass
