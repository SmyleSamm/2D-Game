extends Control

var player: CharacterBody2D

func passPlayer(player: CharacterBody2D) -> void:
	self.player = player

func getFirstDicKey(dic: Dictionary[String, int]) -> String:
	return str(dic.keys()[0])

func getFirstDicValue(dic: Dictionary[String, int]) -> int:
	var key = getFirstDicKey(dic)
	return int(dic[key])
	
func getCost() -> int: 
	return -1

func updateCountLabel() -> void: 
	pass 

func _on_craft_pressed() -> void:
	if not player:
		return
	for item in recourcesNeeded:
		player.changeInventory(item, -value*getCost())
	for item in craftetItemsRecieved:
		print(item, value)
		player.changeInventory(item, value)
	value = 0
	updateCountLabel()

func _on_increase_pressed() -> void:
	if not player:
		return
	var canCraft = true
	for item in recourcesNeeded:
		if player.getItemCount(item) < (value + increasementValue) * getCost():
			canCraft = false
	if canCraft:
		value += increasementValue
		updateCountLabel()
		
func _on_decrease_pressed() -> void:
	if not player:
		return
	if value >= increasementValue:
		value -= increasementValue
		updateCountLabel()
