extends Camera2D

var player = null

@onready var shape = get_parent().get_node("Area2D/CollisionShape2D")
@onready var pos = shape.global_position
@onready var size = shape.scale
@onready var cam_size = get_viewport_rect().size / 3

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		
		player = body

func _process(delta: float) -> void:
	print(cam_size)
	if player != null:
		var goal = player.global_position
		var futurePos = global_position.move_toward(goal, delta * 200)
		if futurePos.x + (cam_size.x/2) <= pos.x + (size.x/2) and futurePos.x - (cam_size.x/2) >= pos.x - (size.x/2):
			global_position.x = futurePos.x
		if futurePos.y + (cam_size.y/2) <= pos.y + (size.y/2) and futurePos.y - (cam_size.y/2) >= pos.y - (size.y/2):
			global_position.y = futurePos.y
