extends CharacterBody2D

const SPEED = 80.0
var RUNNING = 1.3
var WOOD = 0

func printTrees():
	print("I have ",WOOD," wood!")
func _physics_process(event):
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	var run = 1
	
	#if shift input -> increase running spead by var RUNNING
	if Input.is_key_pressed(KEY_SHIFT):
		run = RUNNING
		
	#if x input -> increase x velocity and slow down y velocity to disable diagonal movement
	if directionX:
		velocity.x = directionX * SPEED * run
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#if y input -> increase y velocity and slow down x velocity to disable diagonal movement
	elif directionY:
		velocity.y = directionY * SPEED * run
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if no input, slow velocity down
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
