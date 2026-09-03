extends Node2D
@onready var TP1 = $TeleporterPh
@onready var TP2 = $TeleporterPh2
@onready var TP3 = $TeleporterPh3
@onready var TP4 = $TeleporterPh4
@onready var TeleporterTimer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TP1.visible = false
	TP2.visible = false
	TP3.visible = false
	TP4.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LL"):
		teleporter_appear()

func teleporter_appear():
	var teleporterRNG = RandomNumberGenerator.new()
	var teleporters = [TP1, TP2, TP3, TP4]
	var teleporterA
	var index = teleporterRNG.randf_range(0, round(len(teleporters)))
	teleporterA = teleporters[index]
	teleporters.remove_at(index)
	teleporterRNG = RandomNumberGenerator.new()
	var teleporterB
	index = teleporterRNG.randf_range(0, round(len(teleporters)))
	teleporterB = teleporters[index]
	print(teleporterA, teleporterB)
	teleporterA.visible = true
	teleporterB.visible = true

func _on_teleporter_timer_timeout() -> void:
	TP1.visible = false
	TP2.visible = false
	TP3.visible = false
	TP4.visible = false
