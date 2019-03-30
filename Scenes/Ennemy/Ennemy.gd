extends KinematicBody2D

var type = 'Ennemy'
export var speed= 100
export (Vector2) var target
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTarget(targetToSet):
	target = targetToSet
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotation
	if (player != null):
		rotation = player.position.angle_to_point(get_position())
	else:
		rotation = target.angle_to_point(get_position())
	var velocity = Vector2()  # The player's movement vector.
	velocity.x = 1;
	velocity = velocity.rotated(rotation)
	velocity = velocity.normalized() * speed
	move_and_collide(velocity * delta)


func _on_Area2D_body_entered(body):
	if ('type' in body):
		print('WalkingPlayer' == body.type)
		if (body.type == 'WalkingPlayer'):
			player = body

func _on_Area2D_body_exited(body):
	if ('type' in body):
		if (body.type == 'WalkingPlayer'):
			player = null
