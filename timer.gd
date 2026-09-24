extends Node2D

var minutes = 2
var seconds = 10
#Called when the node enters the scene tree for the first time.

func _ready() -> void:
	write_to_scoreboard(minutes, seconds)

#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print($Timer.time_left)
	#$Numb1.frame = 0
	#$Numb2.frame = 4
	#$Numb3.frame = 0
	#$Numb4.frame = 1

#If statements
func write_to_scoreboard(minutes: float, seconds: float):
	#$Numb3.frame = minutes
	var seconds_str = str(seconds)

	#if seconds > 9:
		#$Numb2.frame = int(seconds_str[0])
		#$Numb1.frame = int(seconds_str[1])
	#else:
		#$Numb2.frame = 0
		#$Numb1.frame = int(seconds_str[0])

func _on_timer_timeout() -> void:
	seconds -= 1
	if minutes == 0 and seconds == 0:
		return

	write_to_scoreboard(minutes, seconds)
	if seconds == 0:
		seconds = 60
		minutes -= 1
		#print(minutes)
