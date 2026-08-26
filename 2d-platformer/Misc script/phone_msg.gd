extends Node2D

var inArea = false
var player = null

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		player = body
		inArea = true


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		inArea = false

func _process(delta):
	if player != null:
		if inArea and player.is_on_floor():
			player.lookingAtPhone = true
			get_node("CanvasLayer/Control/Sprite2D").visible = true
		else:
			player.lookingAtPhone = false
			get_node("CanvasLayer/Control/Sprite2D").visible = false
