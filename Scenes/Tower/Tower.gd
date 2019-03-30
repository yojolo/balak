extends StaticBody2D

signal shoot
signal out_of_ammo

var BulletScene = preload("res://Scenes/Objects/Bullet.tscn")

var type = 'Tower'
export var number_ennemy_close = 0
export var ammunition_number = 5 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	$Top.look_at(mouse_position)
	
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if (event.is_pressed() == false):
			if (ammunition_number > 0):
				$AnimationPlayer.play('Shoot')
				$ShootAudioStream.play()
				ammunition_number -= 1 
				var rotation = $Top.get_rotation()
				var position = get_position()
				emit_signal('shoot', BulletScene, rotation, position)
			else:
				emit_signal('out_of_ammo')
	


func on_body_enter_OuterShpere(body):
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close+=1
	pass

func on_body_exit_OuterShpere(body):
	if ('type' in body):
		if (body.type == 'Ennemy'):
			number_ennemy_close-=1
			
func reload(number): 
	ammunition_number += number