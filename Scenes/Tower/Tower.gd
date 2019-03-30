extends StaticBody2D

export var life = 5
var type = 'Tower'
export var number_ennemy_close = 0
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
	
func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseButton:
	var rotation = get_global_transform().get_rotation()
	var position = get_position()


func on_body_enter_OuterShpere(body):
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close+=1
	pass

func on_body_exit_OuterShpere(body):
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close-=1