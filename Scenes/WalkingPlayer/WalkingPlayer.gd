extends KinematicBody2D

signal hit
signal rock_pick_up

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var type = 'WalkingPlayer'


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

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
	var collision = move_and_collide(velocity * delta)
	if collision:
		if (collision.collider.type == 'Rock'):
			collision.collider.queue_free()
			emit_signal('rock_pick_up')
		if (collision.collider.type == 'Ennemy'):
			emit_signal('hit')

