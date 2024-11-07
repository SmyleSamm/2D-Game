extends StaticBody2D

const WOODDROPS = 5
const STICKDROPS = 2
var playerInside
var player
var hp = 5
@onready var timer = $Timer
@onready var stump_scene = preload("res://tree_stump.tscn")
#check if player is in InRange
#check if player is clicking in the InRange 

func _on_area_2d_body_entered(body: Node):
	if body is CharacterBody2D:
		self.playerInside = true
		self.player = body

func _on_area_2d_body_exited(body: Node):
	if is_queued_for_deletion():
		return
	if body is CharacterBody2D:
		self.playerInside = false

func _on_area_2d_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):
	if self.playerInside:
		if event is InputEventMouse:
			if(event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
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
	self.player.WOOD += WOODDROPS
	self.player.printTrees()
	takeDamage()

func _on_timer_timeout() -> void:
	getWood()
