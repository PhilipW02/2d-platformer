extends CharacterBody2D

@export var jump_impulse = 500.0
@export var gravity = 1000.0
@export var speed = 250.0
@export var player_number: int
@onready var taggerindicator = $taggerindicator

var istagger = false:
	set(value):
		istagger = value
		if taggerindicator:
			taggerindicator.visible = value
var can_tag = true

# Tagger Interaction	
#func tag(player: CharacterBody2D):
	#if not istagger:
		#return

func get_tagged() -> void:
	istagger = true
	can_tag = false

func _on_touch_box_body_entered(body: Node2D) -> void:
	if body == self:
		return
		
	if body.is_in_group("players"):
		print('im player', player_number, ', istagger = ', istagger)	
		if istagger && can_tag:
			can_tag = false
			istagger = false
			print("Tagger: ", body.name)
			if body.has_method("get_tagged"):
				body.get_tagged()
		
func _on_touch_box_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		if istagger:
			print("Tagger ready to tag again.")
			can_tag = true
		
# Movement	
func _physics_process(_delta: float) -> void:
	if istagger == false:
		taggerindicator.visible = false
		speed = 125.0
		jump_impulse = 400.0
	if istagger == true:
		taggerindicator.visible = true
		speed = 131.25
		jump_impulse = 420.0

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
