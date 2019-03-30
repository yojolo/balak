extends Node2D

export (PackedScene) var WalkingPlayer

var player;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    $Timer.connect("timeout", self, "_on_Timer_timeout")
	start()

func start:
	player = WalkingPlayer.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
