extends Node2D
var carry_velocity := Vector2.ZERO


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		Saver.completedScreens.append(ScreenHolder.currentScreenNum)
		
		ScreenHolder.carry_velocity = body.velocity
		ScreenHolder.currentScreenNum += 1
		ScreenHolder.currentScreenName = "screens/level_" + str(ScreenHolder.currentScreenNum) + ".tscn"
		get_tree().change_scene_to_file(ScreenHolder.currentScreenName)
