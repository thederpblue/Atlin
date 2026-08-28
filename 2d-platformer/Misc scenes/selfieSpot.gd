extends Node2D
var carry_velocity := Vector2.ZERO
var collected = false
@onready var cam = get_node("CamaraSprite")
func _ready():
	if Saver.collectableCollected.has(ScreenHolder.currentScreenNum):
		cam.self_modulate = Color(0.306, 0.306, 0.306, 0.5)

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player" and collected == false:
		collected == true
		cam.animating = true
		if !Saver.collectableCollected.has(ScreenHolder.currentScreenNum):
			Saver.collectableCollected.append(ScreenHolder.currentScreenNum)
			Saver.saveGame()
		body.get_node("AnimatedSprite2D").play("Selfie")
		body.stunned = true
		var tween = create_tween()
		tween.tween_property(cam,"position:y",cam.position.y - 25, 1.0)
		await get_tree().create_timer(1).timeout
		cam.play("take_photo")
		await get_tree().create_timer(2.3).timeout
		cam.visible = false
		body.stunned = false
		body.get_node("AnimatedSprite2D").play("Idle")
