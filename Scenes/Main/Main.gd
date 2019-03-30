extends Node2D

var WalkingPlayerScene = preload("res://Scenes/WalkingPlayer/WalkingPlayer.tscn")
var Tower = preload("res://Scenes/Tower/Tower.tscn")
var EnnemyScene = preload("res://Scenes/Ennemy/Ennemy.tscn")
var RockScene = preload("res://Scenes/Objects/Rock.tscn")

var tower;
var player;
var screen_size  # Size of the game window.
var diag = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	diag = sqrt(pow(screen_size.x, 2) + pow(screen_size.y, 2))

func start():
	get_tree().call_group('ennemies', 'queue_free')
	player = WalkingPlayerScene.instance()
	player.connect("hit", self, "on_Player_Hit")
	tower = Tower.instance()
	tower.connect("shoot", self, "on_Tower_shoot")
	tower.connect("out_of_ammo", $hud, "no_ammo")
	tower.connect("shoot", $hud, "shoot")
	player.connect("tower_reload", tower, "reload")
	var middle = screen_size
	middle.x /= 2
	middle.y /= 2
	tower.position = middle
	var playerPos = middle;
	playerPos.x += 50
	player.position = playerPos
	add_child(player)
	add_child(tower)
	$EnnemyTimer.start()
	$RockTimer.start()
	_on_RockTimer_timeout()
	_on_RockTimer_timeout()

func _on_hud_stop_game():
	player.queue_free()
	tower.queue_free()
	$EnnemyTimer.stop()
	$RockTimer.stop()
	get_tree().call_group('ennemies', 'stop_moving')

func on_Player_Hit():
	pass
	
	
func on_Tower_shoot(Bullet, rotation, position):
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.set_rotation(rotation)
	add_child(bullet)


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
	ennemy.connect('killed', self, 'ennemy_killed')
	ennemy.connect('killed', $hud, 'ennemy_killed')
	ennemy.connect('hit_tower', $hud, 'remove_life')
	add_child(ennemy)

func ennemy_killed(ennemy):
	spawn_Rock_at_pos(ennemy.position)

func spawn_Rock_at_pos(position):
	var rock = RockScene.instance()
	rock.position = position
	add_child(rock)

func _on_RockTimer_timeout():
	var rotation = deg2rad(randi() % 361)
	var length = randi() % int(diag/2)
	var position = Vector2()
	position.rotated(rotation)
	position =  position * length
	if position.x < 0 or position.x > screen_size.x:
		return _on_RockTimer_timeout()
	if position.y < 0 or position.y > screen_size.y:
		return _on_RockTimer_timeout()
	spawn_Rock_at_pos(position)


