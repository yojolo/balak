extends CanvasLayer

signal start_game
signal stop_game

var score
var life
var ammo
var start_Ammo = 5
var start_life = 3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Start.show()
	$MessageLabel.show()
	$AmmunitionLabel.hide()
	$ScoreLabel.hide()
	$HeartLabel.hide()
	$GameOver.hide()
	$NoAmmo.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	score = 0
	life = start_life
	ammo = start_Ammo
	$Start.hide()
	$MessageLabel.hide()
	$AmmunitionLabel.show()
	$ScoreLabel.show()
	$HeartLabel.show()
	emit_signal('start_game')
	$GameOver.hide()
	
func stop():
	$GameOver.show()
	$GameOver/Score.set_text(str(score))
	$Start.show()
	
func remove_life():
	life -= 1
	if (life == 0):
		emit_signal('stop_game')
	$HeartLabel/Label.set_text(str(life) + '/' + str(start_life))
		
func shoot(BulletScene, rotation, position):
	ammo -= 1
	$AmmunitionLabel/Label.set_text(str(ammo) + '/' + str(start_Ammo))

func no_ammo():
	print('test')
	$NoAmmo.show()
	$NoAmmo/AnimationPlayer.play('outOfAmmo')
	$NoAmmo/Timer.start()

func ennemy_killed(ennemy):
	score += ennemy.value
	$ScoreLabel/Score.set_text(str(score))
	
