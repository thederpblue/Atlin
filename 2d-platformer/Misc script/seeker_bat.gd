extends CharacterBody2D

var stunTime = 0

func _physics_process(delta: float) -> void:
	velocity *= 0.9
	stunTime -= delta
	var goal = get_tree().current_scene.get_node("Player").get_node("player").global_position
	if goal.distance_to(global_position) < 150 and stunTime < 0:
		global_position = global_position.move_toward(goal, delta * 50)
	move_and_slide()
	

func _on_kill_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player" and stunTime < 0:
		body.velocity = Vector2.ZERO
		body.respawn()
		


func _on_hit_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		print("stunned")
		velocity.y = 200
		stunTime = 1
		body.velocity.y = -300
