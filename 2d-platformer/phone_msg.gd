extends Node2D

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		body.lookingAtPhone = true
		get_node("Sprite2D").visible = true


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		body.lookingAtPhone = false
		get_node("Sprite2D").visible = false
