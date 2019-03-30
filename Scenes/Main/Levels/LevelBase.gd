extends Node2D

var LevelTile = preload("res://Scenes/Main/Levels/LevelTile.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const TILE_SIZE = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	
	var totalColumns = ceil(screen_size.x / TILE_SIZE)+1
	var totalRows = ceil(screen_size.y / TILE_SIZE)+1

	for iColumn in totalColumns:
		for iRow in totalRows:
			var tile = LevelTile.instance()
			tile.setGroundType(0)
			tile.position.x = iColumn * TILE_SIZE
			tile.position.y = iRow * TILE_SIZE
			add_child(tile)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
