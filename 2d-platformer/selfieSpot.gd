extends Node2D
var carry_velocity := Vector2.ZERO


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		body.get_node("AnimatedSprite2D").play("Selfie")
