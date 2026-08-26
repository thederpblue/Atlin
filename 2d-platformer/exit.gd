extends Node2D
var carry_velocity := Vector2.ZERO


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		ScreenHolder.carry_velocity = body.velocity
		get_tree().change_scene_to_file(ScreenHolder.screenList[ScreenHolder.currentScreen + 1])
		ScreenHolder.currentScreen += 1
