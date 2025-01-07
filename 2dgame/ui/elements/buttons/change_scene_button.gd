extends Button

const FILEPATH = "res://scenes/"

@export var nextScene: String = "game"
@export var customFilePath: String = FILEPATH
@export var buttonName: String = "name does not exist"

func _ready() -> void:
	text = buttonName
	
func _on_pressed() -> void:
	if FILEPATH != customFilePath:
		if ResourceLoader.exists(customFilePath+nextScene+".tscn"):
			get_tree().change_scene_to_file(customFilePath+nextScene+".tscn")
			return
		else:
			print(customFilePath+nextScene+".tscn is a customFilePath and does not exist!")
			return
	if ResourceLoader.exists(FILEPATH+nextScene+".tscn"):
		get_tree().change_scene_to_file(FILEPATH+nextScene+".tscn")
		return
	elif nextScene == "EXIT":
		get_tree().quit()
		return
	else:
		print(FILEPATH+nextScene+".tscn is the standardFilePath and does not exist!")
		return
