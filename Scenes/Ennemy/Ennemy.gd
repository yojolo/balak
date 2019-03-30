extends KinematicBody2D

signal hit_tower
signal killed

var type = 'Ennemy'
export var speed= 100
export (Vector2) var target
var player
var value = 10
var moving = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setTarget(targetToSet):
	target = targetToSet
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving == false:
		$AnimationPlayer.play('Win')
		return
	$AnimationPlayer.play('Walk')

	var rotation
	if (player != null):
		rotation = player.position.angle_to_point(get_position())
	else:
		rotation = target.angle_to_point(get_position())
	var velocity = Vector2()  # The player's movement vector.
	velocity.x = 1;
	velocity = velocity.rotated(rotation)
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if (collision):
		if ('type' in collision.collider):
			if (collision.collider.type == 'Tower'):
				queue_free()
				emit_signal('hit_tower')
		else:
    		velocity = velocity.slide(collision.normal)


func _on_Area2D_body_entered(body):
	if ('type' in body):
		if (body.type == 'WalkingPlayer'):
			player = body

func _on_Area2D_body_exited(body):
	if ('type' in body):
		if (body.type == 'WalkingPlayer'):
			player = null

func kill():
	$DeathAudioStream.play()
	emit_signal("killed", self)
	queue_free()

func stop_moving():
	moving = false
	