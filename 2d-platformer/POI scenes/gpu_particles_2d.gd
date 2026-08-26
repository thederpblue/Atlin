extends GPUParticles2D


var timeEnabled = 0

func _process(delta: float) -> void:
	if emitting:
		timeEnabled += delta
		process_material.scale = 100 / timeEnabled
	else:
		timeEnabled = 0
