extends Area2D

var type = 'Rock'

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Rock_body_entered(body):
	if ('type' in body):
		if (body.has_method('pickUpRock')):
			body.pickUpRock(self)