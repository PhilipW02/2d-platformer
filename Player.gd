extends CharacterBody2D

@export var jump_impulse = 400.0
@export var gravity = 980.665
@export var speed = 240.0
@export var player_number: int
@onready var taggerindicator = $taggerindicator
@onready var character_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var explode_character = $Explosion
@onready var AirTimer = $AirTimer

var istagger = false:
	set(value):
		istagger = value
		if taggerindicator:
			taggerindicator.visible = value
var can_tag = true
var can_jump = true

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
			
func _on_coyote_timer_timeout():
	can_jump = false
	
# Movement	
func _physics_process(_delta: float) -> void:		
	if can_jump == false and is_on_floor():
		can_jump = true
		
	if istagger == false:
		taggerindicator.visible = false
	if istagger == true:
		taggerindicator.visible = true

	#Gravity
	
	if not is_on_floor():
		velocity.y += gravity * _delta

	var jump_buffer = AirTimer.time_left > 0 and is_on_floor()
	
	#Jump
	if (Input.is_action_just_pressed("Jump P" + str(player_number))) and can_jump or jump_buffer:
		velocity.y = -jump_impulse
		$JumpSound.play()
		can_jump = false
	
	#JumpBuffer
	if Input.is_action_just_pressed("Jump P" + str(player_number)) and not is_on_floor():
		AirTimer.start()
		
	#CoyoteTimer
	if (is_on_floor() == false) and can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()
		
	#Horizontal movement
	var dir = Input.get_axis("Left P" + str(player_number), "Right P" + str(player_number))
	velocity.x = dir * speed
	
	if Input.is_action_just_pressed("Left P" + str(player_number)):
		$AnimatedSprite2D.flip_h = true
		
	elif Input.is_action_just_pressed("Right P" + str(player_number)):
		$AnimatedSprite2D.flip_h = false
	
	_set_animation(dir)
	
	move_and_slide()
		
	# Self-Destruct (Debug)
	if Input.is_action_just_pressed("SD P" + str(player_number)):
		print("funny")
		explode_character.play("default")
		$Explosion/Boom.play()
	
func _set_animation(_dir):
	if velocity.y < 0:
		character_animation.play("jump")
	elif velocity.y > 0:
		character_animation.play("fall")
	elif velocity.x > 0 && is_on_floor() || velocity.x < 0 && is_on_floor():
		character_animation.play("run")
	else:
		character_animation.play("idle")
