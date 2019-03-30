extends Node2D

var WalkingPlayerScene = preload("res://Scenes/WalkingPlayer/WalkingPlayer.tscn")
var EnnemyScene = preload("res://Scenes/Ennemy/Ennemy.tscn")


var player;
var screen_size  # Size of the game window.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	start()

func start():
	print('intanciating')
	player = WalkingPlayerScene.instance()
	player.connect("hit", self, "on_Player_Hit")
	var middle = screen_size
	middle.x /= 2
	middle.y /= 2
	player.position = middle
	add_child(player)
	
func on_Player_Hit():
	print('Player hit')
	gameOver();
	
func gameOver():
	player.queue_free();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var ennemy = EnnemyScene.instance()
	var direction = randi() % 2
	var sens = randi() % 2
	var position = screen_size
	if (direction == 0):
		if (sens == 0):
			#Top
			print('top')
			position.y = 50
		else:
			#Bottom
			print('bottom')
			position.y = screen_size.y - 50
		position.x = randi() % int(screen_size.x -100)
	else:
		if (sens == 0):
			position.x = 50
			#Left
			print('left')
		else:
			#Right
			print('right')
			position.y = screen_size.x - 50
		position.y = randi() % int(screen_size.y -100)
	ennemy.position = position
	add_child(ennemy)
