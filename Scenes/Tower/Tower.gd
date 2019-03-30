extends StaticBody2D

export var life = 5
var type = 'Tower'
export number_ennemy_close = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	look_at(mouse_position)


func on_body_enter_OuterShpere():
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close++


func on_body_exit_OuterShpere():
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close--
