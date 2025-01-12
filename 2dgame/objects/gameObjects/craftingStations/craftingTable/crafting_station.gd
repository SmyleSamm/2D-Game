extends StaticBody2D

@export var player: CharacterBody2D
var isInside:bool = false

var craftingAmounts

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var crafting_station_ui: Control = $CanvasLayer/CraftingStationUI

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
		var nodes = crafting_station_ui.get_children()
		
		#I know how CraftingUI is structured so this is going down the path
		#If any changes are made to CraftingStationUI verify this code again!
		var craftingNodes
		for n in nodes:
			if "ScrollContainer" in n.name:
				craftingNodes = n.get_children()[1].get_children()
		if craftingNodes == null:
			printerr(name," Code:C0001")
			return 
		if craftingNodes.size() == 0:
			printerr(name," Code:B0001")
			return
		for n in craftingNodes:
			n.player = player
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		isInside = false
		label.hide()
		if crafting_station_ui.visible:
			player.handelUIRequest(crafting_station_ui)
			
func _process(delta: float) -> void:
	if not isInside:
		return
	handelInteraciton()
	
func handelInteraciton() -> void:
	if Input.is_action_just_pressed("Interact"):
		player.handelUIRequest(crafting_station_ui)
