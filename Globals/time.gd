extends Node

@export var year: int = 2102
@export var elapsed_year: int = 0
@export var month: int = 1
@export var day: int = 1
@export var hour: int = 6
@export var minute: int = 0


@onready var minute_timer: Timer = $MinuteTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if minute == 60:
		hour += 1
		minute = 0
	if hour == 24:
		minute = 0
		day += 1
	if day == 28:
		month += 1
		day = 1
		

func _on_minute_timer_timeout() -> void:
	minute += 1
	update_clock()
	
func update_clock() -> void:
	%Hours.text = str(hour)
	%Minutes.text = str(minute / 10) + "0"
