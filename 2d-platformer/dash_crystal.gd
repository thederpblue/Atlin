extends Node2D
var currentAnimation

func _ready():
	get_node("AnimatedSprite2D").play("idle")
	currentAnimation = "idle"

	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print(body.name)
	if 	currentAnimation == "idle" and body.name == "player":
		if body.dashes < body.maxDashes:
			body.dashes = body.maxDashes
			get_node("AnimatedSprite2D").play("flash")
			currentAnimation = "flash"
			get_node("AnimatedSprite2D").play("outline")
			currentAnimation = "outline"
			await get_tree().create_timer(2.0).timeout
			get_node("AnimatedSprite2D").play("idle")
			currentAnimation = "idle"

		
		



	


func _on_animated_sprite_2d_animation_finished() -> void:
	get_node("AnimatedSprite2D").play("outline")
	currentAnimation = "outline"
