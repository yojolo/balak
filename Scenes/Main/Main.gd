extends Node2D

var WalkingPlayerScene = preload("res://Scenes/WalkingPlayer/WalkingPlayer.tscn")
var Tower = preload("res://Scenes/Tower/Tower.tscn")
var EnnemyScene = preload("res://Scenes/Ennemy/Ennemy.tscn")

var tower;
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
	player = WalkingPlayerScene.instance()
	player.connect("hit", self, "on_Player_Hit")
	tower = Tower.instance()
	tower.connect("shoot", self, "on_Tower_shoot")
	var middle = screen_size
	middle.x /= 2
	middle.y /= 2
	tower.position = middle
	var playerPos = middle;
	playerPos.x += 50
	player.position = playerPos
	add_child(player)
	add_child(tower)
	
func on_Player_Hit():
	gameOver();
	
func gameOver():
	player.queue_free();
	
func on_Tower_shoot(Bullet, rotation, position):
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.set_rotation(rotation)
	add_child(bullet)

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
			position.y = -50
		else:
			#Bottom
			position.y = screen_size.y + 50
		position.x = randi() % int(screen_size.x + 100) - 50
	else:
		if (sens == 0):
			position.x = -50
			#Left
		else:
			#Right
			position.y = screen_size.x + 50
		position.y = randi() % int(screen_size.y +100) - 50
	ennemy.position = position
	ennemy.setTarget(tower.position)
	add_child(ennemy)
