extends Node
var currentScreenNum = 0
var currentScreenName = "level_0"
var carry_velocity = Vector2.ZERO
var timerIsRunning = false
var tempTimer = 0
var permTimer = 0

func _process(delta: float) -> void:
	if timerIsRunning:
		tempTimer += delta
		permTimer += delta
