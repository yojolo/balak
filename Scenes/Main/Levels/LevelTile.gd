extends Node2D

const GROUND_SAND = 0
const GROUND_FOREST = 1

export var tile_size = 50

export var ground_type = 0

# The sum should always be 100
const probabilityTable = [40, 10, 10, 10, 10, 9, 5, 2, 2, 2]

func setGroundType(t):
	ground_type = t

func getTileNumber():
	var tempTable = []
	for iProb in 10:
		var prob = probabilityTable[iProb]
		for i in prob:
			tempTable.append(iProb)
	return tempTable[randi()%100]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.region_rect.size.x = tile_size
	$Sprite.region_rect.size.y = tile_size
	$Sprite.region_rect.position.x = getTileNumber() * tile_size
	$Sprite.region_rect.position.y = ground_type * tile_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
