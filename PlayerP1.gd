extends CharacterBody2D

@export var jump_impulse = 500.0
@export var gravity = 1000.0
@export var speed = 250.0
@export var istagger = false
@export var player_number: int
var touched_player = false
var tagtimeouton = false
var can_tag = true

@onready var taggerindicator = $taggerindicator

func _ready():
	choose_tagger()
	
func _on_touch_box_body_exited(body: Node2D) -> void:
	if istagger:
		print("tagger set to true for player1")
		can_tag = true

func _physics_process(_delta: float) -> void:
	if istagger == false:
		taggerindicator.visible = false
		speed = 250.0
		jump_impulse = 500.0
	if istagger == true:
		taggerindicator.visible = true
		speed = 275.0
		jump_impulse = 550.0

	#Gravity
	if not is_on_floor():
		velocity.y += gravity * _delta

	#Jump
	if Input.is_action_just_pressed("Jump P" + str(player_number)) and is_on_floor():
		velocity.y = -jump_impulse
		$JumpSound.play()

	#Horizontal movement
	var dir = Input.get_axis("Left P" + str(player_number), "Right P" + str(player_number))
	velocity.x = dir * speed
	
	if Input.is_action_just_pressed("Left P" + str(player_number)):
		$Character.flip_h = true
		
	elif Input.is_action_just_pressed("Right P" + str(player_number)):
		$Character.flip_h = false
	
	move_and_slide()

func choose_tagger():
	var player = RandomNumberGenerator.new().randi_range(0, 1)
	print(player)
	istagger = true

func _on_touch_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("player exited: ", body)
		print('im player', player_number, ', istagger = ', istagger)
	if istagger == true && can_tag:
		can_tag = false
		istagger = false
		body.istagger = true
	#if not istagger and not body.istagger:
		#istagger = true
