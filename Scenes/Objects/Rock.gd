extends Area2D

signal rock_pick_up

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rock_body_entered(body):
	hide()
	if (body.type == 'WalkingPlayer'):
		emit_signal('rock_pick_up')
