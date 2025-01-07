extends Control

const FILEPATH = "res://scenes/"

@export var nextScene: String = "game"
@export var customFilePath: String = FILEPATH

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if FILEPATH != customFilePath:
			if ResourceLoader.exists(customFilePath+nextScene+".tscn"):
				get_tree().change_scene_to_file(customFilePath+nextScene+".tscn")
				return
			else:
				print(customFilePath+nextScene+".tscn does not exist!")
				return
		if ResourceLoader.exists("res://scenes/"+nextScene+".tscn"):
			get_tree().change_scene_to_file("res://scenes/"+nextScene+".tscn")
			return
		else:
			print("res://scenes/"+nextScene+".tscn does not exist!")
			return
