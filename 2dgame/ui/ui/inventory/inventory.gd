extends ColorRect

@export var player: CharacterBody2D

@onready var button1: Button = $Button1
@onready var button2: Button = $Button2
@onready var button3: Button = $Button3

@onready var stage1: ColorRect = $Stage1
@onready var stage2: ColorRect = $Stage2
@onready var stage3: ColorRect = $Stage3

var currentStage = 1

func _ready() -> void:
	
	hide()
	
	var stages = getStages()
	for i in stages:
		if str(1) in i.name:
			i.show()
		else:
			i.hide()
		
func updateInventory() -> void:
	if player:
		var playerInv = player.inventory
		for items in playerInv:
			var name = items[0]
			var value = items[1]
			var labelPath = "Stage1/Content/Label_"+name
			var label: Label = get_node(labelPath) as Label
			if label:
				label.text = str(value)
				
func getStages() -> Array:
	var stages = []
	var children = get_children()
	for i in children:
		if "Stage" in i.name:
			stages.append(i)
	return stages
	
func switchStage(stage: int) -> void:
	currentStage = stage
	var stages = getStages()
	for i in stages:
		if str(stage) in i.name:
			i.show()
		else:
			i.hide()

func _on_button_1_pressed() -> void:
	if currentStage == 1:
		return 
	switchStage(1)


func _on_button_2_pressed() -> void:
	if currentStage == 2:
		return 
	switchStage(2)

func _on_button_3_pressed() -> void:
	if currentStage == 3:
		return 
	switchStage(3)
