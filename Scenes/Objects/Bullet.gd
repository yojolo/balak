extends Area2D

var speed = 400
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	velocity.x = 1
	if velocity.length() > 0:
		velocity = velocity.rotated(get_rotation())
		velocity = velocity.normalized() * speed
	position += velocity * delta


func _on_Area2D_body_entered(body):
	if (body.has_method('kill')):
		body.kill()
		queue_free()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
