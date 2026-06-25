extends Sprite2D
#@onready var playerp1 = $Player1
#@onready var playerp2 = $Player2

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func tagged(tagger, player):
	tagger.istagger = false
	player.istagger = true

#ass
