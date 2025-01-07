extends StaticBody2D

const WOODDROPS = 5
const STICKDROPS = 2
var playerInside
var player
var hp = 5

@onready var timer = $Timer
@onready var stump_scene = preload("res://scenes/tree_stump.tscn")
@onready var tree: Sprite2D = $Tree

func checkIfPlayerBehindTree():
	if player.position.y < position.y-4:
		tree.z_index = 2
	else:
		tree.z_index = 0

func _on_area_2d_body_entered(body: Node):
	if player:
		if body == player:
			self.playerInside = true
			checkIfPlayerBehindTree()
			return
	if body.name == "Player":
		self.player = body
		self.playerInside = true
		checkIfPlayerBehindTree()
			
func _on_area_2d_body_exited(body: Node):
	if is_queued_for_deletion():
		return
	if body == player:
		self.playerInside = false
		tree.z_index = 2 
		
func _process(delta: float) -> void:
	if playerInside:
		checkIfPlayerBehindTree()
			
func _on_area_2d_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):
	if self.playerInside:
		if event is InputEventMouse:
			if(event.is_pressed() and Input.is_action_just_pressed("left_click")):
				if self.timer.is_stopped():
					self.timer.start()
				
func takeDamage():
	self.hp -= 1
	if self.hp<=0:
		spawn_stump()
		queue_free()
		
func spawn_stump():
	var stump_instance = stump_scene.instantiate()
	stump_instance.position = self.position
	get_parent().add_child(stump_instance)

func getWood():
	if is_queued_for_deletion():
		return
	self.player.changeInventory("Wood",5)
	takeDamage()

func _on_timer_timeout() -> void:
	getWood()
