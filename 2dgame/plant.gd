extends Node2D

var player 
@onready var audio: AudioStreamPlayer2D = $Area2D/AudioStreamPlayer2D
var sound = preload("res://assets/sounds/tap.wav")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null

func _process(delta: float) -> void:
	if player:
		if Input.is_action_just_pressed("Interact"):
			player.changeInventory("Rope", 5)
			audio.stream = sound
			audio.play()
			spawn_plant()
			queue_free()

func spawn_plant():
	var plant = load("res://harvested_plant.tscn")
	if plant == null:
		print("Error loading plant_scene")
		return
	var plantIns = plant.instantiate()
	if plantIns == null:
		print("Error: Failed to instantiate plant instance!")
		return
	plantIns.position = self.position
	get_parent().add_child(plantIns)
