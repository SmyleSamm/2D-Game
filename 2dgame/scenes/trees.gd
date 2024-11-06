extends StaticBody2D

const WOODDROPS = 5
const STICKDROPS = 2

#check if player is in InRange
#check if player is clicking in the InRange 
func _on_area_2d_body_entered(body: Node):
	if body is CharacterBody2D:
		body.WOOD += WOODDROPS
		body.printTrees()
