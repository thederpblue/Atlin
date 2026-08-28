extends AnimatedSprite2D

var animating = false

var t = 0

var baseY

func _ready():
	baseY = position.y

func _process(delta: float) -> void:
	if !animating:
		t += delta
		position.y = baseY + sin(t*4)
