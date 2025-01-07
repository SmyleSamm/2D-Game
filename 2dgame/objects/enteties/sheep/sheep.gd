extends CharacterBody2D

@onready var timer: Timer = $StateChanger
@onready var growing: Timer = $Growing
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var player
var playerInside
var isWalking: bool
var direction: Vector2
var facingRight: bool
var isFluffy: bool

const SPEED = 20

func _ready() -> void:
	var state = RandomNumberGenerator.new().randi_range(0, 1)
	if state == 0:
		isWalking = false
		idleSetUp()
	else:
		isWalking = true
		walkSetUp()
	z_index = 3
	fluffySetUp()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		playerInside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		playerInside = false
		z_index = 3
		
func checkIfPlayerBehindObject():
	if not player:
		return 
	if player.position.y+239 < position.y:
		z_index = 3
	else:
		z_index = 1

func _process(delta: float) -> void:
	if isWalking:
		if isFluffy:
			animation.play("fluffy_walking")
		else:
			animation.play("walking")
		animation.flip_h = !facingRight
	else:
		if isFluffy:
			animation.play("fluffy_idle")
		else:
			animation.play("idle")
	if playerInside:
		checkIfPlayerBehindObject()
		if Input.is_action_just_pressed("Interact"):
			player.changeInventory("Wool", 5)
			fluffySetUp()

func _physics_process(delta: float) -> void:
	if isWalking:
		var collision_info = move_and_collide(direction * delta * SPEED)
		if collision_info:
			direction = direction.bounce(collision_info.get_normal())
			facingRight = direction[0] >= 0

func fluffySetUp() -> void:
	isFluffy = false
	var fluffyTime = RandomNumberGenerator.new().randi_range(60, 120)
	growing.set_wait_time(fluffyTime)
	growing.start()

func idleSetUp() -> void:
	var idleTime = RandomNumberGenerator.new().randi_range(5, 10)
	timer.set_wait_time(idleTime)
	timer.start()
	
func walkSetUp() -> void:
	var xdi = RandomNumberGenerator.new().randf_range(-1,1)
	var ydi = RandomNumberGenerator.new().randf_range(-1,1)
	direction = Vector2(xdi, ydi)
	facingRight = xdi >= 0
	
	var walkTime = RandomNumberGenerator.new().randi_range(10, 20)
	timer.set_wait_time(walkTime)
	timer.start()

func _on_growing_timeout() -> void:
	isFluffy = true

func _on_state_changer_timeout() -> void:
	isWalking = !isWalking
	if isWalking:
		walkSetUp()
	else:
		idleSetUp()
