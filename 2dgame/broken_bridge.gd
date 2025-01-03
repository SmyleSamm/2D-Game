extends Node2D

@onready var area: Area2D = $Area2D
@onready var bridge = preload("res://bridge.tscn")

var player
var playerInside
var recourceNeeded = [
	["Plank", 10],
	["Strings", 10]
]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if player:
		if body == player:
			playerInside = true
	else:
		if body.name == "Player":
			player = body
			playerInside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		playerInside = false

func handelInteraction() -> void:
	var canComplete = true
	for i in recourceNeeded:
		if player.getItemCount(i[0]) < i[1]:
			canComplete = false
	if canComplete:
		var bridge = bridge.instantiate()
		bridge.position = self.position
		get_parent().add_child(bridge)
		queue_free()
		for i in recourceNeeded:
			player.changeInventory(i[0], -i[1])
		
		
		
func _process(delta: float) -> void:
	if playerInside:
		if Input.is_action_just_pressed("Interact"):
			handelInteraction()
