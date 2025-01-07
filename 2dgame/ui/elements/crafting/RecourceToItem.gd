extends Control

var player
var value = 0
var increasementValue = 1

@export var recourcesNeeded: Dictionary[String, int]
@export var craftetItemsRecieved: Dictionary[String, int]

@export var spriteOfRecource: Texture2D
@export var spriteOfItem: Texture2D

@onready var count: Label = $HBoxContainer2/count
@onready var text_1: Label = $HBoxContainer/text1
@onready var text_2: Label = $HBoxContainer/text2
@onready var sprite_1: TextureRect = $HBoxContainer/Sprite1
@onready var sprite_2: TextureRect = $HBoxContainer/Sprite2
@onready var sprite_3: TextureRect = $HBoxContainer2/Sprite3

func _ready() -> void:
	var text1Key = recourcesNeeded.keys()[0]
	var text2Key = craftetItemsRecieved.keys()[0]
	text_1.text = str(recourcesNeeded[text1Key])
	text_2.text = str(craftetItemsRecieved[text2Key])
	count.text = str(0)
	sprite_1.texture = spriteOfRecource
	sprite_2.texture = spriteOfItem
	sprite_3.texture = spriteOfItem

func getFirstDicKey(dic: Dictionary[String, int]) -> String:
	return str(dic.keys()[0])

func getFirstDicValue(dic: Dictionary[String, int]) -> int:
	var key = getFirstDicKey(dic)
	return int(dic[key])
	
func set_player(play: CharacterBody2D) -> void:
	player = play

func getCost() -> int: 
	return int(getFirstDicValue(recourcesNeeded))
	
func updateCountLabel() -> void: 
	count.text = str(value)
	
func _on_increase_pressed() -> void:
	if not player:
		return
	var canCraft = true
	for item in recourcesNeeded:
		if player.getItemCount(item) < (value + increasementValue) * getCost():
			canCraft = false
	if canCraft:
		value += increasementValue
		updateCountLabel()

func _on_decrease_pressed() -> void:
	if not player:
		return
	if value >= increasementValue:
		value -= increasementValue
		updateCountLabel()
		
func _on_craft_pressed() -> void:
	if not player:
		return
	for item in recourcesNeeded:
		player.changeInventory(item, -value*getCost())
	for item in craftetItemsRecieved:
		print(item, value)
		player.changeInventory(item, value)
	value = 0
	updateCountLabel()
