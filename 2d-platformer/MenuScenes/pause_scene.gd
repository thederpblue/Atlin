extends Control
var paused = false

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://MenuScenes/select_level.tscn")


func _on_exit_button_down() -> void:
	Saver.saveGame()
	get_tree().quit()


func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://MenuScenes/options.tscn")



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
			paused = ! paused
	if paused:
		visible = true
	else:
		visible = false
