extends Node2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	var time = RandomNumberGenerator.new().randf_range(12, 40)
	timer.set_wait_time(time)
	timer.start()
	
func _on_timer_timeout() -> void:
	spawn_plant()
	queue_free()

func spawn_plant():
	var plant = load("res://plant.tscn")
	if plant == null:
		print("Error loading plant_scene")
		return
	var plantIns = plant.instantiate()
	if plantIns == null:
		print("Error: Failed to instantiate plant instance!")
		return
	plantIns.position = self.position
	get_parent().add_child(plantIns)
