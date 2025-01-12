extends StaticBody2D

@onready var timer = $Timer

func _ready() -> void:
	var time = RandomNumberGenerator.new().randf_range(12, 40)
	timer.set_wait_time(time)
	timer.start()
	
func _on_timer_timeout() -> void:
	#spawn a new tree
	spawn_tree()
	#delete tree stump
	queue_free()

func spawn_tree():
	var tree_scene = load("res://objects/vegetation/trees/normalTree/grown/trees.tscn")
	if tree_scene == null:
		print("Error loading tree_scene")
		return
	var tree_instance = tree_scene.instantiate()
	if tree_instance == null:
		print("Error: Failed to instantiate tree instance!")
		return
	tree_instance.position = self.position
	get_parent().add_child(tree_instance)
