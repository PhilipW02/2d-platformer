extends Node2D

var teleporter_a: Node2D
var teleporter_b: Node2D
var teleporter_rng = RandomNumberGenerator.new()
var teleport_player: CharacterBody2D
var teleport_start: Vector2
var teleport_target: Vector2
var teleport_time := 0.0
var teleport_duration := 1.0
var teleporting := false
@onready var player1 = %Player1
@onready var player2 = %Player2

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.visible = false
	teleporter_disappear()
	print(find_children("CollisionShape2D"))
 
func _process(_delta: float) -> void:
	# Debug Function
	if Input.is_action_just_pressed("LL"):
		teleporter_disappear()

func _physics_process(delta):
	if not teleporting:
		return

	teleport_time += delta

	var t: float = clamp(teleport_time / teleport_duration, 0.0, 1.0)
	t = smoothstep(0.0, 1.0, t)

	teleport_player.global_position = teleport_start.lerp(teleport_target, t)

	if t >= 1.0:
		teleport_player.global_position = teleport_target
		teleporting = false
		teleport_player.visible = true
		teleporter_disappear()
		teleport_player = null

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
	player1.can_tag = false
	player2.can_tag = false
	teleport_player = player
	teleport_start = player.global_position
	player.visible = false

	if teleporter == teleporter_a:
		teleport_target = teleporter_b.global_position
	else:
		teleport_target = teleporter_a.global_position

	teleport_time = 0.0
	teleporting = true
	
	teleporter_a.disconnect("teleporter_entered", teleporter_entered)
	teleporter_b.disconnect("teleporter_entered", teleporter_entered)

func teleporter_disappear() -> void:
	for child in get_children():
		child.hide()
	timer()
