extends CharacterBody2D

const SPEED = 100.0

func _physics_process(event):
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	var sprint = 1
	if Input.is_key_pressed(KEY_SHIFT):
		sprint = 2
	#if x input -> increase x velocity and slow down y velocity to disable diagonal movement
	if directionX:
		velocity.x = directionX * SPEED * sprint 
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#if y input -> increase y velocity and slow down x velocity to disable diagonal movement
	elif directionY:
		velocity.y = directionY * SPEED * sprint
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#if no input, slow velocity down
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
