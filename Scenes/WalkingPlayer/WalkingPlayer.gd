extends KinematicBody2D

signal hit
signal tower_reload

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400  # How fast the player will move (pixels/sec).
var type = 'WalkingPlayer'
var maxRocks = 5
var currentCharge = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity


func _physics_process(delta):
	var velocity = get_input()

	if velocity.length() > 0:
		if !$WalkAudioStream.is_playing():
			$WalkAudioStream.play()
	else:
		$WalkAudioStream.stop()

	var collision = move_and_collide(velocity * delta)
	if collision:
		if ('type' in collision.collider):
			if (collision.collider.type == 'Tower'):
				emit_signal('tower_reload', currentCharge)
				currentCharge = 0
			if (collision.collider.type == 'Ennemy'):
				emit_signal('hit')
			if (collision.collider.type == 'Rock'):
				if currentCharge < maxRocks:
					collision.collider.queue_free()
					currentCharge += 1
					emit_signal('rock_pick_up')
		else:
    		velocity = velocity.slide(collision.normal)

