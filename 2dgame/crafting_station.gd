extends StaticBody2D

@export var player: CharacterBody2D
var isInside = false

var craftingAmounts = {
	"Planks": 0,
	"Strings": 0
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var crafting_station_ui: CanvasLayer = $crafting_station_UI
@onready var label: Label = $Label

func _ready() -> void:
	crafting_station_ui.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not player:
		if body.name == "Player":
			player = body
	if body == player:
		isInside = true
		label.show()
		animation_player.play("text")
		var parent = get_node("crafting_station_UI/ColorRect")
		var nodes = parent.get_children()
		var craftingNodes = []
		for n in nodes:
			if "RecourceToItem" in n.name:
				craftingNodes.append(n)
				
		for n in craftingNodes:
			n.player = player
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		isInside = false
		label.hide()
		if crafting_station_ui.visible:
			crafting_station_ui.hide()
			
func _process(delta: float) -> void:
	if not isInside:
		return
	handelInteraciton()
	
func changeVisibility() -> void:
	if crafting_station_ui.visible:
		crafting_station_ui.hide()
	else:
		crafting_station_ui.show()
		
func handelInteraciton() -> void:
	if Input.is_action_just_pressed("Interact"):
		player.handelUIRequest(crafting_station_ui)
