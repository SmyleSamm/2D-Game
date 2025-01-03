extends Control

var player
var value = 0
var increasementValue = 1

@export var recources: Array = []
@export var craftetItems: Array = []
@export var cost: int = 10

@export var text1: String = str(10)
@export var text2: String = str(1)
@export var sprite1: Texture2D
@export var sprite2: Texture2D

@export var spriteWidth: int = 16
@export var spriteHeight: int = 16

@onready var count: Label = $HBoxContainer3/HBoxContainer2/count
@onready var text_1: Label = $HBoxContainer3/HBoxContainer/text1
@onready var text_2: Label = $HBoxContainer3/HBoxContainer/text2
@onready var sprite_1: TextureRect = $HBoxContainer3/HBoxContainer/Sprite1
@onready var sprite_2: TextureRect = $HBoxContainer3/HBoxContainer/Sprite2
@onready var sprite_3: TextureRect = $HBoxContainer3/HBoxContainer2/Sprite3

func _ready() -> void:
	var recourceSprite
	var craftedSprite
	text_1.text = text1
	text_2.text = text2
	count.text = str(0)
	sprite_1.texture = sprite1
	sprite_2.texture = sprite2
	sprite_3.texture = sprite2

func set_player(play: CharacterBody2D) -> void:
	player = play

func updateCountLabel() -> void: 
	count.text = str(value)
	
func _on_increase_pressed() -> void:
	if not player:
		return
	var canCraft = true
	for item in recources:
		if player.getItemCount(item) < (value + increasementValue) * cost:
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
	for item in recources:
		player.changeInventory(item, -value*cost)
	for item in craftetItems:
		player.changeInventory(item, value)
	value = 0
	updateCountLabel()
