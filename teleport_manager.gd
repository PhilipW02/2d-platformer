extends Node2D

var teleporter_a: Node2D
var teleporter_b: Node2D
var teleporter_rng = RandomNumberGenerator.new()

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.visible = false
	teleporter_disappear()
	print(find_children("CollisionShape2D"))
 
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LL"):
		teleporter_disappear()

func timer():
	await get_tree().create_timer(randi_range(5, 15)).timeout
	teleporter_appear()

func teleporter_appear():
	# TPX = Teleporter appear points
	# teleporter_a/B = which 2 teleporters that appear
	var teleporters = get_children()
	teleporters.shuffle()

	teleporter_a = teleporters[0]
	teleporter_b = teleporters[1]
	teleporter_a.visible = true
	teleporter_b.visible = true
	
	teleporter_a.teleporter_entered.connect(teleporter_entered)
	teleporter_b.teleporter_entered.connect(teleporter_entered)

func teleporter_entered(teleporter: Node2D, player: CharacterBody2D):
	if teleporter == teleporter_a:
		player.global_position = teleporter_b.global_position
	else:
		player.global_position = teleporter_a.global_position
	
	teleporter_a.disconnect("teleporter_entered", teleporter_entered)
	teleporter_b.disconnect("teleporter_entered", teleporter_entered)
	teleporter_disappear()

func teleporter_disappear() -> void:
	for child in get_children():
		child.hide()
	timer()
