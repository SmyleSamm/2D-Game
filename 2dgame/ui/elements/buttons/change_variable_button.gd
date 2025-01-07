extends Button

@export var parent: Node
@export var variableName: String = ""
@export var buttonName: String = "name does not exists"

func _ready() -> void:
	text = buttonName
	
func _on_pressed() -> void:
	if variableName in parent:
		parent.set(variableName, true)
