extends Control

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://screens/level_0.tscn")


func _on_exit_button_down() -> void:
	get_tree().quit()


func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://")
