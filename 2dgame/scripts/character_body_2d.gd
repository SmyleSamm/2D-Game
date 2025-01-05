extends CharacterBody2D

@onready var inventoryUI: ColorRect = $UI/Inventory
@onready var esc_menu: Control = $"UI/ESC Menu"

const SPEED: float = 80.0
var RUNNING: float = 1.3
var WOOD: int= 0
var inventory = [
	["Wood", 1000],
	["Rope", 1000],
	["Strings", 1000],
	["Plank", 1000],
	["Wool", 1000],
	["Paper", 1000]
]

var runs: int = 0
var facingRight: int = 1
var direction = 0

var isWalking: bool 

#UI relevant variables
var isUIOpen: int = false
#should be currentUI: Control <- because crafting_station_UI is a CanvasLayer?!?!?!
var currentUI: Control

func getItemCount(name: String) -> int:
	for item in inventory:
		if item[0] == name:
			return item[1]
	return -1
	
func changeInventory(name: String, value: int) -> void:
	for i in range(len(inventory)-1):
		if inventory[i][0] == name:
			inventory[i][1] += value
			return
	inventory.append([name, value])
	
func _physics_process(event):
	var run = 1
	
	#if shift input -> increase running spead by var RUNNING
	if Input.is_key_pressed(KEY_SHIFT):
		run = RUNNING
		
	var input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * SPEED * run
	runs = run
	direction = input_direction
	isWalking = velocity != Vector2(0, 0)
	
	move_and_slide()

func _process(delta: float) -> void:
	facingDirection()
	animation() 
	handelPlayerInput()
	
func facingDirection() -> void:
	if direction[0] > 0:
		facingRight = 1
	elif direction[0] < 0:
		facingRight = -1
		
func animation() -> void:
	var animation = $AnimatedSprite2D
	if isWalking:
		animation.play("walking")
		if runs > 1:
			animation.speed_scale = 1.4
		else:
			animation.speed_scale = 1
	else:
		animation.play("idle")
		animation.speed_scale = 1
	animation.scale.x = facingRight

func canOpenNewUI() -> bool:
	return !currentUI and !isUIOpen
	
#should be ui: Control <- because crafting_station_UI is a CanvasLayer?!?!?!
func openUI(ui: Control) -> void:
	ui.show()
	currentUI = ui
	isUIOpen = true
	
#should be ui: Control <- because crafting_station_UI is a CanvasLayer?!?!?!
func closeUI(ui: Control) -> void:
	ui.hide()
	currentUI = null
	isUIOpen = false
	
#should be ui: Control <- because crafting_station_UI is a CanvasLayer?!?!?!
func changeUI(ui: Control) -> void:
	ui.hide()
	currentUI = ui.befor
	currentUI.show()
	
#should be passedUI: Control <- because crafting_station_UI is a CanvasLayer?!?!?!
func handelUIRequest(passedUI: Control) -> void:
	if canOpenNewUI():
		openUI(passedUI)
		return
	elif currentUI == passedUI:
		closeUI(passedUI)
		return
func handelPlayerInput() -> void:
	if Input.is_action_just_pressed("ESC"):
		if isUIOpen:
			if "befor" in currentUI:
				changeUI(currentUI)
				return
			closeUI(currentUI)
		else:
			openUI(esc_menu)
	if Input.is_action_just_pressed("Inventory"):
		inventoryUI.updateInventory()
		handelUIRequest(inventoryUI)
