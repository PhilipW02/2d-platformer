extends CharacterBody2D

@export var jump_impulse = 500.0
@export var gravity = 1000.0
@export var speed = 250.0
@export var istagger = false
@export var player_number: int
#var touched_player = false
#var tagtimeouton = false
var can_tag = false

var _player: CharacterBody2D
@onready var taggerindicator = $taggerindicator

# Tagger Interaction	
func tag(player: CharacterBody2D):
	if not istagger:
		return
		
	self.istagger = false
	var timer = Timer.new()
	self.add_child(timer)
	timer.wait_time = 1
	timer.timeout.connect(func(): player.istagger = true)
	timer.start()
	
func _on_touch_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") && istagger:
		print("")
		print("player exited: ", body)
		_player = body

func _on_touch_box_body_exited(_body: Node2D) -> void:
	if istagger:
		can_tag = true
		if _body == _player:
			_player._player = null
			tag(_player)
		print("tagger set to true for player1")
		_body.istagger = false
	else:
		can_tag = false
		
# Movement	
func _physics_process(_delta: float) -> void:
	if istagger == false:
		taggerindicator.visible = false
		speed = 250.0
		jump_impulse = 500.0
	if istagger == true:
		taggerindicator.visible = true
		speed = 262.5
		jump_impulse = 525.0

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
